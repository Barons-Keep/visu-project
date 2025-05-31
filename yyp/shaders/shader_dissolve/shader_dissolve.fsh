///@package io.alkapivo.core
///@description shader_dissolve

// Base constants
#define PI 3.14159265359
#define DEG_TO_RAD 0.01745329251

// Varying Outputs
varying vec2 v_texcoord;
varying vec4 v_color;

// Uniforms
uniform float u_time;				// Default: 0.0, where 1.0=1sec

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
// Gradient Noise functions (moved outside mainImage)
vec2 gradientNoise_dir(vec2 p) {
  // Rotation matrix to rotate the gradient
  p = mod(p, 289.0);
  float x = mod((34.0 * p.x + 1.0) * p.x, 289.0) + p.y;
  x = mod((34.0 * x + 1.0) * x, 289.0);
  x = fract(x / 41.0) * 2.0 - 1.0;
  return normalize(vec2(x - floor(x + 0.5), abs(x) - 0.5));
}

float gradientNoise(vec2 p) {
  vec2 ip = floor(p);
  vec2 fp = fract(p);
  float d00 = dot(gradientNoise_dir(ip), fp);
  float d01 = dot(gradientNoise_dir(ip + vec2(0.0, 1.0)), fp - vec2(0.0, 1.0));
  float d10 = dot(gradientNoise_dir(ip + vec2(1.0, 0.0)), fp - vec2(1.0, 0.0));
  float d11 = dot(gradientNoise_dir(ip + vec2(1.0, 1.0)), fp - vec2(1.0, 1.0));
  fp = fp * fp * fp * (fp * (fp * 6.0 - 15.0) + 10.0);
  return mix(mix(d00, d01, fp.y), mix(d10, d11, fp.y), fp.x);
}

float GradientNoise(vec2 UV, float Scale) {
    return gradientNoise(UV * Scale) + 0.5;
}

void main() {
  // Normalized pixel coordinates (from 0 to 1)
  vec2 uv = v_texcoord;
    
  // Shader properties - you can tweak these
  float noiseScale = 20.0;
  float thickness = 0.25;
	float colorIntensity = 2.0;
  vec4 color = vec4(1.0, 0.3, 0.1, 1.0); // Orange color

  vec4 col = texture2D(gm_BaseTexture, uv);
    
  // Generate noise
  float noise = GradientNoise(uv, noiseScale);
  noise = clamp(noise, 0.0, 1.0);
    
  uv.y = pow(uv.y, 2.0) * 3.0;
  float heightCalc = noise + uv.y;
    
  // Animated value based on time
  float val = sin(u_time * 1.75) * 2.5 + 2.0;
    
  float stepFn = step(heightCalc - val, 0.0); // Smaller
  float stepFnOff = step(heightCalc - (val + thickness), 0.0); // Larger
  float lines = stepFnOff - stepFn;
  vec4 lineColor = lines * color * colorIntensity;
    
  vec4 maskedOffTex = col * stepFn;
  gl_FragColor = vec4(maskedOffTex.rgb + lineColor.rgb, stepFnOff * col.a);
}