///@package io.alkapivo.shader.screen.shader_fractal_bloom

///@static
///@type {Struct}
global.__ShaderFractalBloom = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_angle: "FLOAT",
        u_bpm: "CONST_FLOAT",
        u_brightness: "FLOAT",
        u_contrast: "FLOAT",
        u_distortion: "FLOAT",
        u_factor: "FLOAT",
        u_hue: "FLOAT",
        u_neon: "FLOAT",
        u_points: "CONST_FLOAT",
        u_sat: "FLOAT",
        u_scale: "FLOAT",
        u_seed: "CONST_FLOAT",
        u_shift: "FLOAT",
        u_size: "FLOAT",
        u_time: "FLOAT",
        u_base: "VECTOR2",
        u_offset: "VECTOR2",
        u_resolution: "RESOLUTION",
        u_rotation: "VECTOR2",
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
      u_bpm: {
        store: { value: 0.0 },
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
      u_contrast: {
        store: {
          value: 1.5,
          target: 1.5,
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
      u_factor: {
        store: {
          value: 20.0,
          target: 20.0,
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
      u_neon: {
        store: {
          value: 1.5,
          target: 1.5,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_points: {
        store: { value: 5.0 },
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
      u_scale: {
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
        components: { }
      },
      u_base: {
        store: {
          x: {
            value: 6.14,
            target: 6.14,
            duration: 0.0,
            ease: "LINEAR",
          },
          y: {
            value: 7.36,
            target: 7.36,
            duration: 0.0,
            ease: "LINEAR",
          },
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
      u_rotation: {
        store: {
          x: {
            value: 5.0,
            target: 5.0,
            duration: 0.0,
            ease: "LINEAR",
          },
          y: {
            value: 15.0,
            target: 15.0,
            duration: 0.0,
            ease: "LINEAR",
          },
        },
        components: { },
      },
      u_tint: {
        store: {
          value: "#000000",
          target: "#000000",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_fractal_bloom", ShaderFractalBloom.template())
    Struct.set(config, "shader_fractal_bloom", ShaderFractalBloom.config())
  },
}
#macro ShaderFractalBloom global.__ShaderFractalBloom