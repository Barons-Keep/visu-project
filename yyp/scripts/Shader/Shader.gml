///@package io.alkapivo.core.renderer.shader

#macro GMShader "GMShader"

///@enum
function _FancyBlendModes(): Enum() constructor {
  NORMAL = 0
  ADD = 1
  SUB = 2
  DARKEN = 3
  LIGHTEN = 4
  MULTIPLY = 5
  LINEAR_BURN = 6
  SCREEN = 7
  DIFFERENCE = 8
  EXCLUSION = 9
  COLOR_BURN = 10
  COLOR_DODGE = 11
  OVERLAY = 12
  SOFT_LIGHT = 13
  LINEAR_DODGE = 14
  HARD_LIGHT = 15
  VIVID_LIGHT = 16
  LINEAR_LIGHT = 17
  PIN_LIGHT = 18
  HUE = 19
  SATURATION = 20
  LUMINOSITY = 21
  COLOR = 22
  DARKER_COLOR = 23
  LIGHTER_COLOR = 24
  AVERAGE = 25
  REFLECT = 26
  GLOW = 27
  HARD_MIX = 28
  NEGATION = 29
  PHOENIX = 30
  SUBSTRACT = 31
}
global.__FancyBlendModes = new _FancyBlendModes()
#macro FancyBlendModes global.__FancyBlendModes


