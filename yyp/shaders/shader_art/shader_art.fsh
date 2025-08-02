///@description Based on shader created by kishimisu in 2023-05-20
///             https://www.youtube.com/watch?v=f4s1h2YETNY

varying vec2 vTexcoord;
varying vec4 vColor;

uniform float iTime;
uniform vec2 iResolution;
uniform float iIterations;
	
float get_alpha_from_pixel(vec3 pixel) {
  return dot(pixel, vec3(0.2126, 0.7152, 0.0722)); // Luma (ITU-R BT.709)
}

///@description https://iquilezles.org/articles/palettes/
vec3 palette(float t) {
  vec3 a = vec3(0.5, 0.5, 0.5);
  vec3 b = vec3(0.5, 0.5, 0.5);
  vec3 c = vec3(1.0, 1.0, 1.0);
  vec3 d = vec3(0.263, 0.416, 0.557);
  return a + b*cos(6.28318 * (c * t + d));
}


///@description https://www.shadertoy.com/view/mtyGWy
void main() {
  vec2 uv = (vTexcoord * 2.0 - iResolution.xy) / iResolution.y;
  vec2 uv0 = uv;
  vec3 finalColor = vec3(0.0);
  vec3 col = vec3(0.0);
  float d = 0.0;
  for (float idx = 0.0; idx < 64.0; idx++) {
    if (idx > iIterations) {
      break;
    }

    uv = fract(uv * 1.5) - 0.5;
    col = palette(length(uv0) + idx * 0.25 + iTime * 0.25);
    d = length(uv) * exp(-length(uv0));
    d = abs(sin(d * 8.0 + iTime) / 8.0);
    d = pow((0.001 / iIterations) / d, 0.5);
    finalColor += col * d;
  }

  vec4 texture = texture2D(gm_BaseTexture, vTexcoord);
  vec3 pixel = finalColor;
  float alpha = get_alpha_from_pixel(pixel);
  pixel = mix(pixel, texture.rgb, 1.0 - vColor.a);
  pixel = mix(pixel, texture.rgb, 1.0 - alpha);
  gl_FragColor = vec4(pixel, texture.a + (alpha * vColor.a));
}
