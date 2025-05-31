///@package io.alkapivo.core
///@description shader_warp_pulse

// Vertex Attributes
attribute vec3 in_Position;     // (x, y, z)
attribute vec4 in_Colour;       // (r, g, b, a)
attribute vec2 in_TextureCoord; // (u, v)

// Varying Outputs to Fragment Shader
varying vec2 v_texcoord;
varying vec4 v_color;

void main() {
  // Transform vertex position by combined model-view-projection matrix
  gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1.0);

  // Pass through color and texture coordinate to fragment shader
  v_color = in_Colour;
  v_texcoord = in_TextureCoord;
}