///@todo load from file
///@static
///@type {Struct}
global.__shaders = {
  "shader_nog_betere_2": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2",
      "iColor": "VECTOR3",
      "iMix": "FLOAT"
    }
  },
  "shader_art": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2",
      "iIterations": "FLOAT"
    }
  },
  "shader_octagrams": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2",
      "iIterations": "FLOAT",
      "iTint": "VECTOR3",
      "iWidth": "FLOAT",
      "iHeight": "FLOAT",
      "iDepth": "FLOAT",
      "iFactor": "FLOAT"
    }
  },
  "shader_70s_melt": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2",
      "iFactor": "FLOAT",
      "iTint": "VECTOR3",
      "iMix": "FLOAT",
    }
  },
  "shader_warp": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2"
    }
  },
  "shader_phantom_star": {
    "type": "GLSL_ES",
    "uniforms": {
      "iResolution": "VECTOR2",
      "iTime": "FLOAT",
      "iIterations": "FLOAT",
      "sizeA": "FLOAT",
      "sizeB": "FLOAT",
      "iTint": "VECTOR3"
    }
  },
  "shader_abberation": {
    "type": "GLSL_ES"
  },
  "shader_crt": {
    "type": "GLSL_ES",
    "uniforms": {
      "uni_crt_sizes": "VECTOR4",
      "uni_radial_distortion_amount": "FLOAT",
      "uni_use_radial_distortion": "FLOAT",
      "uni_use_border": "FLOAT",
      "uni_use_RGB_separation": "FLOAT",
      "uni_use_scanlines": "FLOAT",
      "uni_use_noise": "FLOAT",
      "uni_border_corner_size": "FLOAT",
      "uni_border_corner_smoothness": "FLOAT",
      "uni_brightness": "FLOAT",

      "uni_noise_strength": "FLOAT",
      "uni_timer": "FLOAT"
    }
  },
  "shader_emboss": {
    "type": "GLSL_ES",
    "uniforms": {
      "resolution": "RESOLUTION"
    }
  },
  "shader_hue": {
    "type": "GLSL_ES",
    "uniforms": {
      "colorShift": "FLOAT"
    }
  },
  "shader_led": {
    "type": "GLSL_ES",
    "uniforms": {
      "resolution": "RESOLUTION",
      "ledSize": "FLOAT",
      "brightness": "FLOAT"
    }
  },
  "shader_magnify": {
    "type": "GLSL_ES",
    "uniforms": {
      "resolution": "RESOLUTION",
      "position": "VECTOR2",
      "radius": "FLOAT",
      "minZoom": "FLOAT",
      "maxZoom": "FLOAT"
    }
  },
  "shader_mosaic": {
    "type": "GLSL_ES",
    "uniforms": {
      "resolution": "RESOLUTION",
      "amount": "FLOAT"
    }
  },
  "shader_posterization": {
    "type": "GLSL_ES",
    "uniforms": {
      "gamma": "FLOAT",
      "colorNumber": "FLOAT"
    }
  },
  "shader_revert": {
    "type": "GLSL_ES"
  },
  "shader_ripple": {
    "type": "GLSL_ES",
    "uniforms": {
      "resolution": "RESOLUTION",
	    "position": "VECTOR2",
	    "amount": "FLOAT",
	    "distortion": "FLOAT",
	    "speed": "FLOAT",
	    "time": "FLOAT"
    }
  },
  "shader_scanlines": {
    "type": "GLSL_ES",
    "uniforms": {
      "resolution": "RESOLUTION",
      "color": "COLOR"
    }
  },
  "shader_shock_wave": {
    "type": "GLSL_ES",
    "uniforms": {
      "resolution": "RESOLUTION",
      "position": "VECTOR2",
      "amplitude": "FLOAT",
      "refraction": "FLOAT",
      "width": "FLOAT",
      "time": "FLOAT"
    }
  },
  "shader_sketch": {
    "type": "GLSL_ES",
    "uniforms": {
      "resolution": "RESOLUTION",
      "intensity": "FLOAT"
    }
  },
  "shader_thermal": {
    "type": "GLSL_ES"
  },
  "shader_wave": {
    "type": "GLSL_ES",
    "uniforms": {
      "amount": "FLOAT",
      "distortion": "FLOAT",
      "speed": "FLOAT",
      "time": "FLOAT"
    }
  },
  "shader_cineshader_lava": {
    "type": "GLSL_ES",
    "uniforms": {
      "iResolution": "VECTOR3",
      "iTime": "FLOAT",
      "iTreshold": "FLOAT",
      "iSize": "VECTOR3"
    }
  },
  "shader_broken_time_portal": {
    "type": "GLSL_ES",
    "uniforms": {
      "iResolution": "VECTOR3",
      "iTime": "FLOAT",
      "iTreshold": "FLOAT",
      "iSize": "FLOAT",
      "iTint": "VECTOR3"
    }
  },
  "shader_base_warp_fbm": {
    "type": "GLSL_ES",
    "uniforms": {
      "iResolution": "VECTOR3",
      "iTime": "FLOAT",
      "iSize": "FLOAT"
    }
  },
  "shader_dive_to_cloud": {
    "type": "GLSL_ES",
    "uniforms": {
      "iResolution": "VECTOR2",
      "iTime": "FLOAT"
    }
  },
  "shader_cubular": {
    "type": "GLSL_ES",
    "uniforms": {
      "iResolution": "VECTOR3",
      "iTime": "FLOAT",
      "iTint": "VECTOR3",
      "size": "FLOAT",
      "amount": "FLOAT"
    }
  },
  "shader_sincos_3d": {
    "type": "GLSL_ES",
    "uniforms": {
      "iResolution": "VECTOR3",
      "iTime": "FLOAT",
      "iMouse": "VECTOR4",
      "lineThickness": "FLOAT",
      "pointRadius": "FLOAT"
    }
  },
  "shader_lighting_with_glow": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2",
      "iFactor": "FLOAT"
    }
  },
  "shader_discoteq_2": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2"
    }
  },
  "shader_ui_noise_halo": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2"
    }
  },
  "shader_colors_embody": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2",
      "iSize": "FLOAT",
      "iDistance": "FLOAT"
    }
  },
  "shader_grid_space": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2"
    }
  },
  "shader_002_blue": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2",
      "iIterations": "FLOAT",
      "iSize": "FLOAT",
      "iPhase": "FLOAT",
      "iTreshold": "FLOAT",
      "iDistance": "FLOAT",
      "iTint": "VECTOR3"
    }
  },
  "shader_monster": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2",
      "iTint": "VECTOR3",
      "iSize": "FLOAT"
    }
  },
  "shader_clouds_2d": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2"
    }
  },
  "shader_flame": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2",
      "iPosition": "VECTOR3",
      "iIterations": "FLOAT"
    }
  },
  "shader_whirlpool": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2",
      "iIterations": "FLOAT",
      "iSize": "FLOAT",
      "iFactor": "FLOAT"
    }
  },
  "shader_warp_speed_2": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2",
      "iIterations": "FLOAT",
      "iSize": "VECTOR2",
      "iFactor": "FLOAT",
      "iSeed": "VECTOR3"
    }
  },
  "shader_star_nest": {
    "type": "GLSL_ES",
    "uniforms": {
      "iTime": "FLOAT",
      "iResolution": "VECTOR2",
      "iAngle": "FLOAT",
      "iZoom": "FLOAT",
      "iTile": "FLOAT",
      "iSpeed": "FLOAT",
      "iBrightness": "FLOAT",
      "iDarkmatter": "FLOAT",
      "iDistfading": "FLOAT",
      "iSaturation": "FLOAT",
      "iBlend": "VECTOR3",
    }
  },
}
#macro SHADERS global.__shaders


