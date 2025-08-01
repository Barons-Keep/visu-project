///@package io.alkapivo.visu

///@type {Number}
global.__MAGIC_NUMBER_TASK = 12
#macro MAGIC_NUMBER_TASK global.__MAGIC_NUMBER_TASK

///@type {Number}
global.__SYNC_UI_STORE_STEP = 12
#macro SYNC_UI_STORE_STEP global.__SYNC_UI_STORE_STEP

///@type {Number}
global.__BRUSH_ENTRY_STEP = 1
#macro BRUSH_ENTRY_STEP global.__BRUSH_ENTRY_STEP

///@type {Number}
global.__BRUSH_TOOLBAR_ENTRY_STEP = 1
#macro BRUSH_TOOLBAR_ENTRY_STEP global.__BRUSH_TOOLBAR_ENTRY_STEP

///@type {Number}
global.__FLIP_VALUE = 1
#macro FLIP_VALUE global.__FLIP_VALUE

///@hack
#macro TEMPLATE_ENTRY_STEP global.__BRUSH_ENTRY_STEP
#macro TEMPLATE_TOOLBAR_ENTRY_STEP global.__BRUSH_TOOLBAR_ENTRY_STEP
#macro EVENT_INSPECTOR_ENTRY_STEP global.__BRUSH_TOOLBAR_ENTRY_STEP

///@enum
function _GameMode(): Enum() constructor {
  RACING = "racing"
  BULLETHELL = "bulletHell"
  PLATFORMER = "platformer"
}
global.__GameMode = new _GameMode()
#macro GameMode global.__GameMode


