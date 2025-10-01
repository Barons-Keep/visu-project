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


// Varying Outputs
///*
varying vec2 v_texcoord;
varying vec4 v_color;
//*/

// Uniforms
///*
uniform float u_angle;      // Default: 0.0
uniform float u_bold;       // Default: 2.0
uniform float u_bpm;        // Default: 0.0
uniform float u_brightness; // Default: 1.0
uniform float u_depth;      // Default: 10.0
uniform float u_direction;  // Default: -1.0
uniform float u_glare;      // Default: 0.5
uniform float u_hue;        // Default: 0.0
uniform float u_intensity;  // Default: 9.0
uniform float u_invert;     // Default: 1.0
uniform float u_iterations; // Default: 20.0
uniform float u_rotation;   // Default: 1.0
uniform float u_sat;        // Default: 1.0
uniform float u_seed;       // Default: 0.0
uniform float u_shift;      // Default: 0.1
uniform float u_size;       // Default: 0.7
uniform float u_time;       // Default: 0.0, where 1.0=1sec
uniform vec2 u_offset;			// Default: (0.5, 0.5)
uniform vec2 u_resolution;  // Default: (GuiWith(), GuiHeight())
uniform vec3 u_color_in;    // Default: (1.0, 0.0, 0.0)
uniform vec3 u_color_out;   // Default: (0.0, 0.0, 1.0)
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


void main() {
//void mainImage(out vec4 fragColor, in vec2 v_texcoord) {
  /*
  vec4 v_color = vec4(1.0);
  float u_angle = 0.0;
  float u_bold = 2.0;
  float u_bpm = 76.0;
  float u_brightness = 1.0;
  float u_depth = 2.0;
  float u_direction = -1.0;
  float u_glare = 0.1;
  float u_hue = 0.0;
  float u_intensity = 3.0;
  float u_invert = 1.0;
  float u_iterations = 30.0;
  float u_rotation = 1.0;
  float u_sat = 1.0;
  float u_seed = 0.0;
  float u_shift = 0.1;
  float u_size = 0.7;
  float u_time = iTime;
  vec2 u_offset = vec2(0.5, 0.5);
  vec2 u_resolution = iResolution.xy;
  vec3 u_color_in = vec3(0.1, 0.7, 0.7);
  vec3 u_color_out = vec3(0.1, 1.0, 0.1);
  */

  float direction = sign(u_direction);
  float invert = sign(u_invert);
  float rotation = sign(u_rotation);
  float bpm = (u_bpm / 60.0) * TAU;
  float time = u_time + u_seed;
  float pulse = (sin(time * bpm) + 1.0) / 2.0;
  vec2 uv = rotated_uv_resolution(v_texcoord, u_resolution, u_offset, u_angle);
  uv = rot(uv,rotation * time);
	vec3 ro = vec3(0.0, 0.0, u_shift);
	vec3 rd = normalize(vec3(uv, 0.0) - ro);
	float t = u_depth;
	float d = 0.0;
	float ac = 0.0;
	for (float i = 0.0; i < 64.0; i += 1.0) {
    if (i > u_iterations) {
        break;
    }

		d = dist(ro + rd * t, direction, time, u_size) * 0.2;
		d = max(0.0, abs(d));
		t += d;
		if (d < 0.002) {
      ac += exp(-15.0 * d) * u_glare;
    }
	}

	vec3 pn = ro * invert + rd * t * invert;
	pn.z = mod(pn.z + (direction * time), 0.5) - 0.5 * 0.5 * pulse;
	float em = clamp(0.01 / pn.z, 0.0, 100.0);

  //vec4 texture = vec4(0.0, 0.0, 0.0, 1.0);
  //vec4 texture = texture(iChannel0, v_texcoord / iResolution.xy);
  vec4 texture = texture2D(gm_BaseTexture, v_texcoord);
	vec3 color = u_color_in * 0.2 * vec3(ac);
	color = clamp(color + (u_intensity * em * u_color_out), 0.0, 1.0);
  vec3 pixel = apply_hue(apply_saturation(color, u_sat), u_hue) * u_brightness;
  float alpha = texture.a == 0.0 ? 0.0 : clamp(get_color_distance(vec3(0.0), pixel) * u_bold, 0.0, 1.0);
  pixel = mix(pixel, texture.rgb, 1.0 - v_color.a);
  pixel = mix(pixel, texture.rgb, 1.0 - alpha);
  //fragColor = vec4(color, 1.0);
  //fragColor = vec4(pixel, texture.a + (alpha * v_color.a));
  gl_FragColor = vec4(pixel, texture.a + (alpha * v_color.a));
}
