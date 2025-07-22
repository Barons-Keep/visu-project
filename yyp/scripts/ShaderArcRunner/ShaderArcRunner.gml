///@package io.alkapivo.shader.screen.shader_arc_runner

///@static
///@type {Struct}
global.__ShaderArcRunner = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_angle: "FLOAT",
        u_bend: "FLOAT",
        u_brightness: "FLOAT",
        u_curves: "FLOAT",
        u_distortion: "FLOAT",
        u_frequency: "FLOAT",
        u_glow: "FLOAT",
        u_jumpiness: "FLOAT",
        u_scale: "FLOAT",
        u_speed: "FLOAT",
        u_time: "FLOAT",
        u_wiggle: "FLOAT",
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
          ease: "LINEAR"
        },
        components: { }
      },
      u_bend: {
        store: {
          value: 0.15,
          target: 0.15,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_brightness: {
        store: {
          value: 1.5,
          target: 1.5,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_curves: {
        store: {
          value: 2.0,
          target: 2.0,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_distortion: {
        store: {
          value: 0.01,
          target: 0.01,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_frequency: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_glow: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_jumpiness: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_scale: {
        store: {
          value: 1.5,
          target: 1.5,
          duration: 0.0,
          ease: "LINEAR"
        },
        components: { }
      },
      u_speed: {
        store: {
          value: 1.0,
          target: 1.0,
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
          ease: "LINEAR"
        },
        components: { }
      },
      u_wiggle: {
        store: {
          value: 2.0,
          target: 2.0,
          duration: 0.0,
          ease: "LINEAR"
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
        components: { }
      },
      u_tint: {
        store: {
          value: "#4f80e3",
          target: "#4f80e3",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_arc_runner", ShaderArcRunner.template())
    Struct.set(config, "shader_arc_runner", ShaderArcRunner.config())
  },
}
#macro ShaderArcRunner global.__ShaderArcRunner