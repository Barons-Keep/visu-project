///@package io.alkapivo.shader.screen.shader_polycular

///@static
///@type {Struct}
global.__ShaderPolycular = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_amount: "FLOAT",
        u_angle: "FLOAT",
        u_bpm: "CONST_FLOAT",
        u_brightness: "FLOAT",
        u_distortion: "FLOAT",
        u_hue: "FLOAT",
        u_intensity: "FLOAT",
        u_points: "FLOAT",
        u_sat: "FLOAT",
        u_seed: "CONST_FLOAT",
        u_shift: "FLOAT",
        u_time: "FLOAT",
        u_treshold: "FLOAT",
        u_offset: "VECTOR2",
        u_resolution: "RESOLUTION",
        u_bkg: "COLOR",
        u_tint: "COLOR",
      },
    }
  },
  config: function() {
    return {
      u_amount: {
        store: {
          value: 5.0,
          target: 5.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_angle: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_bpm: {
        store: { value: 60.0 },
        components: { },
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
      u_distortion: {
        store: {
          value: 1.0,
          target: 1.0,
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
      u_intensity: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_points: {
        store: {
          value: 6.0,
          target: 6.0,
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
          value: 1.0,
          target: 1.0,
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
        components: { },
      },
      u_treshold: {
        store: {
          value: 1.5,
          target: 1.5,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
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
      u_bkg: {
        store: {
          value: "#ffffff",
          target: "#ffffff",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_tint: {
        store: {
          value: "#ff0000",
          target: "#ff0000",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_polycular", ShaderPolycular.template())
    Struct.set(config, "shader_polycular", ShaderPolycular.config())
  },
}
#macro ShaderPolycular global.__ShaderPolycular