///@package io.alkapivo.shader.screen.shader_gaussian_blur

///@static
///@type {Struct}
global.__ShaderGaussianBlur = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_resolution: "RESOLUTION",
        u_size: "FLOAT",
      },
    }
  },
  config: function() {
    return {
      u_size: {
        store: {
          value: 128.0,
          target: 128.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { }
      },
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_gaussian_blur", ShaderGaussianBlur.template())
    Struct.set(config, "shader_gaussian_blur", ShaderGaussianBlur.config())
  },
}

#macro ShaderGaussianBlur global.__ShaderGaussianBlur