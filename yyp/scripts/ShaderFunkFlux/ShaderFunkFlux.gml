///@package io.alkapivo.shader.screen.shader_funk_flux

///@static
///@type {Struct}
global.__ShaderFunkFlux = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_angle: "FLOAT",
        u_density: "FLOAT",
        u_sat: "FLOAT",
        u_hue: "FLOAT",
        u_scale: "FLOAT",
        u_seed: "FLOAT",
        u_sharp: "FLOAT",
        u_speed: "FLOAT",
        u_time: "FLOAT",
        u_treshold: "FLOAT",
        u_offset: "VECTOR2",
        u_resolution: "RESOLUTION",
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
          ease: "LINEAR"
        },
        components: { }
      },
      u_density: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_sat: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_hue: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_seed: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_sharp: {
        store: {
          value: 0.25,
          target: 0.25,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_scale: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_speed: {
        store: {
          value: 10.0,
          target: 10.0,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
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
      u_treshold: {
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
            "value": 0.5,
            "target": 0.5,
            "duration": 0.0,
            "ease": "LINEAR",
          },
          y: {
            "value": 0.5,
            "target": 0.5,
            "duration": 0.0,
            "ease": "LINEAR",
          },
        },
        components: { }
      },
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_funk_flux", ShaderFunkFlux.template())
    Struct.set(config, "shader_funk_flux", ShaderFunkFlux.config())
  },
}
#macro ShaderFunkFlux global.__ShaderFunkFlux