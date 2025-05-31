///@package io.alkapivo.core
///@description shader_arc_runner

// Base constants
#define PI 3.14159265359
#define DEG_TO_RAD 0.01745329251

// Shader specific constatns
#define NOISE_DISTORTION_SCALE 1000000.0
#define BEND_INTENSITY 0.15
#define LIGHTNING_BIAS 0.5
#define FBM_OCTAVES 6

// Varying Outputs
varying vec2 v_texcoord;
varying vec4 v_color;

// Uniforms
uniform vec3 u_tint;        // Default: (0.31, 0.5, 0.89)
uniform vec2 u_offset;			// Default: (0.5, 0.5)
uniform float u_time;				// Default: 0.0, where 1.0=1sec
uniform float u_angle;      // Default: 0.0
uniform float u_jumpiness;  // Default: 2.9
uniform float u_distortion; // Default: 0.01
uniform float u_scale;      // Default: 1.5
uniform float u_curves;     // Default: 2.0
uniform float u_brightness; // Default: 1.5
uniform float u_wiggle;     // Default: 2.0

// Base methods
vec2 rotated_uv_resolution(vec2 v_texcoord, vec2 resolution, vec2 origin, float angle_deg) {
  float angle_rad = angle_deg * DEG_TO_RAD;
  float cos_a = cos(angle_rad);
  float sin_a = sin(angle_rad);

  vec2 origin_ndc = (origin * resolution);
  origin_ndc = (origin_ndc * 2.0 - resolution) / resolution.y;

  vec2 coord = (v_texcoord * 2.0 - resolution) / resolution.y;
  coord -= origin_ndc;

  return vec2(
    coord.x * cos_a - coord.y * sin_a,
    coord.x * sin_a + coord.y * cos_a
  );
}

vec2 rotated_uv(vec2 texcoord, vec2 origin, float angle_deg) {
  float angle_rad = angle_deg * DEG_TO_RAD;
  float cos_a = cos(angle_rad);
  float sin_a = sin(angle_rad);

  vec2 origin_ndc = origin * 2.0 - 1.0;
  vec2 coord = texcoord * 2.0 - 1.0;
  coord -= origin_ndc;

  return vec2(
    coord.x * cos_a - coord.y * sin_a,
    coord.x * sin_a + coord.y * cos_a
  );
}

float get_alpha_from_pixel(vec3 pixel) {
  return dot(pixel, vec3(0.2126, 0.7152, 0.0722)); // Luma (ITU-R BT.709)
}

vec4 mix_pixel(vec3 pixel, vec4 texture, vec4 color) {
  float alpha = get_alpha_from_pixel(pixel);
  return vec4(mix(texture.rgb, pixel * color.rgb, color.a * alpha), alpha * color.a * texture.a);
}

// Shader methods
float hash_1d(float x) {
  x = fract(x * 0.1031);
  x *= x + 33.33;
  return abs(0.5 - fract(x * x * 2.0)) * 2.0;
}

float noise_1d(float x) {
  float i = floor(x);
  float f = fract(x);
  f *= f * (3.0 - 2.0 * f);
  return mix(hash_1d(i), hash_1d(i + 1.0), f);
}

float hash_2d(vec2 p) {
  vec3 p3 = fract(p.xyx * 0.1031);
  p3 += dot(p3, p3.yzx + 33.33);
  return fract((p3.x + p3.y) * p3.z);
}

float noise_2d(vec2 p, float distortion) {
  float factor = 1.0 + (distortion / NOISE_DISTORTION_SCALE);
  vec2 i = floor(p) / factor;
  vec2 f = fract(p);

  return mix(
    mix(hash_2d(i), hash_2d(i + vec2(factor, 0.0)), f.x),
    mix(hash_2d(i + vec2(0.0, factor)), hash_2d(i + vec2(factor)), f.x),
    f.y
  );
}

float fbm(vec2 p, int octaves, float distortion) {
  float sum = 0.0;
  float max_amp = 0.0;
  float amplitude = 1.0;

  for (int i = 0; i < octaves; ++i) {
    sum += amplitude * noise_2d(p, distortion);
    max_amp += amplitude;
    amplitude *= 0.5;
    p *= mat2(2.0, 1.0, -1.0, 2.0);
  }

  return sum / max_amp;
}

float lightning_path(vec2 uv, float seed, float jumpiness, float distortion, float scale, float curve_freq, float wiggle) {
  float j = 1.0 + abs(jumpiness);
  float noise_val = fract(noise_1d(seed * (1.0 + wiggle)) * j) * (j / 2.0) - 1.0;
  float bend = noise_val * BEND_INTENSITY;

  bend *= smoothstep(10.0, j, abs(LIGHTNING_BIAS - gl_FragCoord.x) * 1.6);
  uv.y += (j - uv.x * uv.x) * bend;

  uv.x -=u_time * 0.2;

  float displacement = fbm(uv * vec2(curve_freq, curve_freq * 0.66) - vec2(0.0, seed), FBM_OCTAVES, distortion);
  displacement = (displacement * (scale * 2.0) - scale) * 0.5;

  return abs(uv.y - displacement);
}

vec3 lightning_field(vec2 uv, float jumpiness, float distortion, float scale, float curve_freq, float brightness, float wiggle, vec3 tint) {
  float time_offset = u_time * 0.08;

  float d1 = lightning_path(uv, 100.0 + time_offset * 1.0, jumpiness, distortion, scale, curve_freq, wiggle);
  float d2 = lightning_path(uv, 400.0 + time_offset * 1.5, jumpiness, distortion, scale, curve_freq, wiggle);
  float d3 = lightning_path(uv, 300.0 + time_offset * 2.0, jumpiness, distortion, scale, curve_freq, wiggle);
  float d4 = lightning_path(uv, 700.0 + time_offset * 4.0, jumpiness, distortion, scale, curve_freq, wiggle);

  float inverse_sqrt = max(0.0, 1.0 - sqrt(d1 + d2 * d3 + d3 + d4 * d1) * brightness);
  float glow = 0.07 / sqrt(d1 * d2 * d3 * d4);

  vec3 base_color = tint * sqrt(glow);
  float mid_val = 1.0 - inverse_sqrt;
  return base_color * mid_val;
  //vec3 electric_color = base_color * 0.7 + 0.7 * vec3(0.1 * mid_val, 0.3, 0.6) * mid_val * glow;
  //electric_color = mix(electric_color, electric_color * electric_color, min(1.0, pow(inverse_sqrt, 4.0)));
  //return electric_color;
}

void main() {
  vec2 uv = rotated_uv(v_texcoord, u_offset, u_angle);
  vec3 pixel = lightning_field(uv, u_jumpiness, u_distortion, u_scale, u_curves, u_brightness, u_wiggle, u_tint);
  vec4 texture = texture2D(gm_BaseTexture, uv);
  gl_FragColor = mix_pixel(pixel, texture, v_color);
}