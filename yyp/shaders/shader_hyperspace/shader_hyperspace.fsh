///@package io.alkapivo.core
///@description shader_hyperspace

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
#define ITERATIONS 16.0

// Varying Outputs
///*
varying vec2 v_texcoord;
varying vec4 v_color;
//*/


// Uniforms
///*
uniform float u_angle;          // Default: 0.0
uniform float u_brightness;     // Default: 1.0
uniform float u_count;          // Default: 64.0
uniform float u_direction;      // Default: 1.0
uniform float u_hue;            // Default: 0.0
uniform float u_sat;            // Default: 1.0
uniform float u_seed;           // Default: 0.0
uniform float u_size;           // Default: 3.0
uniform float u_speed;          // Default: 5.0
uniform float u_stretch;        // Default: 0.05
uniform float u_time;           // Default: 0.0, where 1.0=1sec
uniform float u_trail;          // Default: 100.0
uniform vec2 u_origin;          // Default: (0.5, 0.5)
uniform vec2 u_resolution;      // Default: (GuiWidth(), GuiHeight())
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
float hyperspace(vec2 uv, float time, float count, float direction, float speed, float trail, float stretch) {
  uv.x = uv.x * count;
  float d1 = fract(uv.x);
  uv.x = floor(uv.x);
  uv.y *= stretch;
  float offset = sin(uv.x);
  float move = abs(cos(uv.x) * 0.5) * sign(direction);
  float result = fract(uv.y + time * speed + offset) * mix(0.0, trail, move);
  result = result != 0.0 ? 1.0 / result : 0.0;
  result = smoothstep(0.0, 1.0, result * result);
  result = sin(result * PI) * (move * 10.0);
  float d2 = sin(d1 * PI);
  return result * (d2 * d2);
}

void main() {
//void mainImage(out vec4 fragColor, in vec2 v_texcoord) {
  /*
  vec4 v_color = vec4(1.0);
  float u_angle = 0.0;
  float u_brightness = 1.0;
  float u_count = 64.0;
  float u_direction = 1.0;
  float u_hue = 0.0;
  float u_sat = 1.0;
  float u_seed = 0.0;
  float u_size = 3.0;
  float u_speed = 5.0;
  float u_trail = 100.0;
  float u_stretch = 0.05;
  float u_time = iTime;
  vec2 u_origin = vec2(0.5, 0.5);
  vec2 u_resolution = iResolution.xy;
  */

  float time = u_time + u_seed;
  float speed = u_speed / 10.0;
  vec2 uv = rotated_uv_resolution(v_texcoord, u_resolution, u_origin, u_angle);
  float dist = length(uv);
  uv = vec2(atan(uv.x, uv.y) / TAU, 2.0 / dist);
  
  vec3 color = vec3(0.0, 0.0, 0.0);
  for (float idx = 1.0; idx <= ITERATIONS; idx += 1.0) {
    if (idx > u_size) {
      break;
    }

    float factor = u_size != 0.0 ? idx / u_size : 0.0;
    float offset = (factor * TAU) / u_size;
    color.r += hyperspace(uv, time + offset + (0.0 / 3.0), idx * u_count, u_direction, speed, u_trail, u_stretch);
    color.g += hyperspace(uv, time + offset + (1.0 / 3.0), idx * u_count * 2.0, u_direction, speed, u_trail, u_stretch);
    color.b += hyperspace(uv, time + offset + (2.0 / 3.0), idx * u_count * 4.0, u_direction, speed, u_trail, u_stretch);
  }
  
  color *= dist;

  //vec4 texture = vec4(0.0, 0.0, 0.0, 1.0);
  //vec4 texture = texture(iChannel0, v_texcoord / u_resolution);
  vec4 texture = texture2D(gm_BaseTexture, v_texcoord);
  vec3 pixel = apply_hue(apply_saturation(color, u_sat), u_hue) * u_brightness;
  float alpha = texture.a == 0.0 ? 0.0 : get_alpha_from_pixel(pixel);
  pixel = mix(pixel, texture.rgb, 1.0 - v_color.a);
  pixel = mix(pixel, texture.rgb, 1.0 - alpha);
  //fragColor = vec4(pixel, texture.a + (alpha * v_color.a));
  gl_FragColor = vec4(pixel, texture.a + (alpha * v_color.a));
}