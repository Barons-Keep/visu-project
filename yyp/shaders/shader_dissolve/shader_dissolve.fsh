///@package io.alkapivo.core
///@description shader_dissolve

// Constants
#define PI 3.14159265359


// Varying Outputs
///*
varying vec2 v_texcoord;
varying vec4 v_color;
//*/


// Uniforms
///*
uniform float u_time;
//*/


// Methods
float hash12(vec2 p) {
  vec3 p3 = fract(vec3(p.xyx) * 0.1031);
  p3 += dot(p3, p3.yzx + 33.33);
  return fract((p3.x + p3.y) * p3.z) * 2.0 - 1.0;
}

vec2 grad2(vec2 p) {
  float h = hash12(p);
  float a = h * PI; 
  return vec2(cos(a), sin(a));
}

float fastNoise(vec2 p) {
  vec2 ip = floor(p);
  vec2 fp = fract(p);

  vec2 g00 = grad2(ip);
  vec2 g10 = grad2(ip + vec2(1.0, 0.0));
  vec2 g01 = grad2(ip + vec2(0.0, 1.0));
  vec2 g11 = grad2(ip + vec2(1.0, 1.0));

  float d00 = dot(g00, fp);
  float d10 = dot(g10, fp - vec2(1.0, 0.0));
  float d01 = dot(g01, fp - vec2(0.0, 1.0));
  float d11 = dot(g11, fp - vec2(1.0, 1.0));

  fp = fp * fp * fp * (fp * (fp * 6.0 - 15.0) + 10.0);

  return mix(mix(d00, d01, fp.y), mix(d10, d11, fp.y), fp.x);
}

float GradientNoise(vec2 uv, float scale) {
  return fastNoise(uv * scale) * 0.5 + 0.5;
}


// Main
void main() {
//void mainImage(out vec4 fragColor, in vec2 v_texcoord) {
  //float u_time = iTime;
  //vec2 uv = v_texcoord.xy / iResolution.xy;
  vec2 uv = v_texcoord;

  float noiseScale = 20.0;
  float thickness = 0.25;
  float colorIntensity = 2.0;

  vec4 col = texture2D(gm_BaseTexture, uv);
  //vec4 col = texture(iChannel0, uv);
  float noise = clamp(GradientNoise(uv, noiseScale), 0.0, 1.0);
  uv.y = uv.y * uv.y * 3.0;

  float heightCalc = noise + uv.y;
  float val = sin(u_time * 1.75) * 2.5 + 2.0;
  float lineA = step(heightCalc - val, 0.0);
  float lineB = step(heightCalc - (val + thickness), 0.0);
  float lines = lineB - lineA;
  vec3 lineColor = lines * vec3(1.0, 0.3, 0.1) * colorIntensity;
  vec3 masked = col.rgb * lineA;

  //fragColor = vec4(masked + lineColor, lineB * col.a);
  gl_FragColor = vec4(masked + lineColor, lineB * col.a);
}