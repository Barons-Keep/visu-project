///@package io.alkapivo.core
///@description shader_arc_runner

// Base constants
#define PI 3.14159265359
#define TAU 6.28318530718
#define DEG_TO_RAD 0.01745329251
#define SQRT_3 1.732050807568877

const mat3 rgb2yiq = mat3(
  0.299, 0.587, 0.114, 
  0.595716, -0.274453, -0.321263, 
  0.211456, -0.522591, 0.311135
);

const mat3 yiq2rgb = mat3(
  1.0, 0.9563, 0.6210, 
  1.0, -0.2721, -0.6474, 
  1.0, -1.1070, 1.7046
);


// Shader specific constatns
#define NOISE_DISTORTION_SCALE 1000000.0
#define OCTAVES 6


// Varying Outputs
varying vec2 v_texcoord;
varying vec4 v_color;


// Uniforms
uniform float u_angle;      // Default: 0.0
uniform float u_bend;       // Default: 0.15
uniform float u_brightness; // Default: 1.5
uniform float u_curves;     // Default: 2.0
uniform float u_distortion; // Default: 0.01
uniform float u_frequency;  // Default: 1.0
uniform float u_glow;       // Default: 1.0
uniform float u_hue;        // Default: 0.0
uniform float u_jumpiness;  // Default: 2.9
uniform float u_sat;        // Default: 1.0
uniform float u_scale;      // Default: 1.5
uniform float u_seed;       // Default: 0.0
uniform float u_speed;      // Default: 1.0
uniform float u_time;				// Default: 0.0, where 1.0=1sec
uniform float u_wiggle;     // Default: 2.0
uniform vec2 u_offset;			// Default: (0.5, 0.5)
uniform vec2 u_resolution;	// Default: (GuiWidth(), GuiHeight())
uniform vec3 u_tint;        // Default: (0.31, 0.5, 0.89)


// Base methods
vec2 rotated_uv_resolution(vec2 v_texcoord, vec2 resolution, vec2 origin, float angle_deg) {
  v_texcoord *= resolution;
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

vec3 apply_saturation(vec3 color, float saturation) {
  float luma = get_alpha_from_pixel(color);
  return mix(vec3(luma), color, saturation);
}

vec3 apply_hue(vec3 color, float hue) {
  vec3 y_color = color * rgb2yiq;
  float original_hue = atan(y_color.b, y_color.g);
  float final_hue = original_hue + (hue * TAU);
  float chroma = sqrt(y_color.b * y_color.b + y_color.g * y_color.g);
  return vec3(y_color.r, chroma * cos(final_hue), chroma * sin(final_hue)) * yiq2rgb;
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

float fbm(vec2 p, float distortion) {
  float sum = 0.0;
  float max_amp = 0.0;
  float amplitude = 1.0;

  for (int i = 0; i < OCTAVES; ++i) {
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
  float bend = noise_val * u_bend;
  uv.y += (j - uv.x * uv.x) * bend;
  uv.x -= u_seed + (u_time * (0.2 * u_speed));

  float displacement = fbm(uv * vec2(curve_freq, curve_freq * 0.66) - vec2(0.0, seed), distortion);
  displacement = (displacement * (scale * 2.0) - scale) * 0.5;

  return abs(uv.y - displacement);
}

vec3 lightning_field(vec2 uv, float jumpiness, float distortion, float scale, float curve_freq, float brightness, float wiggle, vec3 tint) {
  float time_offset = u_seed + (u_time * (0.08 * u_frequency));

  float d1 = lightning_path(uv, 100.0 + time_offset * 1.0, jumpiness, distortion, scale, curve_freq, wiggle);
  float d2 = lightning_path(uv, 300.0 + time_offset * 1.5, jumpiness, distortion, scale, curve_freq, wiggle);
  float d3 = lightning_path(uv, 600.0 + time_offset * 2.0, jumpiness, distortion, scale, curve_freq, wiggle);
  float d4 = lightning_path(uv, 900.0 + time_offset * 4.0, jumpiness, distortion, scale, curve_freq, wiggle);

  float inverse_sqrt = max(0.0, 1.0 - sqrt(d1 + d2 * d3 + d3 + d4 * d1) * brightness);
  float glow = (u_glow * 0.01) / sqrt(d1 * d2 * d3 * d4);

  vec3 base_color = tint * sqrt(glow);
  float mid_val = 1.0 - inverse_sqrt;
  return base_color * mid_val;
}

void main() {
  vec2 uv = rotated_uv_resolution(v_texcoord, u_resolution, u_offset, u_angle);
  vec4 texture = texture2D(gm_BaseTexture, v_texcoord);
  vec3 color = lightning_field(uv, u_jumpiness, u_distortion, u_scale, u_curves, u_brightness, u_wiggle, u_tint);
  vec3 pixel = apply_hue(apply_saturation(color, u_sat), u_hue);
  float alpha = get_alpha_from_pixel(pixel);
  pixel = mix(pixel, texture.rgb, 1.0 - v_color.a);
  pixel = mix(pixel, texture.rgb, 1.0 - alpha);
  gl_FragColor = vec4(pixel, texture.a + (alpha * v_color.a));
}