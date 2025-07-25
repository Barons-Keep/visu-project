///@package io.alkapivo.core
show_debug_message("init Core.gml")
gml_pragma("optimise", "js_array_check", "push off")
gml_pragma("optimise", "js_error_check", "push off")
gml_pragma("optimise", "js_check_index", "push off")


#macro this self
#macro null undefined
#macro super event_inherited

#macro GAME_FPS 60
#macro FRAME_MS 1 / GAME_FPS

#macro GuiWidth display_get_gui_width
#macro GuiHeight display_get_gui_height
#macro toInt int64

#macro Prototype "Prototype"
#macro Matrix "Matrix"
#macro NonNull "NonNull"
#macro GMCamera "GMCamera"
#macro GMTileset "GMTileset"
#macro GMScene "GMScene"
#macro GMObjectType "GMObjectType"
#macro GMLayer "GMLayer"
#macro any "any"

#macro TAU 6.28318530

///@enum
function _RuntimeType(): Enum() constructor {
  WINDOWS = "Windows"
  GXGAMES = "GXGames"
  LINUX = "Linux"
  MACOSX = "macOS"
  IOS = "iOS"
  TVOS = "tvOS"
  ANDROID = "Android"
  PS4 = "PS4"
  PS5 = "PS5"
  GDK = "GDK"
  SWITCH = "Switch"
  UNKNOWN = "unknown"
}
global.__RuntimeType = new _RuntimeType()
#macro RuntimeType global.__RuntimeType


