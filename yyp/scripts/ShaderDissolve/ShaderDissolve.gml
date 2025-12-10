///@package io.alkapivo.shader.screen.shader_dissolve

///@static
///@type {Struct}
global.__ShaderDissolve = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_time: "FLOAT",
      },
    }
  },
  config: function() {
    return {
      u_time: {
        store: {
          value: 0.0,
          target: 1000.0,
          duration: 1000.0,
          ease: "LINEAR",
        },
        components: { }
      },
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_dissolve", ShaderDissolve.template())
    Struct.set(config, "shader_dissolve", ShaderDissolve.config())
  },
}

#macro ShaderDissolve global.__ShaderDissolve