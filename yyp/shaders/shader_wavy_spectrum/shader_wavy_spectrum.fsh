///@package io.alkapivo.core
///@description shader_wavy_spectrum

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


// Varying Outputs
varying vec2 v_texcoord;
varying vec4 v_color;


// Uniforms
uniform float u_angle;      // Default: 0.0
uniform float u_brightness; // Default: 1.0
uniform float u_distort;    // Default: 0.1
uniform float u_hue;        // Default: 0.0
uniform float u_noise;      // Default: 3.0
uniform float u_sat;        // Default: 1.0
uniform float u_seed;        // Default: 0.0
uniform float u_scale;      // Default: 3.0
uniform float u_time;       // Default: 0.0, where 1.0=1sec
uniform vec2 u_offset;			// Default: (0.5, 0.5)
uniform vec2 u_resolution;  // Default: vec2(GuiWith(), GuiHeight())
uniform vec3 u_color_a;     // Default: (1.0, 0.0, 0.0)
uniform vec3 u_color_b;     // Default: (0.0, 1.0, 0.0)
uniform vec3 u_color_c;     // Default: (0.0, 0.0, 1.0)
uniform vec3 u_color_mask;  // Default: (0.0, 0.0, 0.0)


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
float hash(vec2 p) {
  return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float noise(vec2 p) {
  vec2 i = floor(p);
  vec2 f = fract(p);

  float a = hash(i);
  float b = hash(i + vec2(1.0, 0.0));
  float c = hash(i + vec2(0.0, 1.0));
  float d = hash(i + vec2(1.0, 1.0));

  vec2 u = f * f * (3.0 - 2.0 * f);
  return mix(a, b, u.x) +
    (c - a) * u.y * (1.0 - u.x) +
    (d - b) * u.x * u.y;
}

float fbm(vec2 p) {
  float f = 0.0;
  f += 0.5000 * noise(p); p *= 2.02;
  f += 0.2500 * noise(p); p *= 2.03;
  f += 0.1250 * noise(p); p *= 2.01;
  f += 0.0625 * noise(p);
  return f;
}

vec3 get_spectrum_color(float position) {
  float t = fract(position); // ensure looping

  if (t < 1.0 / 3.0) {
    float f = t * 3.0;
    return mix(u_color_a, u_color_b, f);
  } else if (t < 2.0 / 3.0) {
    float f = (t - 1.0 / 3.0) * 3.0;
    return mix(u_color_b, u_color_c, f);
  } else {
    float f = (t - 2.0 / 3.0) * 3.0;
    return mix(u_color_c, u_color_a, f);
  }
}

float get_color_distance(vec3 color_from, vec3 color_to) {
  return distance(color_from, color_to) / SQRT_3;
}

void main() {
  vec2 uv = rotated_uv_resolution(v_texcoord * u_scale, u_resolution, u_offset, u_angle);
  float distortion = fbm(uv * u_noise + vec2(0.0, u_time + u_seed)) * u_distort;
  float position = mod(uv.x + distortion + u_time + u_seed, 1.0);

  vec4 texture = texture2D(gm_BaseTexture, v_texcoord);
  vec3 color = get_spectrum_color(position);
  vec3 pixel = apply_hue(apply_saturation(color, u_sat), u_hue) * u_brightness;
  float alpha = clamp(get_color_distance(pixel, u_color_mask), 0.0, 1.0);
  pixel = mix(pixel, texture.rgb, 1.0 - v_color.a);
  pixel = mix(pixel, texture.rgb, 1.0 - alpha);
  gl_FragColor = vec4(pixel, texture.a + (alpha * v_color.a));
}
