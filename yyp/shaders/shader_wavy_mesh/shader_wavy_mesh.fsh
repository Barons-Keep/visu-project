///@package io.alkapivo.core
///@description shader_wavy_mesh

// Base constants
#define PI 3.141592
#define TAU 6.283185
#define DEG_TO_RAD 0.017453
#define SQRT_3 1.732050

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

uniform float u_angle;        // Default: 0.0
uniform float u_border;       // Default: 0.01
uniform float u_brightness;   // Default: 1.0
uniform float u_fbm_scale;    // Default: 0.5
uniform float u_fbm_size;     // Default: 0.5
uniform float u_hue;          // Default: 0.0
uniform float u_jitter;       // Default: 0.5
uniform float u_mesh_size;    // Default: 2.0
uniform float u_sat;          // Default: 1.0
uniform float u_seed;         // Default: 0.0
uniform float u_shift;        // Default: 0.0
uniform float u_thickness;    // Default: 1.0
uniform float u_time;         // Default: 0.0, where 1.0=1sec
uniform vec2 u_offset;        // Default: vec2(0.5, 0.5)
uniform vec2 u_resolution;    // Default: vec2(GuiWith(), GuiHeight())
uniform vec3 u_color_between; // Default: vec3(0.0, 0.5, 1.0)
uniform vec3 u_color_bkg;     // Default: vec3(0.75, 0.0, 0.4)
uniform vec3 u_color_mesh;    // Default: vec3(1.0, 0.0, 0.0)


// Shader methods
vec2 hash2(vec2 p) {
  float n = dot(p, vec2(127.1, 311.7));
  float s = sin(n) * 43758.5453123;
  float t = fract(s);
  float s2 = sin(n + 78.233) * 23421.631;
  float t2 = fract(s2);
  return vec2(t, t2);
}