///@static
///@type {Struct}
global.__depreacted_shaders = {
  "shader_nog_betere_2": true,
  "shader_art": true,
  "shader_octagrams": true,
  "shader_70s_melt": true,
  "shader_warp": true,
  "shader_phantom_star": true,
  "shader_abberation": true,
  "shader_crt": true,
  "shader_clouds_2d": true,
  "shader_emboss": true,
  "shader_hue": true,
  "shader_led": true,
  "shader_magnify": true,
  "shader_mosaic": true,
  "shader_posterization": true,
  "shader_revert": true,
  "shader_ripple": true,
  "shader_scanlines": true,
  "shader_shock_wave": true,
  "shader_sketch": true,
  "shader_thermal": true,
  "shader_wave": true,
  "shader_cineshader_lava": true,
  "shader_broken_time_portal": true,
  "shader_base_warp_fbm": true,
  "shader_dive_to_cloud": true,
  "shader_cubular": true,
  "shader_sincos_3d": true,
  "shader_lighting_with_glow": true,
  "shader_discoteq_2": true,
  "shader_ui_noise_halo": true,
  "shader_colors_embody": true,
  "shader_grid_space": true,
  "shader_002_blue": true,
  "shader_monster": true,
  "shader_flame": true,
  "shader_whirlpool": true,
  "shader_warp_speed_2": true,
  "shader_star_nest": true,
}
#macro DEPRECATED_SHADERS global.__depreacted_shaders


