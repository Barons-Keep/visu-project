///@package io.alkapivo.shader.screen.shader_wavy_lines

///@static
///@type {Struct}
global.__ShaderWavyLines = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_amplitude: "FLOAT",
        //u_audio_waveform: "AUDIO_WAVEFORM",
        u_angle: "FLOAT",
        u_bpm: "CONST_FLOAT",
        u_brightness: "FLOAT",
        u_corners: "FLOAT",
        u_density: "FLOAT",
        u_direction: "CONST_FLOAT",
        u_hue: "FLOAT",
        u_sat: "FLOAT",
        u_seed: "FLOAT",
        u_shift: "FLOAT",
        u_size: "CONST_FLOAT",
        u_thickness: "FLOAT",
        u_time: "FLOAT",
        u_zoom: "FLOAT",
        u_offset: "VECTOR2",
        u_resolution: "RESOLUTION",
        u_tint: "COLOR",
      },
    }
  },
  config: function() {
    return {
      u_amplitude: {
        store: {
          value: 1.0,
          target: 1.0,
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
      u_corners: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_density: {
        store: {
          value: 2.0,
          target: 2.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_direction: {
        store: { value: 1.0 },
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
      u_shift: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_size: {
        store: { value: 3.0 },
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
    Struct.set(shaders, "shader_wavy_lines", ShaderWavyLines.template())
    Struct.set(config, "shader_wavy_lines", ShaderWavyLines.config())
  },
}

#macro ShaderWavyLines global.__ShaderWavyLines