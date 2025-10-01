///@package io.alkapivo.shader.screen.shader_deep_space

///@static
///@type {Struct}
global.__ShaderDeepSpace = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_angle: "FLOAT",
        u_brightness: "FLOAT",
        u_darkmatter: "FLOAT",
        u_direction: "FLOAT",
        u_distfading: "FLOAT",
        u_opacity: "FLOAT",
        u_hue: "FLOAT",
        u_offset: "VECTOR2",
        u_resolution: "RESOLUTION",
        u_sat: "FLOAT",
        u_seed: "CONST_FLOAT",
        u_tile: "CONST_FLOAT",
        u_time: "FLOAT",
        u_tint: "COLOR",
        u_zoom: "FLOAT",
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
          value: 1.25,
          target: 1.25,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_darkmatter: {
        store: {
          value: 0.3,
          target: 0.3,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_direction: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_distfading: {
        store: {
          value: 0.8,
          target: 0.8,
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
      u_hue: {
        store: {
          value: 0.0,
          target: 0.0,
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
      u_tile: {
        store: { value: 8.5 },
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
      u_tint: {
        store: {
          value: "#ffffff",
          target: "#ffffff",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_zoom: {
        store: {
          value: 25.0,
          target: 25.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_deep_space", ShaderDeepSpace.template())
    Struct.set(config, "shader_deep_space", ShaderDeepSpace.config())
  },
}

#macro ShaderDeepSpace global.__ShaderDeepSpace