///@package io.alkapivo.core
///@description shader_warp_pulse

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
uniform vec2 iResolution;
uniform vec3 u_tint;        // Default: (0.31, 0.5, 0.89)
uniform vec2 u_offset;			// Default: (0.5, 0.5)
uniform float u_time;				// Default: 0.0, where 1.0=1sec
uniform float u_angle;      // Default: 0.0
uniform float u_size;      // Default: 4
uniform float u_treshold;   /// Default: 0.001
uniform float u_wave;       // Default 0.2
uniform float u_distortion; // Default: 0.2


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

float noise(in vec2 x) {
  return texture2D(gm_BaseTexture, v_texcoord + (x * u_treshold)).x;
}

float fbm(in vec2 p) {
  float z = 2.0;
  float rz = 0.0;
  vec2 bp = p;
  for (float idx = 0.0; idx < 6.0; idx += 1.0) {
    rz += abs((noise(p) - 0.5) * 2.0) / z;
    z = z * 2.0;
    p = p * 2.0;
  }
  return rz;
}

float dualfbm(in vec2 p) {
  vec2 p2 = p * 0.7; // get two rotated fbm calls and displace the domain
  vec2 basis = vec2(fbm(p2 - u_time), fbm(p2 + u_time));
  basis = (basis - 0.5) * u_distortion;
  p += basis;
  
  return fbm(p); // coloring
}

float circ(vec2 p)  {
  float r = length(p);
  r = log(sqrt(r));
  return abs(mod(r * 4.0 * u_size, 3.141592 * 2.0) - 3.15) * 3.0 + 0.2;
}

void main() {
  vec2 p = v_texcoord.xy / iResolution.xy - 0.5;
  p.x *= iResolution.x / iResolution.y;
  float len = length(p);
  p *= 4.0;
    
  float rz = dualfbm(p);
  float fade = pow(max(1.0, 6.5 * len), 0.2);
  rz = fade * rz + (1.0 - fade) * dualfbm(p + 5.0 * sin(u_time)); // Add floating things around portal
  float my_time = u_time + 0.08 * rz;
    
  //rings
  p /= exp(mod((my_time + rz), 3.1415)); 
  rz *= pow(abs((0.1 - circ(p))), 0.9);
  
  //final color
  vec3 pixel = clamp(pow(abs(u_tint / rz), vec3(0.99)), 0.0, 1.0);
  gl_FragColor = vec4(pixel, max(pixel.r, max(pixel.g, pixel.b)) 
    * texture2D(gm_BaseTexture, v_texcoord).a * v_color.a);
}