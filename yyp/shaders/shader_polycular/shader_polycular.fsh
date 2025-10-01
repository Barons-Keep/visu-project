///@package io.alkapivo.core
///@description shader_polycular

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
#define FACTOR 2.5

// Varying Outputs
varying vec2 v_texcoord;
varying vec4 v_color;


// Uniforms
uniform float u_amount;     // Default: 5.0
uniform float u_angle;      // Default: 0.0
uniform float u_bpm;        // Default: 60.0
uniform float u_brightness; // Default: 1.0
uniform float u_distortion; // Default: 1.0
uniform float u_hue;        // Default: 0.0
uniform float u_intensity;  // Default: 1.2
uniform float u_points;     // Default: 6.0
uniform float u_sat;        // Default: 1.0
uniform float u_seed;       // Default: 0.0
uniform float u_shift;      // Default: 1.0
uniform float u_time;       // Default: 0.0, where 1.0=1sec
uniform float u_treshold;   // Default: 1.5
uniform vec2 u_offset;      // Default: (0.5, 0.5)
uniform vec2 u_resolution;  // Default: (GuiWidth(), GuiHeight())
uniform vec3 u_bkg;         // Default: (1.0, 1.0, 1.0)
uniform vec3 u_tint;        // Default: (1.0, 0.0, 1.0)


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
  float original_hue = atan(y_color.z, y_color.y);
  float final_hue = original_hue + (hue * TAU);
  float chroma = sqrt(y_color.z * y_color.z + y_color.y * y_color.y);
  return vec3(y_color.x, chroma * cos(final_hue), chroma * sin(final_hue)) * yiq2rgb;
}


// Shader methods
vec3 blend_colors(vec3 background_color, vec3 foreground_color, float blend_weight, float intensity) {
  vec3 weighted_background = background_color * blend_weight;
  vec3 weighted_foreground = foreground_color * (intensity - blend_weight);
  return weighted_background + weighted_foreground;
}

float sdf_hex(vec2 p, float amount, float points, float distortion) {
  float length_scaled = length(p) * amount;
  float result = length_scaled + (length_scaled * (0.034 * distortion) * cos(points * atan(p.x, p.y)));
  float factor = 1.0;
  return result * factor;
}

void main() {
//void mainImage(out vec4 fragColor, in vec2 v_texcoord) {
  //float u_amount = 5.0;
  //float u_angle = 0.0;
  //float u_bpm = 60.0;
  //float u_brightness = 1.0;
  //float u_distortion = 1.0;
  //float u_hue = 0.0;
  //float u_intensity = 1.2;
  //float u_points = 6.0;
  //float u_sat = 1.0;
  //float u_seed = 0.0;
  //float u_shift = 1.0;
  //float u_time = iTime;
  //float u_treshold = 1.5;
  //vec2 u_offset = vec2(0.5, 0.5);
  //vec2 u_resolution = iResolution.xy;
  //vec3 u_bkg = vec3(1.0, 1.0, 1.0);
  //vec3 u_tint = vec3(1.0, 0.0, 1.0);
  //vec4 v_color = vec4(1.0);

  float time = (u_time + u_seed) * (u_bpm / 60.0);
    
  vec2 uv = rotated_uv_resolution(v_texcoord, u_resolution, u_offset, u_angle);
  float sdf_value = sdf_hex(uv, u_amount, u_points, u_distortion); 
  float fract_value = fract(sdf_value - time);
  float modifier = (sin(floor(time - sdf_value)) + 1.0) / 2.0;

  vec3 color = apply_hue(u_tint, modifier * u_shift);
  color = blend_colors(u_bkg, color, sqrt(fract_value) / sqrt(sdf_value), u_intensity);
  vec4 texture = texture2D(gm_BaseTexture, v_texcoord);//texture(iChannel0, uv);
  vec3 pixel = apply_hue(apply_saturation(color.rgb, u_sat), u_hue) * u_brightness;
  float alpha = texture.a == 0.0 ? 0.0 : clamp(get_alpha_from_pixel(pixel), 0.0, 1.0);
  float dist = clamp(length(uv), 0.0, 1.0);
  float middle = min(pow(1.0 - dist, FACTOR), alpha) * fract_value + (1.0 - dist * FACTOR);
  middle = clamp(middle * u_treshold, 0.0, 1.0);
  pixel = mix(pixel, texture.rgb, middle);
  pixel = mix(pixel, texture.rgb, 1.0 - v_color.a);
  pixel = mix(pixel, texture.rgb, 1.0 - alpha);
  //fragColor = vec4(pixel, texture.a + (alpha * v_color.a));
  gl_FragColor = vec4(pixel, texture.a + (alpha * v_color.a));
}