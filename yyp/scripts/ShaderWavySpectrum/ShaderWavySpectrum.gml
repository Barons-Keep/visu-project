///@package io.alkapivo.shader.screen.shader_wavy_spectrum

///@static
///@type {Struct}
global.__ShaderWavySpectrum = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_angle: "FLOAT",
        u_brightness: "FLOAT",
        u_color_a: "COLOR",
        u_color_b: "COLOR",
        u_color_c: "COLOR",
        u_color_mask: "COLOR",
        u_distort: "FLOAT",
        u_hue: "FLOAT",
        u_noise: "FLOAT",
        u_offset: "VECTOR2",
        u_resolution: "RESOLUTION",
        u_sat: "FLOAT",
        u_seed: "CONST_FLOAT",
        u_scale: "FLOAT",
        u_time: "FLOAT",
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
      u_hue: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_color_a: {
        store: {
          value: "#ff0000",
          target: "#ff0000",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_color_b: {
        store: {
          value: "#00ff00",
          target: "#00ff00",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_color_c: {
        store: {
          value: "#0000ff",
          target: "#0000ff",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_color_mask: {
        store: {
          value: "#000000",
          target: "#000000",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_distort: {
        store: {
          value: 0.1,
          target: 0.1,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_noise: {
        store: {
          value: 3.0,
          target: 3.0,
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
      u_scale: {
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
          target: 999.9,
          duration: 999.9,
          ease: "LINEAR",
        },
        components: { }
      },
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_wavy_spectrum", ShaderWavySpectrum.template())
    Struct.set(config, "shader_wavy_spectrum", ShaderWavySpectrum.config())
  },
}

#macro ShaderWavySpectrum global.__ShaderWavySpectrum