///@static
function _Core() constructor {

  ///@private
  ///@final
  ///@type {Struct}
  typeofMap = {
    "array": "GMArray",
    "bool": Boolean,
    "int32": Number,
    "int64": Number,
    "method": "Callable",
    "null": any,
    "number": Number,
    "ptr": Number,
    "ref": Number,
    "string": "String",
    "struct": "Struct",
    "undefined": any,
    "unknown": any,
  }

  ///@type {?Map<String, any>}
  properties = null

  ///@type {?Map<String, any>}
  typeParsers = null

  ///@param {any} object
  ///@param {any} type
  ///@return {Boolean}
  static isType = function(object, type) {
    gml_pragma("forceinline")
    try {
      var result = typeof(object)
      switch (type) {
        case any: return true
        case Boolean: return result == "bool" || result == "number"
        case Callable: return (result == "method" || result == "ref" || result == "number") 
          && is_callable(object)
        case Collection: return result == "struct" && (is_instanceof(object, Collection) 
          || is_instanceof(object, Array) 
          || is_instanceof(object, Map) 
          || is_instanceof(object, Stack) 
          || is_instanceof(object, Queue)
          || is_instanceof(object, DSMap)
          || is_instanceof(object, DSList))
        case GMArray: return result == "array"
        case GMMap: return result == "ref" && ds_exists(object, ds_type_map)
        case GMList: return result == "ref" && ds_exists(object, ds_type_list)
        case GMBuffer: return result == "ref" && buffer_exists(object)
        case GMCamera: return result == "number"
        case GMColor: return result == "number"
        case GMFont: return result == "ref" && font_exists(object)
        case GMKeyboardKey: return typeof(object) == "number"
        case GMLayer: return result == "ref" && object != -1
        case GMMatrix: return result == "array" && is_matrix(object)
        case GMMouseButton: return MouseButtonType.contains(object)
        case GMObject: return result == "ref" && instance_exists(object)
        case GMObjectType: return result == "ref" && object_exists(object)
        case GMShader: return result == "ref" && shader_is_compiled(object)
        case GMShaderUniform: return (result == "number" || result == "ref") && object != -1
        case GMScene: return result == "ref" && asset_get_type(object) == asset_room
        case GMSound: return (result == "number" || result == "ref") && audio_exists(object)
        case GMSurface: return result == "ref" && surface_exists(object)
        case GMVideoSurface: return result == "ref" && surface_exists(object)
        case GMTileset: return result == "ref"
        case GMTexture: return (result == "ref" || result == "number") && sprite_exists(object)
        case GMParticleSystem: return result == "ref" && part_system_exists(object)
        case GMAudioGroupID: return result == "ref"
        ///@todo bug, ref will be returned only when gamemaker is initalizing
        case NonNull: return object != null
        case Number: return result == "number" || result == "int64"
        case NetworkSocketID: return result == "number" && object >= 0
        case Prototype: return result == "ref" && is_callable(object)
        case String: return result == "string"
        case Struct: return result == "struct"
        default: 
          if (typeof(type) == "struct" && is_instanceof(type, OptionalType)) {
            return object != null ? Core.isType(object, type.type) : true
          }
          return is_instanceof(object, type)
      }
    } catch (exception) {
      Logger.error("Core.isType", $"'{type}' Fatal error: {exception.message}")
      Core.printStackTrace()
    }
    return false
  }

  ///@param {any} object
  ///@param {Enum} enumerable
  ///@param {?String} [message]
  ///@return {Boolean}
  static isEnum = function(object, enumerable) {
    gml_pragma("forceinline")
    try {
      return enumerable.contains(object)
    } catch (exception) { }
    return false
  }

  ///@param {any} object
  ///@param {Enum} enumerable
  ///@param {?String} [message]
  ///@return {Boolean}
  static isEnumKey = function(object, enumerable) {
    gml_pragma("forceinline")
    try {
      return enumerable.containsKey(object)
    } catch (exception) { }
    return false  
  }

  ///@param {any} object
  ///@return {?String}
  static getTypeName = function(object) {
    gml_pragma("forceinline")
    var type = null
    try {
      type = Core.hasConstructor(object) 
        ? instanceof(object) 
        : Struct.getDefault(this.typeofMap, typeof(object))
    } catch (exception) { }
    return type
  }

  ///@param {?Prototype} prototype
  ///@return {?String}
  static getPrototypeName = function(prototype) {
    gml_pragma("forceinline")
    return Core.isType(prototype, Prototype)
      ? script_get_name(prototype)
      : null
  }

  ///@param {?Struct|?String} object
  ///@return {?Prototype}
  static getConstructor = function(object) {
    gml_pragma("forceinline")
    var name = Core.isType(object, Struct) ? instanceof(object) : object
    if (!Core.isType(name, String)) {
      return null
    }

    var prototype = asset_get_index(name)
    return Core.isType(prototype, Prototype) ? prototype : null
  }

  ///@param {any} object
  ///@return {Boolean}
  static hasConstructor = function(object) {
    gml_pragma("forceinline")
    var type = typeof(object) != "struct" ? null : instanceof(object)
    return type != null && type != "struct"
  }

  ///@param {...any} message
  ///@return {Core}
  static print = function(/*...message*/) {
    gml_pragma("forceinline")
    var buffer = ""
    for (var index = 0; index < argument_count; index++) {
      buffer += (index == 0 ? "" : " ") + string(argument[index])
    }
    show_debug_message(buffer)
    return Core
  }

  ///@return {Core}
  static printStackTrace = function() {
    gml_pragma("forceinline")
    var stackTrace = debug_get_callstack(50)
    var size = GMArray.size(stackTrace)
    for (var index = 0; index < size; index++) {
      var line = string(stackTrace[index])
      if (line != "0") {
        line = "\tat " + line;
        show_debug_message(line)
      }
    }
    return Core
  }

  ///@param {String} [_path]
  ///@return {Core}
  static loadProperties = function(_path = $"{working_directory}core-properties.json") {
    if (!Core.isType(Core.properties, Map)) {
      Logger.debug("Core", "Create properties")
      Core.properties = new Map(String, any)
    }
    
    try {
      var path = FileUtil.get(_path)
      Logger.debug("Core", $"Start loading properties from '{path}'")

      var file = FileUtil.readFileSync(path)
      var properties = Assert.isType(JSON.parse(file.getData()), Struct)
      Struct.forEach(properties, function(property, key) {
        Logger.debug("Core", $"Load property '{key}'")
        if (Core.isType(property, GMArray)) {
          Core.properties.set(key, new Array(any, property)) 
        } else {
          Core.properties.set(key, property) 
        }
      })

    } catch (exception) {
      Logger.error("Core", $"Unable to load properties from file. {exception.message}")
    }

    return Core
  }

  ///@param {String} key
  ///@param {any} [defaultValue]
  ///@return {any}
  static getProperty = function(key, defaultValue = null) {
    gml_pragma("forceinline")
    return Core.properties.getDefault(key, defaultValue)
  }

  ///@param {String} key
  ///@param {any} value
  ///@return {Core}
  static setProperty = function(key, value) {
    gml_pragma("forceinline")
    Core.properties.set(key, value)
    return this
  }

  ///@param {Boolean} value
  ///@return {Core}
  static debugOverlay = function(value) {
    gml_pragma("forceinline")
    show_debug_overlay(value, true, 1.0, 0.75)
    return this
  }

  ///@return {RuntimeType}
  static getRuntimeType = function() {
    gml_pragma("forceinline")
    switch (os_type) {
      case os_windows: return RuntimeType.WINDOWS
      case os_gxgames: return RuntimeType.GXGAMES
      case os_linux: return RuntimeType.LINUX
      case os_macosx: return RuntimeType.MACOSX
      case os_ios: return RuntimeType.IOS
      case os_tvos: return RuntimeType.TVOS
      case os_android: return RuntimeType.ANDROID
      case os_ps4: return RuntimeType.PS4
      case os_ps5: return RuntimeType.PS5
      case os_gdk: return RuntimeType.GDK
      case os_switch: return RuntimeType.SWITCH
      case os_unknown: return RuntimeType.UNKNOWN
      default: return RuntimeType.UNKNOWN
    }
  }

  ///@param {Type} type
  ///@return {Callable}
  static fetchTypeParser = function(type) {
    ///@param {any} value
    ///@return {any}
    static passthrough = function(value) { 
      return value
    }

    if (!Core.isType(Core.typeParsers, Map)) {
      Logger.debug("Core", "Create typeParsers map")
      Core.typeParsers = new Map()
    }

    var parser = Core.typeParsers.get(type)
    return Core.isType(parser, Callable) ? parser : passthrough
  }

  ///@param {any} value
  ///@param {Type} type
  ///@param {any} [defaultValue]
  ///@return {any}
  static getIfType = function(value, type, defaultValue = null) {
    gml_pragma("forceinline")
    return Core.isType(value, type) ? value : defaultValue
  }

  ///@param {any} value
  ///@param {Type} type
  ///@param {any} [defaultValue]
  ///@return {any}
  static getIfEnum = function(value, type, defaultValue = null) {
    gml_pragma("forceinline")
    return Core.isEnum(value, type) ? value : defaultValue
  }

  ///@return {Array<Number>}
  static fetchAARange = function() {
    if (display_aa == 2) {
      return new Array(Number, [ 0, 2 ])
    } else if (display_aa == 6) {
      return new Array(Number, [ 0, 2, 4 ])
    } else if (display_aa == 12) {
      return new Array(Number, [ 0, 4, 8 ])
    } else if (display_aa == 14) {
      return new Array(Number, [ 0, 2, 4, 8 ])
    } else  {
      return new Array(Number, [ 0 ])
    }
  }
}
global.__Core = new _Core()
#macro Core global.__Core
