///@package io.alkapivo.core
///@description shader_astral_flow

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
#define ITERATIONS 50.0


// Varying Outputs
///*
varying vec2 v_texcoord;
varying vec4 v_color;
//*/


// Uniforms
///*
uniform float u_angle;          // Default: 0.0
uniform float u_bold;           // Default: 1.0
uniform float u_brightness;     // Default: 1.0
uniform float u_glow;           // Default: 2.5
uniform float u_hue;            // Default: 0.0
uniform float u_opacity;        // Default: 1.0
uniform float u_sat;            // Default: 1.0
uniform float u_seed;           // Default: 0.0
uniform float u_shift;          // Default: 1.0
uniform float u_size;           // Default: 8.0
uniform float u_speed;          // Default: 2.5
uniform float u_time;           // Default: 0.0, where 1.0=1sec
uniform float u_zoom;           // Default: 1.0
uniform vec2 u_offset;          // Default: (0.5, 0.5)
uniform vec2 u_resolution;      // Default: (GuiWidth(), GuiHeight())
uniform vec3 u_base;            // Default: (0.2, 0.3, 0.9)
uniform vec3 u_tint;            // Default: (1.0, 1.0, 1.0)
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
float hash(vec2 p) {
  p = fract(p * vec2(123.34, 456.21));
  p += dot(p, p + 45.32);
  return fract(p.x * p.y);
}

float star(vec2 uv, float flare, float glow) {
  float dist = length(uv);
  float result = sin(glow * 1.2) / dist;  
  float rays = max(0.0, 0.5 - abs(uv.x * uv.y * 1000.0));
  result += (rays * flare) * 2.0;
  result *= smoothstep(1.0, 0.1, dist);
  return result;
}

vec4 star_layer(vec2 uv, float time, float glow, float shift, vec3 base, vec3 tint) {
  vec4 pixel = vec4(0.0);
  vec2 gv = fract(uv);
  vec2 id = floor(uv);
  for (float y = -1.0; y <= 1.0; y += 1.0) {
    for (float x = -1.0; x <= 1.0; x += 1.0)  {
      vec2 offset = vec2(x, y);
      float n = hash(id + offset);
      float size = fract(n);
      float result = star(gv - offset - vec2(n, fract(n * 34.0)) + 0.5, smoothstep(0.1, 0.9, size) * 0.46, glow);
      vec3 color = base * sin(fract(n * 2345.2) * TAU) * (0.25 + shift) + 0.75;
      color *= tint;
      result *= sin(time * 0.6 + n * TAU) * 0.5 + 0.5;
      pixel.rgb += result * size * color;
    }
  }
  
  pixel.a = get_color_distance(vec3(0.0), pixel.rgb);
  return pixel;
}

void main() {
//void mainImage(out vec4 fragColor, in vec2 v_texcoord) {
  /*
  vec4 v_color = vec4(1.0);
  float u_angle = 0.0;
  float u_bold = 1.0;
  float u_opacity = 1.0;
  float u_brightness = 1.0;
  float u_glow = 2.5;
  float u_hue = 0.0;
  float u_sat = 1.0;
  float u_seed = 0.0;
  float u_size = 8.0;
  float u_shift = 1.0;
  float u_speed = 2.5;
  float u_time = iTime;
  float u_zoom = 1.0;
  vec2 u_offset = iMouse.xy / iResolution.xy;
  vec2 u_resolution = iResolution.xy;
  vec3 u_base = vec3(0.2, 0.3, 0.9);
  vec3 u_tint = vec3(1.0, 1.0, 1.0);
  */
  
  float time = u_time + u_seed;
  float zoom = u_zoom != 0.0 ? 10.0 / u_zoom : 0.0;
  float speed = u_speed / 100.0;
  float glow = u_glow / 100.0;
  vec2 uv = rotated_uv_resolution(v_texcoord, u_resolution, u_offset, u_angle);
  vec4 color = vec4(0.0);  
  vec2 result = vec2(0.0);
  result -= vec2(result.x + sin(time * 0.22), result.y - cos(time * 0.22));
  result += u_offset;
  for (float idx = 1.0; idx <= ITERATIONS; idx += 1.0) {
    if (idx > u_size) {
      break;
    }

    float factor = u_size != 0.0 ? idx * (1.0 / u_size) : 0.0;
    float depth = fract(factor + (time * speed));
    float scale = mix(zoom, 0.5, depth);
    float fade = depth * smoothstep(1.0, 0.9, depth);
    vec2 coord = uv * scale + factor * 453.2 - time * 0.05 + result;
    color += star_layer(coord, time, glow, u_shift, u_base, u_tint) * fade;
  }
  color = clamp(color, 0.0, 1.0);
  
  //vec4 texture = vec4(0.0, 0.0, 0.0, 1.0);
  //vec4 texture = texture(iChannel0, v_texcoord / u_resolution);
  vec4 texture = texture2D(gm_BaseTexture, v_texcoord);
  vec3 pixel = apply_hue(apply_saturation(color.rgb, u_sat), u_hue) * u_brightness;
  float alpha = max(color.a * u_opacity * u_bold, u_opacity);
  pixel = mix(pixel, texture.rgb, 1.0 - v_color.a);
  pixel = mix(pixel, texture.rgb, 1.0 - alpha);
  //fragColor = vec4(pixel, texture.a + (texture.a * v_color.a));
  gl_FragColor = vec4(pixel, texture.a + (texture.a * v_color.a));
}