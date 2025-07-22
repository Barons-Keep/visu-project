///@package io.alkapivo.core
///@description shader_wavy_mesh

// Base constants
#define PI 3.14159265359
#define TAU 6.28318530718
#define DEG_TO_RAD 0.01745329251


// Shader specific constants
#define SQRT_3 1.732050807568877


// Varying Outputs
varying vec2 v_texcoord;
varying vec4 v_color;


// Uniforms
uniform float u_angle;        // Default: 0.0
uniform float u_border;       // Default: 0.01
uniform float u_fbm_scale;    // Default: 0.5
uniform float u_fbm_size;     // Default: 0.5
uniform float u_jitter;       // Default: 0.5
uniform float u_jitter_seed;  // Default: 20.0
uniform float u_mesh_size;    // Default: 2.0
uniform float u_shift;        // Default: 0.0
uniform float u_thickness;    // Default: 1.0
uniform float u_time_scale;   // Default: 0.5
uniform float u_time;         // Default: 0.0, where 1.0=1sec
uniform vec2 u_offset;        // Default: vec2(0.5, 0.5)
uniform vec2 u_resolution;    // Default: vec2(GuiWith(), GuiHeight())
uniform vec3 u_color_between; // Default: vec3(0.0, 0.5, 1.0)
uniform vec3 u_color_bkg;     // Default: vec3(0.75, 0.0, 0.4)
uniform vec3 u_color_mesh;    // Default: vec3(1.0, 0.0, 0.0)


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

vec4 mix_pixel(vec3 pixel, vec4 texture, vec4 color) {
  float alpha = get_alpha_from_pixel(pixel);
  return vec4(mix(texture.rgb, pixel * color.rgb, color.a * alpha), alpha * color.a * texture.a);
}


// Shader methods
float hash(vec2 p) {
  return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
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

float dot_shape(vec2 uv, vec2 pos, float size) {
  float d = length(uv - pos);
  return smoothstep(size, size * 0.5, d);
}

float line_shape(vec2 uv, vec2 a, vec2 b, float thickness) {
  vec2 pa = uv - a;
  vec2 ba = b - a;
  float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
  float d = length(pa - ba * h);
  return smoothstep(thickness, thickness * 0.5, d);
}

float triangle_fill(vec2 uv, vec2 a, vec2 b, vec2 c, float border) {
  float area = abs((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y));
  if (area < 1e-6) {
    return 0.0;
  }

  float wa = (uv.x * (b.y - c.y) + b.x * (c.y - uv.y) + c.x * (uv.y - b.y));
  float wb = (uv.x * (c.y - a.y) + c.x * (a.y - uv.y) + a.x * (uv.y - c.y));
  float wc = (uv.x * (a.y - b.y) + a.x * (b.y - uv.y) + b.x * (uv.y - a.y));
  wa /= area;
  wb /= area;
  wc /= area;

  float edge = min(min(wa, wb), wc);
  return smoothstep(border, border + 0.05, edge);
}

vec2 jitter(vec2 cell, float time, float jitterAmount, float seed, float density) {
  vec2 static_jitter = vec2(hash(cell), hash(cell + seed));
  vec2 animated_jitter = vec2(
      sin(hash(cell) * TAU + time * 1.2),
      cos(hash(cell + seed) * TAU + time * 1.3)
  );
  vec2 total_jitter = (static_jitter - 0.5 + animated_jitter * 0.5) * (jitterAmount / density);
  return total_jitter;
}

vec3 rainbow(float t) {
  return 0.5 + 0.5 * cos(6.2831 * (vec3(0.00, 0.33, 0.66) + t));
}

float pulse(vec2 p, float t) {
  float life = fbm(p + t);
  float pulse = sin(life * PI);
  float fade = 1.0 - abs(pulse - 1.0);
  return clamp(fade, 0.0, 1.0);
}

float get_color_distance(vec3 color_from, vec3 color_to) {
  return distance(color_from, color_to) / SQRT_3;
}

void main() { 
  vec2 uv = rotated_uv_resolution(v_texcoord, u_resolution, u_offset, u_angle);
  uv *= u_mesh_size;
  
  vec2 grid = floor(uv);
  vec2 pixel_uv = rotated_uv_resolution(v_texcoord, u_resolution, u_offset, u_angle);
  vec4 texture = texture2D(gm_BaseTexture, v_texcoord);
  vec3 col = vec3(0.0);
  float time = u_time * u_time_scale;
  float angle_rad = u_angle * DEG_TO_RAD;
  uv.x += cos(angle_rad) * time;
  uv.y += sin(angle_rad) * time;
  
  float n = noise(uv * u_fbm_scale);
  float fbmSize = clamp(abs(u_fbm_size), 0.0, 1.0);
  float osc = fbmSize + ((1.0 - fbmSize) * sin(time + n * 6.28));
  for (int j = -1; j <= 1; ++j) {
    for (int i = -1; i <= 1; ++i) {
      vec2 offset = vec2(float(i), float(j));
      vec2 cell = grid + offset;
      vec2 pos = cell + 0.5 + u_shift + jitter(cell, time, u_jitter, u_jitter_seed, u_mesh_size);
      vec2 norm_pos = pos / u_mesh_size;
      float fade = pulse(cell, time);
      fade *= fade * fade;
      //col += dot_shape(pixel_uv, norm_pos, 0.01) * fade * fade;
      for (int jj = 0; jj <= 1; ++jj) {
        for (int ii = 0; ii <= 1; ++ii) {
      //for (int jj = -1; jj <= 1; ++jj) {
      //  for (int ii = -1; ii <= 1; ++ii) {
          vec2 n_off = vec2(float(ii), float(jj));
          vec2 neighbor = cell + n_off;
          if (neighbor == cell) {
              continue;
          }
          
          vec2 n_pos = neighbor + 0.5 - u_shift + jitter(neighbor, time, u_jitter, u_jitter_seed, u_mesh_size);
          vec2 n_norm_pos = n_pos / u_mesh_size;
          float n_fade = pulse(neighbor, time);
          n_fade *= n_fade * n_fade;
          float line_fade = fade * n_fade;
          float thickness = (((0.0025 * u_thickness) * float(ii)) + (0.005 * u_thickness)) * line_fade;
          float line_shape_factor = line_shape(pixel_uv, norm_pos, n_norm_pos, thickness) * line_fade;
          if (((ii == -1) && (jj == -1)) || ((ii == 1) && (jj == 1))) {
              continue;
          }
          
          col += mix(u_color_mesh, u_color_between, line_shape_factor / 2.0) * line_shape_factor;
          if (ii < 0) {
              continue;
          }
          
          if (ii >= 1 && jj >= -1) {
              neighbor = cell;
          }
          
          vec2 third = neighbor + vec2(1.0, 0.0);
          vec2 third_pos = third + 0.5 + (u_shift / 2.0) + jitter(third, time, u_jitter, u_jitter_seed, u_mesh_size);
          vec2 third_norm = third_pos / u_mesh_size;
          float third_fade = pulse(third, time);
          third_fade *= third_fade * third_fade;

          float tri_fade = line_fade * third_fade;
          float tri_fill = triangle_fill(pixel_uv, norm_pos, n_norm_pos, third_norm, u_border) * osc;
          vec3 tri_col = rainbow(time + hash(cell + neighbor + third)) + 1.0;
          col += u_color_bkg * tri_fill * tri_col * tri_fade * osc;
        }
      }
    }
  }

  float factor = get_color_distance(texture.rgb, col);
  vec3 color = mix(texture.rgb, col, factor);
  gl_FragColor = vec4(color, texture.a * v_color.a);
}