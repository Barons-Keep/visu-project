///@package io.alkapivo.shader.screen.shader_astral_flow

///@static
///@type {Struct}
global.__ShaderAstralFlow = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_angle: "FLOAT",
        u_bold: "FLOAT",
        u_brightness: "FLOAT",
        u_glow: "FLOAT",
        u_opacity: "FLOAT",
        u_hue: "FLOAT",
        u_sat: "FLOAT",
        u_seed: "CONST_FLOAT",
        u_shift: "FLOAT",
        u_size: "CONST_FLOAT",
        u_speed: "FLOAT",
        u_time: "FLOAT",
        u_zoom: "FLOAT",
        u_offset: "VECTOR2",
        u_resolution: "RESOLUTION",
        u_base: "COLOR",
        u_tint: "COLOR",
      },
    }
  },
  config: function() {
    return {
      u_angle: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_bold: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { }
      },
      u_brightness: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_glow: {
        store: {
          value: 2.5,
          target: 2.5,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_hue: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_opacity: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_sat: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_seed: {
        store: { value: 0.0 },
        components: { },
      },
      u_shift: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_size: {
        store: {
          value: 8.0,
          target: 8.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_speed: {
        store: {
          value: 2.5,
          target: 2.5,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_time: {
        store: {
          value: 0.0,
          target: 1000.0,
          duration: 1000.0,
          ease: "LINEAR",
        },
        components: { }
      },
      u_zoom: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { }
      },
      u_offset: {
        store: {
          x: {
            value: 0.5,
            target: 0.5,
            duration: 0.0,
            ease: "LINEAR",
          },
          y: {
            value: 0.5,
            target: 0.5,
            duration: 0.0,
            ease: "LINEAR",
          },
        },
        components: { },
      },
      u_base: {
        store: {
          value: "#334de6",
          target: "#334de6",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_tint: {
        store: {
          value: "#ffffff",
          target: "#ffffff",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_astral_flow", ShaderAstralFlow.template())
    Struct.set(config, "shader_astral_flow", ShaderAstralFlow.config())
  },
}

#macro ShaderAstralFlow global.__ShaderAstralFlow