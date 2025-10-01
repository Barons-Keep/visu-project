///@package io.alkapivo.core
///@description shader_cloudy_sky
 
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


// Shader constants
#define CLOUD_ALPHA 8.0
#define ITERATIONS 8
#define K1 0.366025404
#define K2 0.211324865

const mat2 M = mat2(1.6,  1.2, -1.2, 1.6);


// Varying Outputs
///*
varying vec2 v_texcoord;
varying vec4 v_color;
//*/


// Uniforms
///*
uniform float u_angle;            // Default: 0.0
uniform float u_brightness;       // Default: 1.0
uniform float u_cloud_coverage;   // Default: 0.2
uniform float u_cloud_dark;       // Default: 0.5
uniform float u_cloud_light;      // Default: 0.3
uniform float u_hue;              // Default: 0.0
uniform float u_sat;              // Default: 1.0
uniform float u_seed;             // Default: 0.0
uniform float u_sky_alpha;        // Default: 0.9
uniform float u_speed;            // Default: 0.03
uniform float u_time;             // Default: 0.0, where 1.0=1sec
uniform float u_zoom;             // Default: 1.0
uniform vec2 u_offset;            // Default: (0.5, 0.5)
uniform vec2 u_resolution;        // Default: (GuiWidth(), GuiHeight())
uniform vec3 u_sky_color_bottom;  // Default: (0.2, 0.4, 0.6)
uniform vec3 u_sky_color_top;     // Default: (0.4, 0.7, 1.0)
uniform vec3 u_tint;              // Default: (1.0, 1.0, 1.0)
//*/


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

float get_color_distance(vec3 color_from, vec3 color_to) {
  return distance(color_from, color_to) / SQRT_3;
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
vec2 hash(vec2 p) {
  p = vec2(dot(p, vec2(127.1,311.7)), dot(p, vec2(269.5, 183.3)));
  return -1.0 + 2.0 * fract(sin(p) * 43758.5453);
}

float noise(vec2 p) {
  vec2 cell = floor(p + (p.x + p.y) * K1);
  vec2 offset0 = p - cell + (cell.x + cell.y) * K2;
  vec2 simplex = (offset0.x > offset0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec2 offset1 = offset0 - simplex + K2;
  vec2 offset2 = offset0 - 1.0 + 2.0 * K2;
  vec3 attenuation = max(0.5 - vec3(dot(offset0, offset0), dot(offset1, offset1), dot(offset2, offset2)), 0.0);
  attenuation = attenuation * attenuation * attenuation * attenuation;
  vec3 contribution = attenuation * vec3(dot(offset0, hash(cell + 0.0)), dot(offset1, hash(cell + simplex)), dot(offset2, hash(cell + 1.0)));

  return dot(contribution, vec3(70.0));
}

float fbm(vec2 n, mat2 m) {
  float total = 0.0;
  float amplitude = 0.1;
  for (int i = 0; i < 7; i++) {
    total += noise(n) * amplitude;
    n = m * n;
    amplitude *= 0.4;
  }

  return total;
}


void main() {
//void mainImage(out vec4 fragColor, in vec2 v_texcoord) {
  /*
  vec4 v_color = vec4(1.0);
  float u_angle = 0.0;
  float u_brightness = 1.0;
  float u_cloud_coverage = 0.2;
  float u_cloud_dark = 0.5;
  float u_cloud_light = 0.3;
  float u_hue = 0.0;
  float u_sat = 1.0;
  float u_seed = 0.0;
  float u_sky_alpha = 0.9;
  float u_speed = 0.03;
  float u_time = iTime;
  float u_zoom = 1.0;
  vec2 u_offset = vec2(0.5, 0.5);
  vec2 u_resolution = iResolution.xy;
  vec3 u_sky_color_bottom = vec3(0.2, 0.4, 0.6);
  vec3 u_sky_color_top = vec3(0.4, 0.7, 1.0);
  vec3 u_tint = vec3(1.0, 1.0, 1.0);
  */
  
  float time = (u_time + u_seed) * u_speed;
  float zoom = (u_zoom != 0.0) ? 1.0 / u_zoom : 0.0;

  vec2 uv = zoom * rotated_uv_resolution(v_texcoord, u_resolution, u_offset, u_angle);
  vec2 uv2 = zoom * rotated_uv_resolution(v_texcoord, u_resolution, u_offset, 0.0);
  vec2 uvb = uv;

  float result = fbm(uv * zoom * 0.5, M);

  float noise_riged_shape = 0.0;
  vec2 uv_ridge = uvb * zoom - (result - time);
  float weight = 0.8;
  for (int i = 0; i < ITERATIONS; i++) {
    noise_riged_shape += abs(weight * noise(uv_ridge));
    uv_ridge = M * uv_ridge + time;
    weight *= 0.7;
  }

  float noise_shape = 0.0;
  vec2 uv_shape = uvb * zoom - (result - time);
  weight = 0.7;
  for (int i = 0; i < ITERATIONS; i++) {
    noise_shape += weight * noise(uv_shape);
    uv_shape = M * uv_shape + time;
    weight *= 0.6;
  }
  noise_shape *= noise_riged_shape + noise_shape;

  float noise_color = 0.0;
  float t = time * 2.0;
  vec2 uv_color = uvb * (zoom * 2.0) - (result - t);
  weight = 0.4;
  for (int i = 0; i < ITERATIONS; i++) {
    noise_color += weight * noise(uv_color);
    uv_color = M * uv_color + t;
    weight *= 0.6;
  }

  float noise_ridge_color = 0.0;
  t = time * 3.0;
  vec2 uv_ridge_color = uvb * (zoom * 3.0) - (result - t);
  weight = 0.4;
  for (int i = 0; i < ITERATIONS; i++) {
    noise_ridge_color += abs(weight * noise(uv_ridge_color));
    uv_ridge_color = M * uv_ridge_color + t;
    weight *= 0.6;
  }

  noise_color += noise_ridge_color;
  noise_shape = u_cloud_coverage + CLOUD_ALPHA * noise_shape * noise_riged_shape;

  //vec4 texture = vec4(0.0, 0.0, 0.0, 1.0);
  //vec4 texture = texture(iChannel0, v_texcoord / iResolution.xy);
  vec4 texture = texture2D(gm_BaseTexture, v_texcoord);

  vec3 sky_color = mix(
    mix(u_sky_color_top, u_sky_color_bottom, uv2.y),
    texture.rgb,
    clamp(1.0 - u_sky_alpha - (1.0 - texture.a), 0.0, 1.0)
  );

  vec3 cloud_color = u_tint * clamp(u_cloud_dark + u_cloud_light * noise_color, 0.0, 1.0);
  vec3 color = mix(
    sky_color,
    clamp(0.5 * sky_color + cloud_color, 0.0, 1.0),
    clamp(noise_shape + noise_color, 0.0, 1.0)
  );

  vec3 pixel = apply_hue(apply_saturation(color, u_sat), u_hue) * u_brightness;
  pixel = mix(pixel, texture.rgb, 1.0 - v_color.a);

  //fragColor = vec4(color, 1.0);
  //fragColor = vec4(pixel, texture.a + v_color.a);
  gl_FragColor = vec4(pixel, texture.a + (texture.a * v_color.a));
}
