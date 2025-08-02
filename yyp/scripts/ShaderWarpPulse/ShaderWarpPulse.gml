///@package io.alkapivo.shader.screen.shader_warp_pulse

///@static
///@type {Struct}
global.__ShaderWarpPulse = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_angle: "FLOAT",
        u_brightness: "FLOAT",
        u_distortion: "FLOAT",
        u_factor_a: "FLOAT",
        u_factor_b: "FLOAT",
        u_hue: "FLOAT",
        u_sat: "FLOAT",
        u_seed: "CONST_FLOAT",
        u_size: "FLOAT",
        u_time: "FLOAT",
        u_treshold: "FLOAT",
        u_offset: "VECTOR2",
        u_resolution: "RESOLUTION",
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
          value: 0.2,
          target: 0.2,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_factor_a: {
        store: {
          value: 0.1,
          target: 0.1,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_factor_b: {
        store: {
          value: 0.9,
          target: 0.9,
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
      u_size: {
        store: {
          value: 4.0,
          target: 4.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_time: {
        store: {
          value: 0.0,
          target: 1000.0,
          duration: 2000.0,
          ease: "LINEAR",
        },
        components: { }
      },
      u_treshold: {
        store: {
          value: 0.001,
          target: 0.001,
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
      u_tint: {
        store: {
          value: "#504dda",
          target: "#504dda",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_warp_pulse", ShaderWarpPulse.template())
    Struct.set(config, "shader_warp_pulse", ShaderWarpPulse.config())
  },
}
#macro ShaderWarpPulse global.__ShaderWarpPulse