///@static
///@type {Struct}
global.__SHADER_CONFIGS = {
  "shader_octagrams": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
    "iIterations": { __type: "FLOAT" },
    "iTint": { __type: "VECTOR3" },
    "iWidth": { __type: "FLOAT" },
    "iHeight": { __type: "FLOAT" },
    "iDepth": { __type: "FLOAT" },
    "iFactor": { __type: "FLOAT" },
  },
  "shader_70s_melt": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
    "iFactor": { __type: "FLOAT" },
    "iTint": { __type: "VECTOR3" },
    "iMix": { __type: "FLOAT" },
  },
  "shader_warp": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
  },
  "shader_phantom_star": {
    "iResolution": { __type: "VECTOR2" },
    "iTime": { __type: "FLOAT" },
    "iIterations": { __type: "FLOAT" },
    "sizeA": { __type: "FLOAT" },
    "sizeB": { __type: "FLOAT" },
    "iTint": { __type: "VECTOR3" },
  },
  "shader_abberation": {
    "type": "GLSL_ES"
  },
  "shader_crt": {
    "uni_crt_sizes": { __type: "VECTOR4" },
    "uni_radial_distortion_amount": { __type: "FLOAT" },
    "uni_use_radial_distortion": { __type: "FLOAT" },
    "uni_use_border": { __type: "FLOAT" },
    "uni_use_RGB_separation": { __type: "FLOAT" },
    "uni_use_scanlines": { __type: "FLOAT" },
    "uni_use_noise": { __type: "FLOAT" },
    "uni_border_corner_size": { __type: "FLOAT" },
    "uni_border_corner_smoothness": { __type: "FLOAT" },
    "uni_brightness": { __type: "FLOAT" },
    "uni_noise_strength": { __type: "FLOAT" },
    "uni_timer": { __type: "FLOAT" },
  },
  "shader_emboss": {
    "resolution": { __type: "RESOLUTION" },
  },
  "shader_hue": {
    "colorShift": {
      value: {
        increase: { factor: 0.1, },
        decrease: { factor: -0.1, },
      },
      target: {
        increase: { factor: 0.1, },
        decrease: { factor: -0.1, },
      },
      factor: {
        increase: { factor: 0.01, },
        decrease: { factor: -0.01, },
      },
      increase: {
        increase: { factor: 0.0001, },
        decrease: { factor: -0.0001, },
      },
    }
  },
  "shader_led": {
    "resolution": "RESOLUTION",
      "ledSize": { __type: "FLOAT" },
    "brightness": { __type: "FLOAT" },
  },
  "shader_magnify": {
    "resolution": "RESOLUTION",
      "position": { __type: "VECTOR2" },
    "radius": { __type: "FLOAT" },
    "minZoom": { __type: "FLOAT" },
    "maxZoom": { __type: "FLOAT" },
  },
  "shader_mosaic": {
    "resolution": "RESOLUTION",
      "amount": { __type: "FLOAT" },
  },
  "shader_posterization": {
    "gamma": { __type: "FLOAT" },
    "colorNumber": { __type: "FLOAT" },
  },
  "shader_revert": {
    "type": "GLSL_ES"
  },
  "shader_ripple": {
    "resolution": "RESOLUTION",
      "position": { __type: "VECTOR2" },
    "amount": { __type: "FLOAT" },
    "distortion": { __type: "FLOAT" },
    "speed": { __type: "FLOAT" },
    "time": { __type: "FLOAT" },
  },
  "shader_scanlines": {
    "resolution": "RESOLUTION",
      "color": { __type: "COLOR" },
  },
  "shader_shock_wave": {
    "resolution": "RESOLUTION",
      "position": { __type: "VECTOR2" },
    "amplitude": { __type: "FLOAT" },
    "refraction": { __type: "FLOAT" },
    "width": { __type: "FLOAT" },
    "time": { __type: "FLOAT" },
  },
  "shader_sketch": {
    "resolution": "RESOLUTION",
      "intensity": { __type: "FLOAT" },
  },
  "shader_thermal": {
    "type": "GLSL_ES"
  },
  "shader_wave": {
    "amount": { __type: "FLOAT" },
    "distortion": { __type: "FLOAT" },
    "speed": { __type: "FLOAT" },
    "time": { __type: "FLOAT" },
  },
  "shader_cineshader_lava": {
    "iResolution": { __type: "VECTOR3" },
    "iTime": { __type: "FLOAT" },
    "iTreshold": { __type: "FLOAT" },
    "iSize": { __type: "VECTOR3" },
  },
  "shader_broken_time_portal": {
    "iResolution": { __type: "VECTOR3" },
    "iTime": { __type: "FLOAT" },
    "iTreshold": { __type: "FLOAT" },
    "iSize": { __type: "FLOAT" },
    "iTint": { __type: "VECTOR3" },
  },
  "shader_base_warp_fbm": {
    "iResolution": { __type: "VECTOR3" },
    "iTime": { __type: "FLOAT" },
    "iSize": { __type: "FLOAT" },
  },
  "shader_dive_to_cloud": {
    "iResolution": { __type: "VECTOR2" },
    "iTime": { __type: "FLOAT" },
  },
  "shader_cubular": {
    "iResolution": { __type: "VECTOR3" },
    "iTime": { __type: "FLOAT" },
    "iTint": { __type: "VECTOR3" },
    "size": { __type: "FLOAT" },
    "amount": { __type: "FLOAT" },
  },
  "shader_sincos_3d": {
    "iResolution": { __type: "VECTOR3" },
    "iTime": { __type: "FLOAT" },
    "iMouse": { __type: "VECTOR4" },
    "lineThickness": { __type: "FLOAT" },
    "pointRadius": { __type: "FLOAT" },
  },
  "shader_lighting_with_glow": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
    "iFactor": { __type: "FLOAT" },
  },
  "shader_discoteq_2": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
  },
  "shader_ui_noise_halo": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
  },
  "shader_colors_embody": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
    "iSize": { __type: "FLOAT" },
    "iDistance": { __type: "FLOAT" },
  },
  "shader_grid_space": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
  },
  "shader_002_blue": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
    "iIterations": { __type: "FLOAT" },
    "iSize": { __type: "FLOAT" },
    "iPhase": { __type: "FLOAT" },
    "iTreshold": { __type: "FLOAT" },
    "iDistance": { __type: "FLOAT" },
    "iTint": { __type: "VECTOR3" },
  },
  "shader_monster": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
    "iTint": { __type: "VECTOR3" },
    "iSize": { __type: "FLOAT" },
  },
  "shader_clouds_2d": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
  },
  "shader_flame": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
    "iPosition": { __type: "VECTOR3" },
    "iIterations": { __type: "FLOAT" },
  },
  "shader_whirlpool": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
    "iIterations": { __type: "FLOAT" },
    "iSize": { __type: "FLOAT" },
    "iFactor": { __type: "FLOAT" },
  },
  "shader_warp_speed_2": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
    "iIterations": { __type: "FLOAT" },
    "iSize": { __type: "VECTOR2" },
    "iFactor": { __type: "FLOAT" },
    "iSeed": { __type: "VECTOR3" },
  },
  "shader_star_nest": {
    "iTime": { __type: "FLOAT" },
    "iResolution": { __type: "VECTOR2" },
    "iAngle": { __type: "FLOAT" },
    "iZoom": { __type: "FLOAT" },
    "iTile": { __type: "FLOAT" },
    "iSpeed": { __type: "FLOAT" },
    "iBrightness": { __type: "FLOAT" },
    "iDarkmatter": { __type: "FLOAT" },
    "iDistfading": { __type: "FLOAT" },
    "iSaturation": { __type: "FLOAT" },
    "iBlend": { __type: "VECTOR3" },
  },
}
#macro SHADER_CONFIGS global.__SHADER_CONFIGS


