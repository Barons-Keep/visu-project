///@package io.alkapivo.shader.screen.shader_cloudy_sky

///@static
///@type {Struct}
global.__ShaderCloudySky = {
  template: function() {
    return {
      type: "GLSL_ES",
      uniforms: {
        u_angle: "CONST_FLOAT",
        u_brightness: "FLOAT",
        u_cloud_coverage: "FLOAT",
        u_cloud_dark: "FLOAT",
        u_cloud_light: "FLOAT",
        u_hue: "FLOAT",
        u_sat: "FLOAT",
        u_seed: "CONST_FLOAT",
        u_sky_alpha: "FLOAT",
        u_speed: "CONST_FLOAT",
        u_time: "FLOAT",
        u_zoom: "FLOAT",
        u_offset: "VECTOR2",
        u_resolution: "RESOLUTION",
        u_sky_color_bottom: "COLOR",
        u_sky_color_top: "COLOR",
        u_tint: "COLOR",
      },
    }
  },
  config: function() {
    return {
      u_angle: {
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
      u_cloud_coverage: {
        store: {
          value: 0.5,
          target: 0.5,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_cloud_dark: {
        store: {
          value: 0.5,
          target: 0.5,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_cloud_light: {
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
      u_sky_alpha: {
        store: {
          value: 1.0,
          target: 1.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_speed: {
        store: { value: 0.03 },
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
      u_sky_color_bottom: {
        store: {
          value: "#66b3ff",
          target: "#66b3ff",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
      },
      u_sky_color_top: {
        store: {
          value: "#336699",
          target: "#336699",
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
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
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_cloudy_sky", ShaderCloudySky.template())
    Struct.set(config, "shader_cloudy_sky", ShaderCloudySky.config())
  },
}

#macro ShaderCloudySky global.__ShaderCloudySky