///@static
function _Visu() constructor {

  ///@type {Settings}
  settings = new Settings($"{game_save_id}visu-settings.json")

  ///@private
  ///@type {?Struct}
  _assets = null

  ///@private
  ///@type {?Struct}
  _modules = null

  ///@private
  ///@type {?String}
  _version = null

  ///@private
  ///@type {?String}
  _serverVersion = null

  ///@private
  ///@type {?CLIParamParser}
  _cliParser = null

  ///@private
  ///@type {Struct}
  shaderTemplates = {
    "shader-default": { 
      "shader": "shader_revert",
    },
  }

  ///@private
  ///@type {Struct}
  shroomTemplates = {
    "shroom-default": {
      "sprite": { "name": "texture_baron" },
      "gameModes":{
        "bulletHell":{ "features": [] },
        "platformer": { "features": [] },
        "racing":{ "features": [] },
      },
    },
  }

  ///@private
  ///@type {Struct}
  bulletTemplates = {
    "bullet-default": {
      "gameModes":{
        "bulletHell": { "features": [] },
        "platformer": { "features": [] },
        "racing": { "features": [] },
      },
      "sprite":{
        "name":"texture_bullet"
      },
      "mask":{
        "x": 16,
        "y": 16,
        "width":32.0,
        "height":32.0
      },
    },
  }

  ///@private
  ///@type {Struct}
  coinTemplates = {
    "coin-default": {
      "sprite": { 
        "name": "texture_baron"
      },
      "category": CoinCategory.POINT,
    },
    "coin-empty":{
      "amount":0.0,
      "speed":{
        "value":10.0,
        "factor":999.0,
        "target":10.0,
        "increase":0.0
      },
      "sprite":{
        "frame":0.0,
        "name":"texture_empty",
        "animate":false,
        "blend":"#FFFFFF",
        "alpha":1.0,
        "angle":0.0,
        "scaleX":1.0,
        "speed":30.0,
        "scaleY":1.0
      },
      "name":"coin-empty",
      "category":"point"
    },
    "coin-point":{
      "amount":1.0,
      "speed":{
        "value":-2.0,
        "factor":0.040000000000000001,
        "target":1.5,
        "increase":0.0
      },
      "sprite":{
        "frame":0.0,
        "name":"texture_coin_point",
        "animate":false,
        "blend":"#FFFFFF",
        "alpha":1.0,
        "angle":0.0,
        "scaleX":4.0,
        "speed":30.0,
        "scaleY":4.0
      },
      "name":"coin-point",
      "category":"point"
    },
    "coin-life":{
      "amount":1.0,
      "speed":{
        "value":-3.7999999999999998,
        "factor":0.050000000000000003,
        "target":1.8,
        "increase":0.0
      },
      "sprite":{
        "frame":0.0,
        "name":"texture_coin_life",
        "animate":false,
        "blend":"#FFFFFF",
        "alpha":1.0,
        "angle":0.0,
        "scaleX":6.0,
        "speed":30.0,
        "scaleY":6.0
      },
      "name":"coin-life",
      "category":"life"
    },
    "coin-bomb":{
      "speed":{
        "value":-4.0,
        "factor":0.050000000000000003,
        "target":1.8,
        "increase":0.0
      },
      "sprite":{
        "frame":0.0,
        "name":"texture_coin_bomb",
        "animate":false,
        "blend":"#FFFFFF",
        "alpha":1.0,
        "angle":0.0,
        "scaleX":6.0,
        "speed":30.0,
        "scaleY":6.0
      },
      "name":"coin-bomb",
      "category":"bomb"
    },
    "coin-force":{
      "amount":1.0,
      "speed":{
        "value":-2.5,
        "factor":0.050000000000000003,
        "target":1.5,
        "increase":0.0
      },
      "sprite":{
        "frame":0.0,
        "name":"texture_coin_force",
        "animate":false,
        "blend":"#FFFFFF",
        "alpha":1.0,
        "angle":0.0,
        "scaleX":5.0,
        "speed":30.0,
        "scaleY":5.0
      },
      "name":"coin-force",
      "category":"force"
    },
  }

  ///@private
  ///@type {Struct}
  subtitleTemplates = {
    "subtitle-default": {
      "lines": [ "Lorem ipsum" ]
    },
    "subtitle-preview-mode": {
      "lines": [
        "[SYSTEM] preview-mode detected",
        "[SYSTEM] Showing preview-mode message",
        "",
        "         Z     - Shoot",
        "         X     - Use bomb",
        "         SHIFT - Focus mode",
        "         ESC   - Menu",
        "",
        "[SYSTEM] Clear preview-mode message after 8 sec"
      ]
    }
  }

  ///@private
  ///@type {Struct}
  particleTemplates = {
    "particle-default": {
      "color":{
        "start":"#ffffff",
        "halfway":"#ffffff",
        "finish":"#ffffff"
      },
      "alpha":{
        "start":1.0,
        "halfway":0.0,
        "finish":0.0
      },
      "speed":{
        "wiggle":0.0,
        "increase":0.001,
        "minValue":0.01,
        "maxValue":5.0
      },
      "shape":"CIRCLE",
      "gravity":{
        "angle":0.0,
        "amount":0.0
      },
      "orientation":{
        "wiggle":0.0,
        "relative":0.0,
        "increase":0.001,
        "minValue":0.0,
        "maxValue":360.0
      },
      "angle":{
        "wiggle":0.0,
        "increase":0.01,
        "minValue":0.0,
        "maxValue":360.0
      },
      "life":{
        "minValue":80.0,
        "maxValue":120.0
      },
      "sprite":{
        "name":"texture_particle",
        "stretch":0.0,
        "randomValue":0.0,
        "animate":0.0
      },
      "scale":{
        "x":1.0,
        "y":1.0
      },
      "blend":0.0,
      "size":{
        "wiggle":0.0,
        "increase":0.0,
        "minValue":1.0,
        "maxValue":32.0
      }
    },
    "particle-player-bomb":{
      "shape":"RING",
      "alpha":{
        "halfway":1.0,
        "finish":0.0,
        "start":0.7
      },
      "blend":true,
      "scale":{
        "x":1.0,
        "y":1.0
      },
      "speed":{
        "increase":0.0,
        "minValue":0.0,
        "maxValue":0.0,
        "wiggle":0.0
      },
      "gravity":{
        "amount":0.0,
        "angle":0.0
      },
      "orientation":{
        "increase":5.0,
        "minValue":0.0,
        "maxValue":360.0,
        "wiggle":1.0,
        "relative":0.0
      },
      "life":{
        "minValue":45.0,
        "maxValue":60.0
      },
      "color":{
        "halfway":"#FFB400",
        "finish":"#FF0000",
        "start":"#AC6800"
      },
      "angle":{
        "increase":-3.0,
        "minValue":0.0,
        "maxValue":360.0,
        "wiggle":2.0
      },
      "size":{
        "increase":2.0,
        "minValue":0.0,
        "maxValue":0.0,
        "wiggle":0.0
      }
    },
    "particle-player-bomb-start":{
      "shape":"RING",
      "alpha":{
        "halfway":0.80000000000000004,
        "finish":0.0,
        "start":1.00000000000000001
      },
      "blend":true,
      "scale":{
        "x":1.0,
        "y":1.0
      },
      "speed":{
        "increase":0.0,
        "minValue":0.0,
        "maxValue":0.0,
        "wiggle":0.0
      },
      "gravity":{
        "amount":0.0,
        "angle":0.0
      },
      "orientation":{
        "increase":5.0,
        "minValue":0.0,
        "maxValue":360.0,
        "wiggle":1.0,
        "relative":0.0
      },
      "life":{
        "minValue":90.0,
        "maxValue":90.0
      },
      "color":{
        "halfway":"#A4C7FF",
        "finish":"#556EFF",
        "start":"#81B2CD"
      },
      "angle":{
        "increase":-3.0,
        "minValue":0.0,
        "maxValue":360.0,
        "wiggle":2.0
      },
      "size":{
        "increase":-1.5,
        "minValue":100.0,
        "maxValue":120.0,
        "wiggle":0.0
      }
    },
    "particle-player-death":{
      "shape":"RING",
      "alpha":{
        "halfway":0.5,
        "finish":0.0,
        "start":1.00000000000000004
      },
      "blend":true,
      "scale":{
        "x":1.0,
        "y":1.0
      },
      "speed":{
        "increase":0.0,
        "minValue":0.0,
        "maxValue":0.0,
        "wiggle":0.0
      },
      "gravity":{
        "amount":0.0,
        "angle":0.0
      },
      "orientation":{
        "increase":5.0,
        "minValue":0.0,
        "maxValue":360.0,
        "wiggle":1.0,
        "relative":0.0
      },
      "life":{
        "minValue":120.0,
        "maxValue":180.0
      },
      "color":{
        "halfway":"#FF0000",
        "finish":"#D38D00",
        "start":"#FF0046"
      },
      "angle":{
        "increase":-3.0,
        "minValue":0.0,
        "maxValue":360.0,
        "wiggle":2.0
      },
      "size":{
        "increase":-1.0,
        "minValue":80.0,
        "maxValue":100.0,
        "wiggle":0.0
      }
    },
    "particle-player-respawn":{
      "shape":"RING",
      "alpha":{
        "halfway":0.80000000000000004,
        "finish":0.0,
        "start":1.09999999999999999
      },
      "blend":true,
      "scale":{
        "x":1.0,
        "y":1.0
      },
      "speed":{
        "increase":0.0,
        "minValue":0.0,
        "maxValue":0.0,
        "wiggle":0.0
      },
      "gravity":{
        "amount":0.0,
        "angle":0.0
      },
      "orientation":{
        "increase":5.0,
        "minValue":0.0,
        "maxValue":360.0,
        "wiggle":1.0,
        "relative":0.0
      },
      "life":{
        "minValue":80.0,
        "maxValue":160.0
      },
      "color":{
        "halfway":"#FFFF00",
        "finish":"#FFFFFF",
        "start":"#8FFF00"
      },
      "angle":{
        "increase":-3.0,
        "minValue":0.0,
        "maxValue":360.0,
        "wiggle":2.0
      },
      "size":{
        "increase":0.33000000000000002,
        "minValue":0.0,
        "maxValue":0.20000000000000001,
        "wiggle":0.0
      }
    },
    "particle-shroom-death":{
      "shape":"RING",
      "alpha":{
        "halfway":1.0,
        "finish":0.0,
        "start":1.0
      },
      "blend":true,
      "speed":{
        "increase":0.0,
        "minValue":0.0,
        "wiggle":0.0,
        "maxValue":0.0
      },
      "gravity":{
        "angle":0.0,
        "amount":0.0
      },
      "angle":{
        "increase":-3.0,
        "minValue":0.0,
        "wiggle":2.0,
        "maxValue":360.0
      },
      "color":{
        "halfway":"#0049FF",
        "finish":"#74C7FF",
        "start":"#8FCFFF"
      },
      "size":{
        "increase":0.5,
        "minValue":0.0,
        "wiggle":0.0,
        "maxValue":0.20000000000000001
      },
      "life":{
        "minValue":50.0,
        "maxValue":70.0
      },
      "scale":{
        "x":1.0,
        "y":1.0
      },
      "orientation":{
        "increase":5.0,
        "minValue":0.0,
        "wiggle":1.0,
        "relative":0.0,
        "maxValue":360.0
      }
    },
    "particle-shroom-damage":{
      "shape":"RING",
      "alpha":{
        "halfway":1.0,
        "finish":0.0,
        "start":1.0
      },
      "blend":true,
      "speed":{
        "increase":0.0,
        "minValue":0.0,
        "wiggle":0.0,
        "maxValue":0.0
      },
      "gravity":{
        "angle":0.0,
        "amount":0.0
      },
      "angle":{
        "increase":-3.0,
        "minValue":0.0,
        "wiggle":2.0,
        "maxValue":360.0
      },
      "color":{
        "halfway":"#FF0061",
        "finish":"#4961FF",
        "start":"#FFCF00"
      },
      "size":{
        "increase":1.0,
        "minValue":0.0,
        "wiggle":0.0,
        "maxValue":2.0
      },
      "life":{
        "minValue":30.0,
        "maxValue":45.0
      },
      "scale":{
        "x":1.0,
        "y":1.0
      },
      "orientation":{
        "increase":5.0,
        "minValue":0.0,
        "wiggle":1.0,
        "relative":0.0,
        "maxValue":360.0
      }
    },
  }

  ///@private
  ///@type {Struct}
  textures = {
    "texture_baron": {
      "asset": texture_baron,
      "file": ""
    },
    "texture_baron_cursor": {
      "asset": texture_baron_cursor,
      "file": ""
    },
    "texture_baron_wallpaper_1": {
      "asset": texture_baron_wallpaper_1,
      "file": ""
    },
    "texture_baron_wallpaper_2": {
      "asset": texture_baron_wallpaper_2,
      "file": ""
    },
    "texture_bazyl": {
      "asset": texture_bazyl,
      "file": ""
    },
    "texture_bazyl_cursor": {
      "asset": texture_bazyl_cursor,
      "file": ""
    },
    "texture_bullet": {
      "asset": texture_bullet,
      "file": ""
    },
    "texture_bullet_circle": {
      "asset": texture_bullet_circle,
      "file": ""
    },
    "texture_coin_bomb": {
      "asset": texture_coin_bomb,
      "file": ""
    },
    "texture_coin_force": {
      "asset": texture_coin_force,
      "file": ""
    },
    "texture_coin_life": {
      "asset": texture_coin_life,
      "file": ""
    },
    "texture_coin_point": {
      "asset": texture_coin_point,
      "file": ""
    },
    "texture_empty": {
      "asset": texture_empty,
      "file": ""
    },
    "texture_missing": {
      "asset": texture_missing,
      "file": ""
    },
    "texture_particle": {
      "asset": texture_particle,
      "file": ""
    },
    "texture_player": {
      "asset": texture_player,
      "file": ""
    },
    "texture_white": {
      "asset": texture_white,
      "file": ""
    },
    "texture_hechan_3": {
      "asset": texture_hechan_3,
      "file": "",
    },
    "texture_hechan_3_background": {
      "asset": texture_hechan_3_background,
      "file": "",
    },
    "texture_hechan_3_abstract": {
      "asset": texture_hechan_3_abstract,
      "file": "",
    },
    "texture_bullet_blue": {
      "asset": texture_bullet_blue,
      "file": "",
    },
    "texture_bullet_circle_blue": {
      "asset": texture_bullet_circle_blue,
      "file": "",
    },
    "texture_shroom_baron": {
      "asset": texture_shroom_baron,
      "file": "",
    },
    "texture_shroom_baron_blue": {
      "asset": texture_shroom_baron_blue,
      "file": "",
    },
    "texture_shroom_baron_green": {
      "asset": texture_shroom_baron_green,
      "file": "",
    },
    "texture_shroom_baron_magenta": {
      "asset": texture_shroom_baron_magenta,
      "file": "",
    },
    "texture_shroom_baron_red": {
      "asset": texture_shroom_baron_red,
      "file": "",
    },
    "texture_shroom_baron_yellow": {
      "asset": texture_shroom_baron_yellow,
      "file": "",
    },
    "texture_shroom_bazyl": {
      "asset": texture_shroom_bazyl,
      "file": "",
    },
    "texture_shroom_bazyl_blue": {
      "asset": texture_shroom_bazyl_blue,
      "file": "",
    },
    "texture_shroom_bazyl_green": {
      "asset": texture_shroom_bazyl_green,
      "file": "",
    },
    "texture_shroom_bazyl_magenta": {
      "asset": texture_shroom_bazyl_magenta,
      "file": "",
    },
    "texture_shroom_bazyl_red": {
      "asset": texture_shroom_bazyl_red,
      "file": "",
    },
    "texture_shroom_bazyl_yellow": {
      "asset": texture_shroom_bazyl_yellow,
      "file": "",
    },
    "texture_bkg_spaace_1": {
      "asset": texture_bkg_spaace_1,
      "file": "",
    },
    "texture_bkg_spaace_2": {
      "asset": texture_bkg_spaace_2,
      "file": "",
    },
    "texture_abstract_1": {
      "asset": texture_abstract_1,
      "file": "",
    },
    "texture_abstract_2": {
      "asset": texture_abstract_2,
      "file": "",
    },
  } 

  static modules = function() {
    if (this._modules == null) {
      var editor = Callable.run("VisuEditorModule")
      this._modules = {
        editor: Core.isType(editor, Struct) ? editor : {
          controller: "VisuEditorController",
          io: "VisuEditorIO",
        },
      }
    }
    
    return this._modules
  }

  ///@return {Struct}
  static assets = function() {
    if (this._assets == null) {
      this._assets = {
        shaderTemplates: Struct
          .toMap(this.shaderTemplates, String, ShaderTemplate, 
            function(json, name) {
              return new ShaderTemplate(name, json)
            }),
        shroomTemplates: Struct
          .toMap(this.shroomTemplates, String, ShroomTemplate, 
            function(json, name) {
              return new ShroomTemplate(name, json)
            }),
        bulletTemplates: Struct
          .toMap(this.bulletTemplates, String, BulletTemplate, 
            function(json, name) {
              return new BulletTemplate(name, json)
            }),
        coinTemplates: Struct
          .toMap(this.coinTemplates, String, CoinTemplate, 
            function(json, name) {
              return new CoinTemplate(name, json)
            }),
        subtitleTemplates: Struct
          .toMap(this.subtitleTemplates, String, SubtitleTemplate, 
            function(json, name) {
              return new SubtitleTemplate(name, json)
            }),
        particleTemplates: Struct
          .toMap(this.particleTemplates, String, ParticleTemplate, 
            function(json, name) {
              return new ParticleTemplate(name, json)
            }),
        textures: Struct
          .toMap(this.textures, String, TextureTemplate, 
            function(json, name) {
              return new TextureTemplate(name, json)
            }),
      }
    }

    return this._assets
  }

  ///@return {String}
  static version = function() {
    if (this._version == null) {
      var year = string_replace(string_format(date_get_year(GM_build_date) mod 100, 2, 0), " ", "0")
      var month = string_replace(string_format(date_get_month(GM_build_date), 2, 0), " ", "0")
      var day = string_replace(string_format(date_get_day(GM_build_date), 2, 0), " ", "0")
      this._version = $"{year}.{month}.{day}"
    }

    return this._version
  }

  ///@return {?String}
  static serverVersion = function() {
    return this._serverVersion
  }

  ///@return {CLIParamParser}
  static cliParser = function() {
    if (this._cliParser == null) {
      this._cliParser = new CLIParamParser({
        cliParams: new Array(CLIParam, [
          new CLIParam({
            name: "-t",
            fullName: "--test",
            description: "Run tests from test suite",
            args: [
              {
                name: "file",
                type: "String",
                description: "Path to test suite JSON"
              }
            ],
            handler: function(args) {
              Logger.debug("CLIParamParser", $"Run --test {args.get(0)}")
              Beans.get(BeanTestRunner).push(args.get(0))
              Core.setProperty("visu.manifest.load-on-start", false)
              Core.setProperty("visu.menu.open-on-start", false)
            },
          }),
          new CLIParam({
            name: "-l",
            fullName: "--load",
            description: "Load track from file",
            args: [
              {
                name: "file",
                type: "String",
                descritpion: "Path to manifest.visu"
              }
            ],
            handler: function(args) {
              Logger.debug("CLIParamParser", $"Run --load {args.get(0)}")
              Beans.get(BeanVisuController).send(new Event("load", {
                manifest: FileUtil.get(args.get(0)),
                autoplay: false,
              }))
            }
          })
        ])
      })
    }
    
    return this._cliParser
  }
  
  ///@param {String} name
  ///@return {Struct}
  static generateSettingsSubscriber = function(name) {
    return { 
      name: name,
      overrideSubscriber: true,
      callback: function(value) {
        if (Visu.settings.getValue(this.name) == value) {
          return
        }
        Visu.settings.setValue(this.name, value).save()
      },
    }
  }

  ///@param {Struct} data
  ///@param {String} useKey
  ///@param {String} valueKey
  ///@param {String} containerKey
  ///@param {Struct} container
  static resolveBooleanTrackEvent = function(data, useKey, valueKey, containerKey, container) {
    if (!Struct.get(data, useKey)) {
      return
    }

    Struct.set(container, containerKey, Struct.get(data, valueKey))
  }

  ///@param {Struct} data
  ///@param {String} useKey
  ///@param {String} sourceKey
  ///@param {String} targetKey
  ///@param {String} equationKey 
  ///@param {BlendConfig} blendConfig
  ///@param {?String} [equationAlphaKey] 
  static resolveBlendConfigTrackEvent = function(data, useKey, sourceKey, targetKey, equationKey, blendConfig, equationAlphaKey = null) {
    if (!Struct.get(data, useKey)) {
      return
    }

    blendConfig
      .setSource(BlendModeExt.get(Struct.get(data, sourceKey)))
      .setTarget(BlendModeExt.get(Struct.get(data, targetKey)))
      .setEquation(BlendEquation.get(Struct.get(data, equationKey)))

    if (Optional.is(equationAlphaKey)) {
      blendConfig.setEquationAlpha(BlendEquation.get(Struct.get(data, equationAlphaKey)))
    }
  }

  ///@param {Struct} data
  ///@param {String} useKey
  ///@param {String} eventName
  ///@param {any} eventData
  ///@param {EventPump} pump
  static resolveSendEventTrackEvent = function(data, useKey, eventName, eventData, pump) {
    if (!Struct.get(data, useKey)) {
      return
    }

    pump.send(new Event(eventName, eventData))
  }

  ///@param {Struct} data
  ///@param {String} useKey
  ///@param {String} eventName
  ///@param {any} eventData
  ///@param {EventPump} pump
  static resolveExecuteEventTrackEvent = function(data, useKey, eventName, eventData, pump) {
    if (!Struct.get(data, useKey)) {
      return
    }

    pump.execute(new Event(eventName, eventData))
  }

  ///@param {Struct} data
  ///@param {String} useKey
  ///@param {String} transformerKey
  ///@param {String} changeKey
  ///@param {String} containerKey
  ///@param {Struct} container
  ///@param {EventPump} pump
  ///@param {TaskExecutor} executor
  static resolveNumberTransformerTrackEvent = function(data, useKey, transformerKey, changeKey, containerKey, container, pump, executor) {
    var override = Struct.get(data, useKey)
    var change = Struct.get(data, changeKey)
    var transformer = Struct.get(data, transformerKey)
    if (override) {
      Struct.set(container, containerKey, transformer.value)
    }

    if (change) {
      pump.send(new Event("transform-property", {
        key: containerKey,
        container: container,
        executor: executor,
        transformer: new NumberTransformer({
          value: override ? transformer.value : Struct.get(container, containerKey),
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
          ease: transformer.easeType,
          duration: transformer.duration,
        })
      }))
    }
  }

  ///@param {Struct} data
  ///@param {String} useKey
  ///@param {String} colorKey
  ///@param {String} speedKey
  ///@param {String} containerKey
  ///@param {Struct} container
  ///@param {EventPump} pump
  ///@param {TaskExecutor} executor
  static resolveColorTransformerTrackEvent = function(data, useKey, colorKey, speedKey, containerKey, container, pump, executor) {
    if (!Struct.get(data, useKey)) {
      return
    }

    var duration = Struct.get(data, speedKey) 
    pump.send(new Event("transform-property", {
      key: containerKey,
      container: container,
      executor: executor,
      transformer: new ColorTransformer({
        value: Struct.get(container, containerKey).toHex(false),
        target: Struct.get(data, colorKey).toHex(false),
        duration: duration,
      })
    }))
  }

  ///@param {Struct} data
  ///@param {String} useKey
  ///@param {String} valueKey
  ///@param {String} containerKey
  ///@param {Struct} container
  static resolvePropertyTrackEvent = function(data, useKey, valueKey, containerKey, container) {
    if (!Struct.get(data, useKey)) {
      return
    }

    Struct.set(container, containerKey, Struct.get(data, valueKey))
  }

  ///@return {Visu}
  static initShaders = function() {
    ShaderArcRunner.install(SHADERS, SHADER_CONFIGS)
    ShaderFunkFlux.install(SHADERS, SHADER_CONFIGS)
    ShaderWarpPulse.install(SHADERS, SHADER_CONFIGS)
    ShaderWavyMesh.install(SHADERS, SHADER_CONFIGS)
    ShaderWavySpectrum.install(SHADERS, SHADER_CONFIGS)
    return this
  }
  
  ///@param {String} [layerName]
  ///@param {Number} [layerDefaultDepth]
  ///@return {Visu}
  static run = function(layerName = "layer_main", layerDefaultDepth = 100) {
    randomize()
    initBeans()
    initGPU()
    initGMTF()
    this.initShaders()
    
    Core.loadProperties(FileUtil.get($"{working_directory}core-properties.json"))
    Core.loadProperties(FileUtil.get($"{working_directory}visu-properties.json"))

    MAGIC_NUMBER_TASK = Core.getProperty("visu.const.MAGIC_NUMBER_TASK", MAGIC_NUMBER_TASK)
    SYNC_UI_STORE_STEP = Core.getProperty("visu.const.SYNC_UI_STORE_STEP", SYNC_UI_STORE_STEP)
    BRUSH_ENTRY_STEP = Core.getProperty("visu.const.BRUSH_ENTRY_STEP", BRUSH_ENTRY_STEP)
    BRUSH_TOOLBAR_ENTRY_STEP = Core.getProperty("visu.const.BRUSH_TOOLBAR_ENTRY_STEP", BRUSH_TOOLBAR_ENTRY_STEP)
    FLIP_VALUE = Core.getProperty("visu.const.FLIP_VALUE", FLIP_VALUE)

    var layerId = Scene.fetchLayer(layerName, layerDefaultDepth)

    if (!Beans.exists(BeanFileService)) {
      Beans.add(Beans.factory(BeanFileService, GMServiceInstance, layerId,
        new FileService({
          dispatcher: {
            limit: Core.getProperty("visu.files-service.dispatcher.limit", 1),
          }
        })))
    }

    this.settings.set(new SettingEntry({ name: "visu.editor.autosave", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.language", type: SettingTypes.STRING, defaultValue: LanguageType.en_EN }))
      .set(new SettingEntry({ name: "visu.fullscreen", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.server.enable", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.debug", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.debug.render-entities-mask", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.debug.render-debug-chunks", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.debug.render-surfaces", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.god-mode", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.optimalization.sort-entities-by-txgroup", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.optimalization.iterate-entities-once", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.window.width", type: SettingTypes.NUMBER, defaultValue: 1400 }))
      .set(new SettingEntry({ name: "visu.window.height", type: SettingTypes.NUMBER, defaultValue: 900 }))
      .set(new SettingEntry({ name: "visu.interface.scale", type: SettingTypes.NUMBER, defaultValue: 1 }))
      .set(new SettingEntry({ name: "visu.interface.render-hud", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.interface.hud-position", type: SettingTypes.STRING, defaultValue: "bottom-left" }))
      .set(new SettingEntry({ name: "visu.interface.player-hint", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.graphics.auto-resize", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.graphics.resolution", type: SettingTypes.STRING, defaultValue: "1440x900" }))
      .set(new SettingEntry({ name: "visu.graphics.main-shaders", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.graphics.bkg-shaders", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.graphics.combined-shaders", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.graphics.shaders-limit", type: SettingTypes.NUMBER, defaultValue: 10 }))
      .set(new SettingEntry({ name: "visu.graphics.bkt-glitch", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.graphics.particle", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.graphics.shader-quality", type: SettingTypes.NUMBER, defaultValue: 0.5 }))
      .set(new SettingEntry({ name: "visu.graphics.vsync", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.graphics.aa", type: SettingTypes.NUMBER, defaultValue: 0 }))
      .set(new SettingEntry({ name: "visu.audio.ost-volume", type: SettingTypes.NUMBER, defaultValue: 1.0 }))
      .set(new SettingEntry({ name: "visu.audio.sfx-volume", type: SettingTypes.NUMBER, defaultValue: 0.5 }))
      .set(new SettingEntry({ name: "visu.editor.enable", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.editor.bpm", type: SettingTypes.NUMBER, defaultValue: 120 }))
      .set(new SettingEntry({ name: "visu.editor.bpm-count", type: SettingTypes.NUMBER, defaultValue: 0 }))
      .set(new SettingEntry({ name: "visu.editor.bpm-sub", type: SettingTypes.NUMBER, defaultValue: 2 }))
      .set(new SettingEntry({ name: "visu.editor.snap", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.editor.render-event", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.editor.render-timeline", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.editor.render-track-control", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.editor.render-scene-config-preview", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.editor.render-brush", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.editor.accordion.render-event-inspector", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.editor.accordion.render-template-toolbar", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.editor.timeline-zoom", type: SettingTypes.NUMBER, defaultValue: 10 }))
      .set(new SettingEntry({ name: "visu.editor.timeline-follow", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.keyboard.player.up", type: SettingTypes.NUMBER, defaultValue: KeyboardKeyType.ARROW_UP }))
      .set(new SettingEntry({ name: "visu.keyboard.player.down", type: SettingTypes.NUMBER, defaultValue: KeyboardKeyType.ARROW_DOWN }))
      .set(new SettingEntry({ name: "visu.keyboard.player.left", type: SettingTypes.NUMBER, defaultValue: KeyboardKeyType.ARROW_LEFT }))
      .set(new SettingEntry({ name: "visu.keyboard.player.right", type: SettingTypes.NUMBER, defaultValue: KeyboardKeyType.ARROW_RIGHT }))
      .set(new SettingEntry({ name: "visu.keyboard.player.action", type: SettingTypes.NUMBER, defaultValue: ord("Z") }))
      .set(new SettingEntry({ name: "visu.keyboard.player.bomb", type: SettingTypes.NUMBER, defaultValue: ord("X") }))
      .set(new SettingEntry({ name: "visu.keyboard.player.focus", type: SettingTypes.NUMBER, defaultValue: KeyboardKeyType.SHIFT }))
      .set(new SettingEntry({ name: "visu.difficulty", type: SettingTypes.STRING, defaultValue: Difficulty.NORMAL }))
      .set(new SettingEntry({ 
          name: "visu.editor.theme",
          type: SettingTypes.STRUCT,
          defaultValue: { 
            accentLight: "#7742b8",
            accent: "#5f398e",
            accentShadow: "#462f63",
            accentDark: "#231832",
            primaryLight: "#455f82",
            primary: "#3B3B53",
            primaryShadow: "#2B2B35",
            primaryDark: "#222227",
            sideLight: "#212129",
            side: "#1B1B20",
            sideShadow: "#141418",
            sideDark: "#0D0D0F",
            button: "#3B3B53",
            buttonHover: "#3c4e66",
            text: "#D9D9D9",
            textShadow: "#878787",
            textFocus: "#ededed",
            textSelected: "#7742b8",
            accept: "#3d9e87",
            acceptShadow: "#368b77",
            deny: "#9e3d54",
            denyShadow: "#6d3c54",
            ruler: "#E64B3D",
            header: "#963271",
            stick: "#3B3B53",
            stickHover: "#878787",
            stickBackground: "#0D0D0F",
          }
        }))
      .load()

    if (!Optional.is(Core.fetchAARange().find(Lambda.equal, this.settings.getValue("visu.graphics.aa")))) {
      this.settings.setValue("visu.graphics.aa", 0).save()
    }
    display_reset(this.settings.getValue("visu.graphics.aa"), this.settings.getValue("visu.graphics.vsync"))
    
    Language.load(this.settings.getValue("visu.language", LanguageType.en_EN))

    if (!Beans.exists(BeanHTTPService)) {
      Beans.add(Beans.factory(BeanHTTPService, GMServiceInstance, layerId,
        new HTTPService({
          eventPump: {
            enableLogger: true,
          },
          executor: {
            enableLogger: true,
          }
        })))
    }

    if (!Beans.exists(BeanDeltaTimeService)) {
      Beans.add(Beans.factory(BeanDeltaTimeService, GMServiceInstance, layerId,
        new DeltaTimeService()))
    }

    if (!Beans.exists(BeanTextureService)) {
      Beans.add(Beans.factory(BeanTextureService, GMServiceInstance, layerId,
        new TextureService({
          getStaticTemplates: function() {
            return Visu.assets().textures
          },
        })))
    }

    if (!Beans.exists(BeanSoundService)) {
      Beans.add(Beans.factory(BeanSoundService, GMServiceInstance, layerId,
        new SoundService()))
    }

    if (!Beans.exists(BeanDialogueDesignerService)) {
      Beans.add(Beans.factory(BeanDialogueDesignerService, GMServiceInstance, layerId,
        new DialogueDesignerService({
          handlers: new Map(String, Callable, {
            "QUIT": function(data) {
              Beans.get(BeanDialogueDesignerService).close()
            },
            "LOAD_VISU_TRACK": function(data) {
              Beans.get(BeanVisuController).send(new Event("load", {
                manifest: FileUtil.get(data.path),
                autoplay: true,
              }))
            },
            "GAME_END": function(data) {
              game_end()
            },
          }),
        })))
    }

    if (!Beans.exists(BeanTestRunner)) {
      Beans.add(Beans.factory(BeanTestRunner, GMServiceInstance, layerId,
        new TestRunner()))
    }

    var enableEditor = this.settings.getValue("visu.editor.enable", false)
    var editorIOConstructor = Core.getConstructor("VisuEditorIO")
    if (Optional.is(editorIOConstructor)) {
      if (!Beans.exists(Visu.modules().editor.io) && enableEditor) {
        Beans.add(Beans.factory(Visu.modules().editor.io, GMServiceInstance, layerId,
          new editorIOConstructor()))
      }
    }

    var editorConstructor = Core.getConstructor("VisuEditorController")
    if (Optional.is(editorConstructor)) {
      if (!Beans.exists(Visu.modules().editor.controller) && enableEditor) {
        Beans.add(Beans.factory(Visu.modules().editor.controller, GMServiceInstance, layerId,
          new editorConstructor()))
      }
    }

    if (!Beans.exists(BeanVisuIO)) {
      Beans.add(Beans.factory(BeanVisuIO, GMServiceInstance, layerId,
        new VisuIO()))
    }

    if (!Beans.exists(BeanVisuController)) {
      Beans.add(Beans.factory(BeanVisuController, GMControllerInstance, layerId,
        new VisuController(layerName)))
    }

    this.cliParser().parse()
    return this
  }
}
global.__Visu = new _Visu()
#macro Visu global.__Visu
