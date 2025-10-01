///@package io.alkapivo.core
///@description shader_wormhole_vortex

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
#define VOL_STEPS 8
#define ITERATIONS 16


// Varying Outputs
varying vec2 v_texcoord;
varying vec4 v_color;


// Uniforms
uniform float u_angle;      // Default: 0.0
uniform float u_brightness; // Default: 1.25
uniform float u_darkmatter; // Default: 0.3
uniform float u_direction;  // Default: 0.0
uniform float u_distfading; // Default: 0.8
uniform float u_opacity;     // Default: 0.01,
uniform float u_hue;        // Default: 0.0
uniform float u_sat;        // Default: 8.5
uniform float u_seed;       // Default: 0.0
uniform float u_tile;       // Default: 8.5
uniform float u_time;       // Default: 0.0, where 1.0=1sec
uniform float u_zoom;       // Default: 25.0
uniform vec2 u_offset;			// Default: vec2(0.5, 0.5)
uniform vec2 u_resolution;  // Default: vec2(GuiWith(), GuiHeight())
uniform vec3 u_tint;        // Default: vec3(1.0, 1.0, 1.0)


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
vec2 rot(vec2 p, float r){
	mat2 m = mat2(cos(r), sin(r), -1.0 * sin(r), cos(r));
	return m * p;
}

vec2 pmod(vec2 p, float n){
	float np = 2.0 * PI / n;
	float r = atan(p.x, p.y) - 0.5 * np;
	r = mod(r, np) - 0.5 * np;
	return length(p) * vec2(cos(r), sin(r));
}

float cube(vec3 p, vec3 s){
	vec3 q = abs(p);
	vec3 m = max(s - q, 0.0);
	return length(max(q - s, 0.0)) - min(min(m.x, m.y), m.z);
}

float dist(vec3 p, float direction, float time, float size){
	p.z += direction * time;
	p.xy = rot(p.xy, p.z);
	p.xy = pmod(p.xy, 6.0);
	float zid = floor(p.z * size);
	p = mod(p, size) - 0.5 * size;
	for (int i = 0; i < 4; i++) {
		p = abs(p) - 0.3;
		p.xy = rot(p.xy, 1.0 + zid + 0.1 * time);
		p.xz = rot(p.xz, 1.0 + 5.0 * zid + 0.25 * time);
	}

	return min(cube(p, vec3(0.3)), length(p) - 0.4);
}

float get_color_distance(vec3 color_from, vec3 color_to) {
  return distance(color_from, color_to) / SQRT_3;
}

void main() {
  float time = u_seed + (u_time / 100.0);
	vec2 uv = rotated_uv_resolution(v_texcoord, u_resolution, u_offset, u_angle);
	vec3 dir = vec3(uv * (u_zoom / 100.0), 1.0);
	float a1 = u_offset.x;
	float a2 = u_offset.y;
	mat2 rot1 = mat2(cos(a1), sin(a1), -sin(a1), cos(a1));
	mat2 rot2 = mat2(cos(a2), sin(a2), -sin(a2), cos(a2));
	dir.xz *= rot1;
	dir.xy *= rot2;

  float angle = (mod(mod(u_direction, 360.0) + 360.0, 360.0) / 360.0) * TAU;
  vec3 from = vec3(0.5, 0.5, 0.5);
	from.x += cos(angle) * time;
  from.y -= sin(angle) * time;
  from.z += 0.0 * time;
	from.xz *= rot1;
	from.xy *= rot2;

	//volumetric rendering
	float s = 0.1;
  float fade = 1.0;
	vec3 v = vec3(0.0);
	for (int r = 0; r < VOL_STEPS; r++) {
    float pa = 0.0;
    float a = 0.0;
		vec3 p = from + s * dir * 0.5;
		p = abs(vec3(u_tile / 10.0) - mod(p, vec3((u_tile / 10.0) * 2.0))); // tiling fold
		for (int i = 0; i < ITERATIONS; i++) { 
			p = abs(p) / dot(p, p) - 0.53; // the magic formula
			a += abs(length(p) - pa); // absolute sum of average change
			pa = length(p);
		}

		float dm = max(0.0, u_darkmatter - a * a * 0.001); //dark matter
		a *= a * a; // add contrast
		if (r > 6) {
      fade *= 1.0 - dm; // dark matter, don't render near
    }

		//v += vec3(dm, dm * 0.5, 0.0);
		v += fade;
		v += vec3(s, s * s, s * s * s * s) * a * (u_brightness / 1000.0) * fade; // coloring based on distance
		fade *= u_distfading; // distance fading
		s += 0.1;
	}

  vec4 texture = texture2D(gm_BaseTexture, v_texcoord);
  vec3 color = mix(vec3(length(v)), v, (u_sat / 10.0)) * 0.01;
  color *= mix(u_tint, vec3(1.0), clamp(get_alpha_from_pixel(color), 0.0, 1.0));
  vec3 pixel = apply_hue(apply_saturation(color, u_sat), u_hue) * u_brightness;
  float alpha = texture.a == 0.0 ? 0.0 : (clamp(get_alpha_from_pixel(pixel) * (u_opacity * 100.0), 0.0, 1.0));
  pixel = mix(pixel, texture.rgb, 1.0 - v_color.a);
  pixel = mix(pixel, texture.rgb, 1.0 - alpha);
  gl_FragColor = vec4(pixel, texture.a + (alpha * v_color.a));
}
