///@package io.alkapivo.core
///@description shader_funk_flux

// Base constants
#define RADIANS 0.017453292519943295
#define PI 3.14159265359
#define DEG_TO_RAD 0.01745329251

// Shader specific constatns
#define BRIGHTNESS 0.975

// Varying Outputs
varying vec2 v_texcoord;
varying vec4 v_color;

// Uniforms
uniform float u_angle;      // Default: 0.0
uniform float u_factor;     // Default: 3.0
uniform float u_mix;        // Default: 0.0
uniform float u_time;       // Default: 0.0, where 1.0=1sec
uniform vec2 u_offset;			// Default: (0.5, 0.5)
uniform vec2 u_res;         // Default: (1.0, 1.0)
uniform vec3 u_tint;        // Default: (1.0, 1.0, 1.0)

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
float cosRange(float degrees, float range, float minimum) {
	return (((1.0 + cos(degrees * RADIANS)) * 0.5) * range) + minimum;
}

void main() {
	vec2 uv = v_texcoord.xy / u_res.xy;
	vec2 pixel  = rotated_uv_resolution(v_texcoord, u_res, u_offset, u_angle);
	float ct = cosRange(u_time * 5.0, 3.0, 1.1);
	float xBoost = cosRange(u_time * 0.2, 5.0, 5.0);
	float yBoost = cosRange(u_time * 0.1, 15.0, 5.0);
	float fScale = cosRange(u_time * 15.5, 1.25, 0.5);
	for (float idx = 1.0; idx < 40.0; idx += 1.0) {
		vec2 new_pixel = pixel;
		new_pixel.x += 0.25 / idx * sin(idx * pixel.y + u_time * cos(ct) * 0.5 / 20.0 + 0.005 * idx) * fScale + xBoost;		
		new_pixel.y += 0.25 / idx * sin(idx * pixel.x + u_time * ct * 0.3 / 40.0 + 0.03 * (idx + 15.0)) * fScale + yBoost;
		pixel = new_pixel;
	}
	
	vec3 col = vec3(
		0.5 * sin(3.0 * pixel.x) + 0.5,
		0.5 * sin(((u_factor / 100.0) + 3.0) * pixel.y) + 0.5,
		sin(pixel.x + pixel.y)
	);
	col *= BRIGHTNESS;
    
  // Add border
  float vigAmt = 1.0;
  float vignette = (1.0 - vigAmt * (uv.y - .5) * (uv.y - 0.5)) * (1.0 - vigAmt * (uv.x - 0.5) * (uv.x - 0.5));
	float extrusion = (col.x + col.y + col.z) / 4.0;
  extrusion *= 1.5;
  extrusion *= vignette;
  
  col = mix(col, u_tint, u_mix);
  vec4 texture = texture2D(gm_BaseTexture, uv);

  float alpha = get_alpha_from_pixel(col);
  col = mix(col, texture.rgb, 1.0 - alpha);
  gl_FragColor = vec4(col.r, col.g, col.b, (texture.a + (extrusion * alpha)) * v_color.a);
}
