///@package com.janvorisek.bktglitch.shader.bkt_glitch

///@static
///@type {Struct}
global.__ShaderBKTGlitch = {
  template: function() {
    return {
      type: "GLSL",
      uniforms: {
        intensity: "FLOAT",
        time: "FLOAT",
        resolution: "RESOLUTION",
        rngSeed: "FLOAT",
        //randomValues: "VECTOR3",
        lineSpeed: "FLOAT",
        lineDrift: "FLOAT",
        lineResolution: "FLOAT",
        lineVertShift: "FLOAT",
        lineShift: "FLOAT",
        jumbleness: "FLOAT",
        jumbleResolution: "FLOAT",
        jumbleShift: "FLOAT",
        jumbleSpeed: "FLOAT",
        dispersion: "FLOAT",
        channelShift: "FLOAT",
        noiseLevel: "FLOAT",
        shakiness: "FLOAT",
      },
      samplers: {
        noiseTexture: function(shader, sampler) {
          static generateNoiseTexture = function() {
            var seed = int64(max(1, random_get_seed()))
            var size = NOISE_TEXTURE_SIZE
            var buffer = buffer_create(size * size * 4, buffer_fixed, 1)
            repeat ((size * size) / 2) {
              var value = int64(seed)
              value ^= value << 13
              value ^= value >> 7
              value ^= value << 17
              seed = value
              buffer_write(buffer, buffer_u64, seed)
            }
            var surface = surface_create(size, size)
            buffer_set_surface(buffer, surface, 0)
            
            var asset = sprite_create_from_surface(surface, 0, 0, size, size, false, false, 0, 0)
            surface_free(surface)
            buffer_delete(buffer)
            return asset
          }
          
          if (!Core.isType(!global.bktGlitchNoiseSprite, GMTexture)) {
            global.bktGlitchNoiseSprite = generateNoiseTexture()
          }

          gpu_set_tex_repeat_ext(shader.asset, true)
          gpu_set_tex_filter_ext(shader.asset, false)
          texture_set_stage(shader.asset, sprite_get_texture(global.bktGlitchNoiseSprite, 0))
        }
      },
    }
  },
  config: function() {
    return {
      intensity: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 5.0),
      },
      time: {
        store: {
          value: 0.0,
          target: 1000.0,
          duration: 1000.0,
          ease: "LINEAR",
        },
        components: { },
      },
      rngSeed: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: {
          value: {
            factor: 0.01,
            stick: { factor: 0.01 },
          }
        },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 1.0),
      },
      lineSpeed: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: {
          value: {
            factor: 0.01,
            stick: { factor: 0.01 },
          }
        },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 0.5),
      },
      lineShift: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: {
          value: {
            factor: 0.001,
            stick: { factor: 0.001 },
          }
        },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 0.05),
      },
      lineResolution: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 3.0),
      },
      lineVertShift: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: {
          value: {
            factor: 0.01,
            stick: { factor: 0.01 },
          }
        },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 1.0),
      },
      lineDrift: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: {
          value: {
            factor: 0.01,
            stick: { factor: 0.01 },
          }
        },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 1.0),
      },
      jumbleness: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: {
          value: {
            factor: 0.01,
            stick: { factor: 0.01 },
          }
        },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 1.0),
      },
      jumbleResolution: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: {
          value: {
            factor: 0.01,
            stick: { factor: 0.01 },
          }
        },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 1.0),
      },
      jumbleShift: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: {
          value: {
            factor: 0.01,
            stick: { factor: 0.01 },
          }
        },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 1.0),
      },
      jumbleSpeed: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, SHROOM_SPAWN_AMOUNT),
      },
      dispersion: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: {
          value: {
            factor: 0.01,
            stick: { factor: 0.01 },
          }
        },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 0.5),
      },
      channelShift: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: {
          value: {
            factor: 0.001,
            stick: { factor: 0.001 },
          }
        },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 0.05),
      },
      noiseLevel: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: {
          value: {
            factor: 0.01,
            stick: { factor: 0.01 },
          }
        },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 1.0),
      },
      shakiness: {
        store: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: "LINEAR",
        },
        components: { },
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 10.0),
      },
    }
  },
  install: function(shaders, config) {
    Struct.set(shaders, "shader_bkt_glitch", ShaderBKTGlitch.template())
    Struct.set(config, "shader_bkt_glitch", ShaderBKTGlitch.config())
  },
}
#macro ShaderBKTGlitch global.__ShaderBKTGlitch
