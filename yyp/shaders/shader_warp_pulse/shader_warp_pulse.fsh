///@package io.alkapivo.core
///@description shader_warp_pulse

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
#define BEND_INTENSITY 0.15
#define LIGHTNING_BIAS 0.5
#define FBM_OCTAVES 6


// Varying Outputs
varying vec2 v_texcoord;
varying vec4 v_color;


// Uniforms
uniform float u_angle;      // Default: 0.0
uniform float u_brightness; // Default: 1.0
uniform float u_distortion; // Default: 0.2
uniform float u_factor_a;     // Default: 0.1
uniform float u_factor_b;     // Default: 0.9
uniform float u_hue;        // Default: 0.0
uniform float u_sat;        // Default: 1.0
uniform float u_seed;       // Default: 0.0
uniform float u_size;       // Default: 4
uniform float u_time;				// Default: 0.0, where 1.0=1sec
uniform float u_treshold;   // Default: 0.001
uniform vec2 u_offset;			// Default: (0.5, 0.5)
uniform vec2 u_resolution;  // Default: (GuiWidth(), GuiHeight())
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
float noise(vec2 x) {
  return texture2D(gm_BaseTexture, v_texcoord + (x * u_treshold)).x;
}

float fbm(vec2 uv) {
  float amplitude = 2.0;
  float result = 0.0;
  vec2 base_uv = uv;
  for (float idx = 0.0; idx < 6.0; idx += 1.0) {
    result += abs((noise(uv) - 0.5) * 2.0) / amplitude;
    amplitude *= 2.0;
    uv *= 2.0;
  }
  return result;
}

float fbm2(vec2 uv, float t) {
  vec2 uv2 = uv * 0.7; // get two rotated fbm calls and displace the domain
  vec2 basis = vec2(fbm(uv2 - t), fbm(uv2 + t));
  basis = (basis - 0.5) * u_distortion;
  uv += basis;

  return fbm(uv); // coloring
}

float circle(vec2 uv) {
  float radius = length(uv);
  radius = log(sqrt(radius));
  return abs(mod(radius * 4.0 * u_size, PI * 2.0) - 3.15) * 3.0 + 0.2;
}

void main() {
  vec2 uv = rotated_uv_resolution(v_texcoord, u_resolution, u_offset, u_angle);
  float len = length(uv);
  uv *= 4.0;

  float result = fbm2(uv, u_time + u_seed);

  // rings
  uv /= exp(mod((u_time + u_seed + result), PI)); 
  result *= pow(abs((u_factor_a - circle(uv))), u_factor_b);

  vec4 texture = texture2D(gm_BaseTexture, v_texcoord);
  vec3 color = clamp(pow(abs(u_tint / result), vec3(0.99)), 0.0, 1.0);
  vec3 pixel = apply_hue(apply_saturation(color, u_sat), u_hue) * u_brightness;
  float alpha = get_alpha_from_pixel(pixel);
  pixel = mix(pixel, texture.rgb, 1.0 - v_color.a);
  pixel = mix(pixel, texture.rgb, 1.0 - alpha);
  gl_FragColor = vec4(pixel, texture.a + (alpha * v_color.a));
}