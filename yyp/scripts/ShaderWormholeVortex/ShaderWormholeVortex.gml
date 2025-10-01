///@package io.alkapivo.shader.screen.shader_wormhole_vortex

///@static
///@type {Struct}
global.__ShaderWormholeVortex = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_angle: "FLOAT",
        u_bold: "FLOAT",
        u_bpm: "CONST_FLOAT",
        u_brightness: "FLOAT",
        u_color_in: "COLOR",
        u_color_out: "COLOR",
        u_depth: "CONST_FLOAT",
        u_direction: "CONST_FLOAT",
        u_glare: "FLOAT",
        u_hue: "FLOAT",
        u_intensity: "CONST_FLOAT",
        u_invert: "CONST_FLOAT",
        u_iterations: "CONST_FLOAT",
        u_offset: "VECTOR2",
        u_resolution: "RESOLUTION",
        u_rotation: "CONST_FLOAT",
        u_sat: "FLOAT",
        u_seed: "CONST_FLOAT",
        u_shift: "CONST_FLOAT",
        u_size: "CONST_FLOAT",
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
      u_bold: {
        store: {
          value: 2.0,
          target: 2.0,
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
      u_color_in: {
        store: {
          value: "#19b2b2",
          target: "#19b2b2",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_color_out: {
        store: {
          value: "#19ff19",
          target: "#19ff19",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_depth: {
        store: { value: 2.0 },
        components: { },
      },
      u_direction: {
        store: { value: -1.0 },
        components: { },
      },
      u_glare: {
        store: {
          value: 0.1,
          target: 0.1,
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
        store: { value: 3.0 },
        components: { },
      },
      u_invert: {
        store: { value: 1.0 },
        components: { },
      },
      u_iterations: {
        store: { value: 30.0 },
        components: { },
      },
      u_rotation: {
        store: { value: 1.0 },
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
        store: { value: 0.1 },
        components: { },
      },
      u_size: {
        store: { value: 0.7 },
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
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_wormhole_vortex", ShaderWormholeVortex.template())
    Struct.set(config, "shader_wormhole_vortex", ShaderWormholeVortex.config())
  },
}

#macro ShaderWormholeVortex global.__ShaderWormholeVortex