float noise(vec2 p) {
  vec2 i = floor(p);
  vec2 f = fract(p);
  vec2 u = f * f * (3.0 - 2.0 * f);
  float a = fract(sin(dot(i, vec2(127.1,311.7))) * 43758.5453);
  float b = fract(sin(dot(i + vec2(1.0,0.0), vec2(127.1,311.7))) * 43758.5453);
  float c = fract(sin(dot(i + vec2(0.0,1.0), vec2(127.1,311.7))) * 43758.5453);
  float d = fract(sin(dot(i + vec2(1.0,1.0), vec2(127.1,311.7))) * 43758.5453);
  return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

float fbm(vec2 p) {
  float f = 0.0;
  f += 0.5000 * noise(p); p *= 2.02;
  f += 0.2500 * noise(p); p *= 2.03;
  f += 0.1250 * noise(p); p *= 2.01;
  f += 0.0625 * noise(p);
  return f;
}

float line_shape_fast(vec2 uv, vec2 a, vec2 b, float thickness) {
  vec2 pa = uv - a;
  vec2 ba = b - a;
  float denom = dot(ba, ba);
  denom = max(denom, 1e-6);  // denom could be zero in degenerate case; clamp small values
  float h = clamp(dot(pa, ba) / denom, 0.0, 1.0);
  vec2 diff = pa - ba * h; // squared distance then sqrt once
  float d = length(diff);
  return smoothstep(thickness, thickness * 0.5, d);
}

float triangle_fill_fast(vec2 uv, vec2 a, vec2 b, vec2 c, float border) {
  float area = abs((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y));
  if (area < 1e-6) return 0.0;
  float wa = (uv.x * (b.y - c.y) + b.x * (c.y - uv.y) + c.x * (uv.y - b.y)) / area;
  float wb = (uv.x * (c.y - a.y) + c.x * (a.y - uv.y) + a.x * (uv.y - c.y)) / area;
  float wc = (uv.x * (a.y - b.y) + a.x * (b.y - uv.y) + b.x * (uv.y - a.y)) / area;
  float edge = min(min(wa, wb), wc);
  return smoothstep(border, border + 0.05, edge);
}

vec2 jitter_cached(vec2 cell, float time, float jitterAmount, float seed, float density, vec2 prehash) {
  vec2 static_jitter = prehash;
  vec2 animated_jitter = vec2(
    sin(prehash.x * TAU + time * 1.2),
    cos(prehash.y * TAU + time * 1.3)
  );
  return (static_jitter - 0.5 + animated_jitter * 0.5) * (jitterAmount / density);
}

vec3 rainbow(float t) {
  return 0.5 + 0.5 * cos(6.2831 * (vec3(0.00, 0.33, 0.66) + t));
}

float pulse(vec2 p, float t) {
  float life = fbm(p + t);
  float pulsev = sin(life * PI);
  float fade = 1.0 - abs(pulsev - 1.0);
  return clamp(fade, 0.0, 1.0);
}

vec3 calc_cell_contrib(vec3 color, vec2 cell, float time, vec2 pixel_uv, float osc) {
  vec2 h_cell = hash2(cell);
  vec2 h_n01 = hash2(cell + vec2(0.0,1.0));
  vec2 h_n10 = hash2(cell + vec2(1.0,0.0));

  vec2 pos = cell + 0.5 + u_shift
    + jitter_cached(cell, time, u_jitter, u_seed * 2.0, u_mesh_size, h_cell);
  vec2 pos_n01 = (cell + vec2(0.0,1.0)) + 0.5 + (u_shift / 2.0)
    + jitter_cached(cell + vec2(0.0,1.0), time, u_jitter, u_seed * 2.0, u_mesh_size, h_n01);
  vec2 pos_n10 = (cell + vec2(1.0,0.0)) + 0.5 + (u_shift / 2.0)
    + jitter_cached(cell + vec2(1.0,0.0), time, u_jitter, u_seed * 2.0, u_mesh_size, h_n10);

  vec2 norm_pos = pos / u_mesh_size;
  vec2 norm_n01 = pos_n01 / u_mesh_size;
  vec2 norm_n10 = pos_n10 / u_mesh_size;

  float fade_c = pulse(cell, time); fade_c *= fade_c * fade_c;
  float fade_n01 = pulse(cell + vec2(0.0,1.0), time); fade_n01 *= fade_n01 * fade_n01;
  float fade_n10 = pulse(cell + vec2(1.0,0.0), time); fade_n10 *= fade_n10 * fade_n10;

  // first neighbor: (0,1) relative to cell
  {
    float line_fade = fade_c * fade_n01;
    float thickness = (((0.0025 * u_thickness) * 0.0) + (0.005 * u_thickness)) * line_fade; // ii==0 for this neighbor
    float ls = line_shape_fast(pixel_uv, norm_pos, norm_n01, thickness) * line_fade;
    color += mix(u_color_mesh, u_color_between, ls / 2.0) * ls;

    float tri_fade = line_fade * fade_n10; // in original the 3rd point mixed; we use fade_n10 for the third
    float tri_fill = triangle_fill_fast(pixel_uv, norm_pos, norm_n01, norm_n10, u_border) * osc;
    vec3 tri_col = rainbow(time + fract(dot(cell + (cell + vec2(0.0,1.0)) + (cell + vec2(1.0,0.0)), vec2(12.9898,78.233)))) + 1.0;
    color += u_color_bkg * tri_fill * tri_col * tri_fade * osc;
  }

  // second neighbor: (1,0)
  {
    float line_fade = fade_c * fade_n10;
    float thickness = (((0.0025 * u_thickness) * 1.0) + (0.005 * u_thickness)) * line_fade; // ii==1
    float ls = line_shape_fast(pixel_uv, norm_pos, norm_n10, thickness) * line_fade;
    color += mix(u_color_mesh, u_color_between, ls / 2.0) * ls;

    float tri_fade = line_fade * fade_n01;
    float tri_fill = triangle_fill_fast(pixel_uv, norm_pos, norm_n10, norm_n01, u_border) * osc;
    vec3 tri_col = rainbow(time + fract(dot(cell + (cell + vec2(1.0,0.0)) + (cell + vec2(0.0,1.0)), vec2(93.9898,23.142)))) + 1.0;
    color += u_color_bkg * tri_fill * tri_col * tri_fade * osc;
  }

  return color;
}


void main() {
  float angle_rad = u_angle * DEG_TO_RAD;
  float cos_a = cos(angle_rad);
  float sin_a = sin(angle_rad);
  vec2 origin_ndc = (u_offset * u_resolution);
  origin_ndc = (origin_ndc * 2.0 - u_resolution) / u_resolution.y;

  vec2 coord = ((v_texcoord * u_resolution) * 2.0 - u_resolution) / u_resolution.y;
  coord -= origin_ndc;

  vec2 uv_rot = vec2(coord.x * cos_a - coord.y * sin_a, coord.x * sin_a + coord.y * cos_a);
  vec2 uv = uv_rot * u_mesh_size;

  vec2 grid = floor(uv);
  vec2 pixel_uv = uv_rot;

  vec3 color = vec3(0.0);
  float time = (u_time + u_seed) * 0.5;
  uv.x += cos(time) * angle_rad;
  uv.y += sin(time) * angle_rad;

  float n = noise(uv * u_fbm_scale);
  float fbmSize = clamp(abs(u_fbm_size), 0.0, 1.0);
  float osc = fbmSize + ((1.0 - fbmSize) * sin(time + n * TAU));

  color = calc_cell_contrib(color, grid + vec2(-1.0, -1.0), time, pixel_uv, osc);
  color = calc_cell_contrib(color, grid + vec2(-1.0,  0.0), time, pixel_uv, osc);
  color = calc_cell_contrib(color, grid + vec2(-1.0,  1.0), time, pixel_uv, osc);
  color = calc_cell_contrib(color, grid + vec2( 0.0, -1.0), time, pixel_uv, osc);
  color = calc_cell_contrib(color, grid + vec2( 0.0,  0.0), time, pixel_uv, osc);
  color = calc_cell_contrib(color, grid + vec2( 0.0,  1.0), time, pixel_uv, osc);
  color = calc_cell_contrib(color, grid + vec2( 1.0, -1.0), time, pixel_uv, osc);
  color = calc_cell_contrib(color, grid + vec2( 1.0,  0.0), time, pixel_uv, osc);
  color = calc_cell_contrib(color, grid + vec2( 1.0,  1.0), time, pixel_uv, osc);

  vec3 pixel = color;
  float luma = dot(pixel, vec3(0.2126, 0.7152, 0.0722));
  pixel = mix(vec3(luma), pixel, u_sat);
  if (abs(u_hue) > 1e-5) {
    vec3 y_color = pixel * rgb2yiq;
    float original_hue = atan(y_color.b, y_color.g);
    float final_hue = original_hue + (u_hue * TAU);
    float chroma = sqrt(y_color.b * y_color.b + y_color.g * y_color.g);
    pixel = vec3(y_color.r, chroma * cos(final_hue), chroma * sin(final_hue)) * yiq2rgb;
  }
  pixel *= u_brightness;

  vec4 texture = texture2D(gm_BaseTexture, v_texcoord);
  float alpha = texture.a == 0.0 ? 0.0 : distance(texture.rgb, pixel) / SQRT_3;
  pixel = mix(pixel, texture.rgb, 1.0 - alpha);
  gl_FragColor = vec4(pixel, texture.a + (alpha * v_color.a));
}