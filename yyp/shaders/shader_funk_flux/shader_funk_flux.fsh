///@package io.alkapivo.core
///@description shader_funk_flux

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
#define OCTAVES 20.0
#define PERIOD 500.0


// Varying Outputs
varying vec2 v_texcoord;
varying vec4 v_color;


// Uniforms
uniform float u_angle;      // Default: 0.0
uniform float u_bpm;        // Default: 0.0
uniform float u_brightness; // Default: 1.0
uniform float u_density;    // Default: 1.0
uniform float u_hue;        // Default: 0.0
uniform float u_sat;        // Default: 1.0
uniform float u_scale;      // Default: 1.0
uniform float u_seed;       // Default: 0.0
uniform float u_sharp;      // Default: 0.25
uniform float u_speed;      // Default: 10.0
uniform float u_time;       // Default: 0.0, where 1.0=1sec
uniform float u_treshold;   // Default: 1.0
uniform vec2 u_offset;			// Default: (0.5, 0.5)
uniform vec2 u_resolution;  // Default: vec2(GuiWith(), GuiHeight())


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
float get_cos_range(float degrees, float range) {
	return (((1.0 + cos(degrees * DEG_TO_RAD)) * 0.5) * range);
}

float get_sin_range(float degrees, float range) {
	return (((1.0 + sin(degrees * DEG_TO_RAD)) * 0.5) * range);
}

float loop_time(float time) {
  return cos((time - (PI * (PERIOD / 2.0))) / PERIOD) * PERIOD + PERIOD;
}

//void mainImage(out vec4 fragColor, in vec2 v_texcoord) {
void main() {
  /*
  vec4 v_color = vec4(1.0);
  float u_angle = 0.0;
  float u_bpm = 0.0;
  float u_brightness = 1.0;
  float u_density = 1.0;
  float u_hue = 0.0;
  float u_sat = 1.0;
  float u_scale = 1.0;
  float u_seed = 0.0;
  float u_sharp = 0.25;
  float u_speed = 10.0;
  float u_time = iTime;
  float u_treshold = 1.0;
  vec2 u_offset = vec2(0.5, 0.5);
  vec2 u_resolution = vec2(iResolution.xy);
  */

  vec2 uv = rotated_uv_resolution(v_texcoord * u_scale, u_resolution, u_offset, u_angle);
  float bpm = (u_bpm / 60.0) * TAU;
  float time = u_time + u_seed;
  time = loop_time(time + sin(time * bpm));
  float x_scale = get_cos_range(u_time + u_seed, u_speed);
  float y_scale = get_sin_range(u_time + u_seed, u_speed);
  float f_scale = get_cos_range(u_time + u_seed, u_density) + 1.0;
  for (float idx = 1.0; idx < OCTAVES; idx += 1.0) {
    uv.x += u_sharp / idx * sin(idx * uv.y + time) * f_scale + x_scale;		
    uv.y += u_sharp / idx * cos(idx * uv.x + time) * f_scale + y_scale;
  }

  //vec4 texture = vec4(0.0, 0.0, 0.0, 1.0);
  //vec4 texture = texture(iChannel0, v_texcoord / iResolution.xy);
  vec4 texture = texture2D(gm_BaseTexture, v_texcoord);
  vec3 color = vec3(sin(uv.x) * 0.5 + 0.5, cos(uv.y) * 0.5 + 0.5, sin(uv.y) * 0.5 + 0.5);
  vec3 pixel = apply_hue(apply_saturation(color, u_sat), u_hue) * u_brightness;
  float alpha = texture.a == 0.0 ? 0.0 : get_alpha_from_pixel(pixel);
  pixel = mix(pixel, texture.rgb, 1.0 - v_color.a);
  pixel = mix(pixel, texture.rgb, (1.0 - alpha) * (1.0 - u_treshold));
  //fragColor = vec4(color, 1.0);
  //fragColor = vec4(pixel, texture.a + v_color.a);
  gl_FragColor = vec4(pixel, texture.a + (alpha * v_color.a));
}
