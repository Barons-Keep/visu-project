///@package io.alkapivo.visu.service.brush

///@enum
function _BrushType(): Enum() constructor {
  EFFECT_SHADER = "brush_effect_shader"
  EFFECT_GLITCH = "brush_effect_glitch"
  EFFECT_PARTICLE = "brush_effect_particle"
  EFFECT_CONFIG = "brush_effect_config"
  ENTITY_SHROOM = "brush_entity_shroom"
  ENTITY_BULLET = "brush_entity_bullet"
  ENTITY_COIN = "brush_entity_coin"
  ENTITY_PLAYER = "brush_entity_player"
  ENTITY_CONFIG = "brush_entity_config"
  GRID_AREA = "brush_grid_area"
  GRID_COLUMN = "brush_grid_column"
  GRID_ROW = "brush_grid_row"
  GRID_CONFIG = "brush_grid_config"
  VIEW_CAMERA = "brush_view_camera"
  VIEW_LAYER = "brush_view_layer"
  VIEW_SUBTITLE = "brush_view_subtitle"
  VIEW_CONFIG = "brush_view_config"
}
global.__BrushType = new _BrushType()
#macro BrushType global.__BrushType


///@static
///@type {Struct}
global.__BrushTypeNames = {
  "brush_effect_shader": "Effect shader",
  "brush_effect_glitch": "Effect glitch",
  "brush_effect_particle": "Effect particle",
  "brush_effect_config": "Effect config",
  "brush_entity_shroom": "Entity shroom",
  "brush_entity_bullet": "Entity bullet",
  "brush_entity_coin": "Entity coin",
  "brush_entity_player": "Entity player",
  "brush_entity_config": "Entity config",
  "brush_grid_area": "Grid area",
  "brush_grid_column": "Grid column",
  "brush_grid_row": "Grid row",
  "brush_grid_config": "Grid config",
  "brush_view_camera": "View camera",
  "brush_view_layer": "View layer",
  "brush_view_subtitle": "View subtitle",
  "brush_view_config": "View config"
}
#macro BrushTypeNames global.__BrushTypeNames


///@static
///@type {Array<String>}
global.__BRUSH_TEXTURES = [
  "texture_ve_icon_entity",
  "texture_ve_icon_entity_coin",
  "texture_ve_icon_entity_config",
  "texture_ve_icon_entity_player",
  "texture_ve_icon_entity_shroom",
  "texture_ve_icon_effect",
  "texture_ve_icon_effect_config",
  "texture_ve_icon_effect_glitch",
  "texture_ve_icon_effect_particle",
  "texture_ve_icon_effect_shader",
  "texture_ve_icon_grid",
  "texture_ve_icon_grid_area",
  "texture_ve_icon_grid_column",
  "texture_ve_icon_grid_config",
  "texture_ve_icon_grid_row",
  "texture_ve_icon_view",
  "texture_ve_icon_view_camera",
  "texture_ve_icon_view_config",
  "texture_ve_icon_view_layer",
  "texture_ve_icon_view_subtitle",
  "texture_ve_icon_event_1",
  "texture_ve_icon_event_10",
  "texture_ve_icon_event_11",
  "texture_ve_icon_event_12",
  "texture_ve_icon_event_13",
  "texture_ve_icon_event_14",
  "texture_ve_icon_event_15",
  "texture_ve_icon_event_16",
  "texture_ve_icon_event_17",
  "texture_ve_icon_event_18",
  "texture_ve_icon_event_19",
  "texture_ve_icon_event_2",
  "texture_ve_icon_event_20",
  "texture_ve_icon_event_21",
  "texture_ve_icon_event_3",
  "texture_ve_icon_event_4",
  "texture_ve_icon_event_5",
  "texture_ve_icon_event_6",
  "texture_ve_icon_event_7",
  "texture_ve_icon_event_8",
  "texture_ve_icon_event_9",
  "texture_coin_life",
  "texture_coin_bomb",
  "texture_coin_force",
  "texture_coin_point",
  "texture_missing",
  "texture_white",
  "texture_baron",
  "texture_bazyl"
]
#macro BRUSH_TEXTURES global.__BRUSH_TEXTURES


///@param {Struct} json
function VEBrushTemplate(json) constructor {
  
  ///@type {String}
  name = Assert.isType(json.name, String)
  
  ///@type {BrushType}
  type = Assert.isEnum(json.type, BrushType)
  
  ///@type {String}
  color = Core.isType(Struct.get(json, "color"), String)
    ? ColorUtil.fromHex(json.color, ColorUtil.WHITE).toHex()
    : "#ffffff"
  
  ///@type {String}
  texture = (Core.isType(Struct.get(json, "texture"), String) 
    && GMArray.contains(BRUSH_TEXTURES, json.texture)) 
      ? json.texture
      : BRUSH_TEXTURES[0]

  ///@type {Boolean}
  hidden = Struct.getIfType(json, "hidden", Boolean, false)

  ///@type {?Struct}
  properties = Core.isType(Struct.get(json, "properties"), Struct) 
    ? json.properties
    : null

  ///@return {Struct}
  static toStruct = function() {
    var struct = {
      name: this.name,
      type: this.type,
      texture: this.texture,
      color: this.color,
      hidden: this.hidden,
    }

    if (Optional.is(this.properties)) {
      Struct.set(struct, "properties", this.properties)
    }

    return struct
  }
}