///@static
///@type {Struct}
global.__shadersWASM = {

}
#macro SHADERS_WASM global.__shadersWASM


///@enum
function _ShaderType(): Enum() constructor {
  GLSL = "GLSL"
  GLSL_ES = "GLSL_ES"
  HLSL_11 = "HLSL_11"
}
global.__ShaderType = new _ShaderType()
#macro ShaderType global.__ShaderType


///@param {GMShader} _asset
///@param {Struct} json
function Shader(_asset, json) constructor {

  ///@type {GMShader} 
  asset = Core.getRuntimeType() == RuntimeType.GXGAMES 
    ? _asset 
    : Assert.isType(_asset, GMShader)

  ///@type {String}
  name = Assert.isType(Core.getRuntimeType() == RuntimeType.GXGAMES 
    ? Struct.get(json, "name") 
    : shader_get_name(_asset), String) 

  ///@type {String}
  //type = Assert.isEnum(json.type, ShaderType)

  ///@type {Map<String, ShaderUniform>}
  uniforms = Struct
    .toMap(
      Struct.getIfType(json, "uniforms", Struct, { }), 
      String, 
      ShaderUniform,
      function(type, name, asset) {
        var prototype = ShaderUniformType.get(type)
        return Assert.isType(new prototype(asset, name, type), ShaderUniform)
      },
      this.asset
    )

  samplers = Struct
    .toMap(
      Struct.getIfType(json, "samplers", Struct, { }), 
      String, 
      ShaderSampler,
      function(update, name, asset) {
        return new ShaderSampler(asset, name, update)
      },
      this.asset
    )
}


///@static
function _ShaderUtil() constructor {

  ///@param {String} _name
  ///@return {?Shader}
  static fetch = function(_name) {
    var name = Core.getRuntimeType() == RuntimeType.GXGAMES
      ? (Struct.contains(SHADERS_WASM, _name) ? Struct.get(SHADERS_WASM, _name) : _name)
      : _name
    var asset = asset_get_index(name)
    if (asset == -1) {
      Logger.warn("ShaderUtil", String.template("{0} does not exist: { \"name\": \"{1}\" }", GMShader, name))
      return null
    }

    if (!shader_is_compiled(asset)) {
      Logger.warn("ShaderUtil", String.template("{0} is not compiled: { \"name\": \"{1}\" }", "Shader", name))
      return null
    }

    var config = Struct.get(SHADERS, name)
    if (!Core.isType(config, Struct)) {
      Logger.warn("ShaderUtil", String.template("{0} was not found in SHADERS: { \"name\": \"{1}\" }", "Shader", name))
      config = {}
    }
    Struct.set(config, "name", name)

    try {
      return new Shader(asset, config)
    } catch (exception) {
      Logger.warn("ShaderUtil", exception.message)
    }
    
    return null
  }
}
global.__ShaderUtil = new _ShaderUtil()
#macro ShaderUtil global.__ShaderUtil

