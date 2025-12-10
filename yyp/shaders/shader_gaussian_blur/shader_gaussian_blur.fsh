///@package io.alkapivo.core
///@description shader_gaussian_blur

// Constants
#define QUALITY 8
#define DIRECTIONS 16


// Varying Outputs
///*
varying vec2 v_texcoord;
varying vec4 v_color;
//*/


// Uniform
///*
uniform vec2 u_resolution;
uniform float u_size;
//*/


// Main
void main() {
  float r = u_size;
  vec2 texel = vec2(1.0 / u_resolution.x, 1.0 / u_resolution.y);
  vec4 sum = texture2D(gm_BaseTexture, v_texcoord);

  if (r > 0.0) {
    // Precomputed direction vectors (must be assigned at runtime for GMS)
    vec2 dirs[16];
    dirs[0]  = vec2( 1.0,  0.0);
    dirs[1]  = vec2( 0.9239,  0.3827);
    dirs[2]  = vec2( 0.7071,  0.7071);
    dirs[3]  = vec2( 0.3827,  0.9239);
    dirs[4]  = vec2( 0.0,   1.0);
    dirs[5]  = vec2(-0.3827,  0.9239);
    dirs[6]  = vec2(-0.7071,  0.7071);
    dirs[7]  = vec2(-0.9239,  0.3827);
    dirs[8]  = vec2(-1.0,   0.0);
    dirs[9]  = vec2(-0.9239, -0.3827);
    dirs[10] = vec2(-0.7071, -0.7071);
    dirs[11] = vec2(-0.3827, -0.9239);
    dirs[12] = vec2( 0.0,  -1.0);
    dirs[13] = vec2( 0.3827, -0.9239);
    dirs[14] = vec2( 0.7071, -0.7071);
    dirs[15] = vec2( 0.9239, -0.3827);

    float stepScale = r / float(QUALITY);
    for (int d = 0; d < DIRECTIONS; d++) {
      vec2 dir = dirs[d] * texel;
      for (int i = 1; i <= QUALITY; i++) {
        sum += texture2D(
          gm_BaseTexture,
          v_texcoord + dir * (float(i) * stepScale)
        );
      }
    }

    sum /= float(QUALITY * DIRECTIONS + 1);
  }

  gl_FragColor = v_color * sum;
}