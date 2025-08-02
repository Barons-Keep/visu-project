///@package io.alkapivo.shader.screen.shader_wavy_mesh

///@static
///@type {Struct}
global.__ShaderWavyMesh = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_angle: "FLOAT",
        u_border: "FLOAT",
        u_brightness: "FLOAT",
        u_color_between: "COLOR",
        u_color_bkg: "COLOR",
        u_color_mesh: "COLOR",
        u_fbm_scale: "FLOAT",
        u_fbm_size: "FLOAT",
        u_hue: "FLOAT",
        u_seed: "CONST_FLOAT",
        u_jitter: "FLOAT",
        u_mesh_size: "FLOAT",
        u_offset: "VECTOR2",
        u_resolution: "RESOLUTION",
        u_sat: "FLOAT",
        u_shift: "FLOAT",
        u_thickness: "FLOAT",
        u_time: "FLOAT",
      },
    }
  },
  config: function() {
    return {
      u_brightness: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_fbm_size: {
        store: {
          value: 0.5,
          target: 0.5,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_border: {
        store: {
          value: 0.01,
          target: 0.01,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_fbm_scale: {
        store: {
          value: 0.5,
          target: 0.5,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_fbm_size: {
        store: {
          value: 0.5,
          target: 0.5,
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
      u_jitter: {
        store: {
          value: 0.5,
          target: 0.5,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_seed: {
        store: { value: 0.0 },
        components: { },
      },
      u_mesh_size: {
        store: {
          value: 2.0,
          target: 2.0,
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
      u_shift: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_thickness: {
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
          duration: 2000.0,
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
      u_color_between: {
        store: {
          value: "#00ff00",
          target: "#00ff00",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_color_bkg: {
        store: {
          value: "#0000ff",
          target: "#0000ff",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_color_mesh: {
        store: {
          value: "#0000ff",
          target: "#0000ff",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_wavy_mesh", ShaderWavyMesh.template())
    Struct.set(config, "shader_wavy_mesh", ShaderWavyMesh.config())
  },
}
#macro ShaderWavyMesh global.__ShaderWavyMesh