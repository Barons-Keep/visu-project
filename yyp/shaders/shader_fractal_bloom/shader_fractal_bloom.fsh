///@package io.alkapivo.core
///@description shader_fractal_bloom

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
#define ITERATIONS 24.0


// Varying Outputs
varying vec2 v_texcoord;
varying vec4 v_color;


// Uniforms
uniform float u_angle;        // Default: 0.0
uniform float u_bpm;          // Default: 0.0
uniform float u_brightness;   // Default: 1.0
uniform float u_contrast;     // Default: 1.5
uniform float u_distortion;   // Default: 1.0
uniform float u_factor;       // Default: 20.0
uniform float u_hue;          // Default: 0.0
uniform float u_neon;         // Default: 1.5
uniform float u_points;       // Default: 5.0
uniform float u_sat;          // Default: 1.0
uniform float u_scale;        // Default: 1.0
uniform float u_seed;         // Default: 0.0
uniform float u_shift;        // Default: 0.0
uniform float u_size;         // Default: 1.0
uniform float u_time;         // Default: 0.0, where 1.0=1sec
uniform vec2 u_base;          // Default: (6.14, 7.36)
uniform vec2 u_offset;        // Default: (0.5, 0.5)
uniform vec2 u_resolution;    // Default: (GuiWidth(), GuiHeight())
uniform vec2 u_rotation;      // Default: (5.0, 15.0)
uniform vec3 u_tint;          // Default: (0.0, 0.0, 0.0)


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

float get_color_distance(vec3 color_from, vec3 color_to) {
  return distance(color_from, color_to) / SQRT_3;
}

float vec2_get_angle(vec2 a, vec2 b) {
  return acos(clamp(dot(a, b), -1.0, 1.0));
}


// Shader methods
vec2 star(vec2 uv, vec2 offset, float sides, float shift) {
  float angle = atan(uv.y, uv.x);
  float y = length(uv);
  angle = ((angle / PI) + 1.0) * 0.5;
  angle = mod(angle, 1.0 / sides) * sides;
  angle = -1.0 * abs((2.0 + shift) * angle - 1.0) + 1.0;
  angle *= y;
  return vec2(angle, y) - offset;
}

vec4 orb(vec2 uv, float size, vec2 position, vec3 color, float contrast) {
  return pow(vec4(size / length(uv + position) * color, 1.0), vec4(contrast));
}

mat2 rotate(float angle) {
  return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}


void main() {
//void mainImage(out vec4 fragColor, in vec2 v_texcoord) {
  /*
  vec4 v_color = vec4(1.0);
  
  float u_angle = 0.0;
  vec2 u_base = vec2(6.14, 7.36);
  float u_bpm = 0.0;
  float u_brightness = 1.0;
  float u_contrast = 1.5;
  float u_factor = 20.0;
  float u_hue = 0.0;
  float u_neon = 1.5;
  float u_sat = 1.0;
  float u_seed = 0.0;
  float u_size = 1.0;
  float u_shift = 0.0;
  float u_time = iTime;
  vec2 u_offset = vec2(0.5, 0.5);
  float u_points = 5.0;
  vec2 u_resolution = iResolution.xy;
  vec2 u_rotation = vec2(5.0, 15.0);
  float u_scale = 1.0;
  vec3 u_tint = vec3(0.0, 0.0, 0.0);
  */
  
  float bpm = (u_bpm / 60.0) * TAU;
  vec2 rotation = u_rotation / 10.0;
  float scale = u_scale / 3.0;
  float time = u_time + u_seed;
  time += sin(time * bpm);
  vec2 uv = rotated_uv_resolution(v_texcoord, u_resolution, u_offset, u_angle) * u_factor;
  float dist = length(uv);
  vec4 color = vec4(u_tint, 0.0);
  uv *= rotate(time * rotation.x);
  uv = star(uv, u_base, u_points, u_shift);
  uv *= rotate(time * rotation.y);
  for (float i = 0.0; i < ITERATIONS; i += 1.0) {
    uv.x += (u_base.x / 10.0) * sin(scale * uv.y + time);
    uv.y -= (u_base.y / 10.0) * cos(scale * uv.x + time);
    float t = i * PI / ITERATIONS * 2.0;
    float x = u_neon * tan(t + time / 10.0);
    float y = u_neon * cos(t - time / 20.0);
    vec2 position = vec2(x, y);
    vec3 result = cos(vec3(2.0, 0.0, -1.0) * TAU / 3.0 + PI * (i / 5.37)) * 0.5 + 0.5;
    color += orb(uv, u_size, position, result, u_contrast);
  }

  color = clamp(color, 0.0, 1.0);
  float angle_rad = vec2_get_angle(v_texcoord, vec2(0.5));
  dist = get_color_distance(vec3(0.0), color.rgb) * (u_distortion / 10.0) * v_color.a;
  vec2 coord = vec2(v_texcoord.x + (cos(angle_rad) * dist), v_texcoord.y + (sin(angle_rad) * dist));

  vec4 texture = texture2D(gm_BaseTexture, coord);//vec4(0.0, 0.0, 0.0, 1.0);//
  vec3 pixel = apply_hue(apply_saturation(color.rgb, u_sat), u_hue) * u_brightness;
  float alpha = texture.a == 0.0 ? 0.0 : get_alpha_from_pixel(pixel);
  pixel = mix(pixel, texture.rgb, 1.0 - v_color.a);
  pixel = mix(pixel, texture.rgb, 1.0 - alpha);
  //fragColor = vec4(pixel, texture.a + (alpha * v_color.a));
  gl_FragColor = vec4(pixel, texture.a + (alpha * v_color.a));
}