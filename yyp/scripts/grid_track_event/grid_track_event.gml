///@package io.alkapivo.visu.service.track


///@enum
function _GridMode(): Enum() constructor {
  SINGLE = "SINGLE"
  DUAL = "DUAL"
  
  ///@override
  ///@return {Array<String>}
  keys = function() {
    static filterKeys = function(key) {
      return key != "_keys"
          && key != "keys"
          && key != "get"
          && key != "getKey"
          && key != "findKey"
          && key != "contains"
          && key != "containsKey"
    }

    if (this._keys == null) {
      this._keys = new Array(String, GMArray.sort(GMArray.filter(Struct.keys(this), filterKeys)))
    }

    return this._keys
  }
}
global.__GridMode = new _GridMode()
#macro GridMode global.__GridMode


///@enum
function _GridTextureLine(): Enum() constructor {
  SIMPLE = "SIMPLE"
  MAGIC_1 = "MAGIC_1"
  
  ///@override
  ///@return {Array<String>}
  keys = function() {
    static filterKeys = function(key) {
      return key != "_keys"
          && key != "keys"
          && key != "get"
          && key != "getKey"
          && key != "findKey"
          && key != "contains"
          && key != "containsKey"
    }

    if (this._keys == null) {
      this._keys = new Array(String, GMArray.sort(GMArray.filter(Struct.keys(this), filterKeys)))
    }

    return this._keys
  }
}
global.__GridTextureLine = new _GridTextureLine()
#macro GridTextureLine global.__GridTextureLine


///@static
///@type {Struct}
global.__grid_track_event = {
  brush_grid_area: {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "gr-area_hide-h": Struct.parse.boolean(data, "gr-area_hide-h", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-area_hide-h-length": Struct.parse.boolean(data, "gr-area_hide-h-length", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-area_hide-h-size": Struct.parse.boolean(data, "gr-area_hide-h-size", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-area_hide-h-alpha": Struct.parse.boolean(data, "gr-area_hide-h-alpha", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-area_hide-h-col": Struct.parse.boolean(data, "gr-area_hide-h-col", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-area_hide-v": Struct.parse.boolean(data, "gr-area_hide-v", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-area_hide-v-length": Struct.parse.boolean(data, "gr-area_hide-v-length", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-area_hide-v-size": Struct.parse.boolean(data, "gr-area_hide-v-size", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-area_hide-v-alpha": Struct.parse.boolean(data, "gr-area_hide-v-alpha", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-area_hide-v-col": Struct.parse.boolean(data, "gr-area_hide-v-col", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-area_use-h": Struct.parse.boolean(data, "gr-area_use-h"),
        "gr-area_h": Struct.parse.numberTransformer(data, "gr-area_h", {
          clampValue: { from: 0.0, to: 100.0 },
          clampTarget: { from: 0.0, to: 100.0 },
        }),
        "gr-area_change-h": Struct.parse.boolean(data, "gr-area_change-h"),
        "gr-area_use-h-col": Struct.parse.boolean(data, "gr-area_use-h-col"),
        "gr-area_h-col": Struct.parse.color(data, "gr-area_h-col"),
        "gr-area_h-col-spd": Struct.parse.number(data, "gr-area_h-col-spd", 0.0, 0.0, 999.9),
        "gr-area_use-h-alpha": Struct.parse.boolean(data, "gr-area_use-h-alpha"),
        "gr-area_h-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-area_h-alpha"),
        "gr-area_change-h-alpha": Struct.parse.boolean(data, "gr-area_change-h-alpha"),
        "gr-area_use-h-size": Struct.parse.boolean(data, "gr-area_use-h-size"),
        "gr-area_h-size": Struct.parse.numberTransformer(data, "gr-area_h-size", {
          clampValue: { from: 0.0, to: 9999.9 },
          clampTarget: { from: 0.0, to: 9999.9 },
        }),
        "gr-area_change-h-size": Struct.parse.boolean(data, "gr-area_change-h-size"),
        "gr-area_use-v": Struct.parse.boolean(data, "gr-area_use-v"),
        "gr-area_v": Struct.parse.numberTransformer(data, "gr-area_v", {
          clampValue: { from: 0.0, to: 100.0 },
          clampTarget: { from: 0.0, to: 100.0 },
        }),
        "gr-area_change-v": Struct.parse.boolean(data, "gr-area_change-v"),
        "gr-area_use-v-col": Struct.parse.boolean(data, "gr-area_use-v-col"),
        "gr-area_v-col": Struct.parse.color(data, "gr-area_v-col"),
        "gr-area_v-col-spd": Struct.parse.number(data, "gr-area_v-col-spd", 0.0, 0.0, 999.9),
        "gr-area_use-v-alpha": Struct.parse.boolean(data, "gr-area_use-v-alpha"),
        "gr-area_v-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-area_v-alpha"),
        "gr-area_change-v-alpha": Struct.parse.boolean(data, "gr-area_change-v-alpha"),
        "gr-area_use-v-size": Struct.parse.boolean(data, "gr-area_use-v-size"),
        "gr-area_v-size": Struct.parse.numberTransformer(data, "gr-area_v-size", {
          clampValue: { from: 0.0, to: 9999.9 },
          clampTarget: { from: 0.0, to: 9999.9 },
        }),
        "gr-area_change-v-size": Struct.parse.boolean(data, "gr-area_change-v-size"),
      }
    },
    run: function(data, channel) {
      var controller = Beans.get(BeanVisuController)
      if (!controller.isChannelDifficultyValid(channel)) {
        return
      }

      var gridService = controller.gridService
      var properties = gridService.properties
      var pump = gridService.dispatcher
      var executor = gridService.executor

      ///@description feature TODO grid.area.h
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-area_use-h",
        "gr-area_h",
        "gr-area_change-h",
        "borderHorizontalLength",
        properties, pump, executor)

      ///@description feature TODO grid.area.h.color
      Visu.resolveColorTransformerTrackEvent(data, 
        "gr-area_use-h-col",
        "gr-area_h-col",
        "gr-area_h-col-spd",
        "borderVerticalColor",
        properties, pump, executor)

      ///@description feature TODO grid.area.h.alpha
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-area_use-h-alpha",
        "gr-area_h-alpha",
        "gr-area_change-h-alpha",
        "borderVerticalAlpha",
        properties, pump, executor)

      ///@description feature TODO grid.area.h.size
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-area_use-h-size",
        "gr-area_h-size",
        "gr-area_change-h-size",
        "borderVerticalThickness",
        properties, pump, executor)

      ///@description feature TODO grid.area.v
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-area_use-v",
        "gr-area_v",
        "gr-area_change-v",
        "borderVerticalLength",
        properties, pump, executor)

      ///@description feature TODO grid.area.v.color
      Visu.resolveColorTransformerTrackEvent(data, 
        "gr-area_use-v-col",
        "gr-area_v-col",
        "gr-area_v-col-spd",
        "borderHorizontalColor",
        properties, pump, executor)

      ///@description feature TODO grid.area.v.alpha
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-area_use-v-alpha",
        "gr-area_v-alpha",
        "gr-area_change-v-alpha",
        "borderHorizontalAlpha",
        properties, pump, executor)

      ///@description feature TODO grid.area.v.size
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-area_use-v-size",
        "gr-area_v-size",
        "gr-area_change-v-size",
        "borderHorizontalThickness",
        properties, pump, executor)
    },
  },
  brush_grid_column: {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "gr-c_hide": Struct.parse.boolean(data, "gr-c_hide", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_hide-main": Struct.parse.boolean(data, "gr-c_hide-main", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_hide-main-amount": Struct.parse.boolean(data, "gr-c_hide-main-amount", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_hide-main-tx": Struct.parse.boolean(data, "gr-c_hide-main-tx", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_hide-main-col": Struct.parse.boolean(data, "gr-c_hide-main-col", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_hide-main-alpha": Struct.parse.boolean(data, "gr-c_hide-main-alpha", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_hide-main-size": Struct.parse.boolean(data, "gr-c_hide-main-size", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_hide-side": Struct.parse.boolean(data, "gr-c_hide-side", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_hide-side-amount": Struct.parse.boolean(data, "gr-c_hide-side-amount", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_hide-side-tx": Struct.parse.boolean(data, "gr-c_hide-side-tx", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_hide-side-col": Struct.parse.boolean(data, "gr-c_hide-side-col", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_hide-side-alpha": Struct.parse.boolean(data, "gr-c_hide-side-alpha", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_hide-side-size": Struct.parse.boolean(data, "gr-c_hide-side-size", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-c_use-mode": Struct.parse.boolean(data, "gr-c_use-mode"),
        "gr-c_mode": Struct.parse.enumerableKey(data, "gr-c_mode", GridMode, GridMode.DUAL),
        "gr-c_use-amount": Struct.parse.boolean(data, "gr-c_use-amount"),
        "gr-c_amount": Struct.parse.numberTransformer(data, "gr-c_amount", {
          clampValue: { from: 0.0, to: 999.9 },
          clampTarget: { from: 0.0, to: 999.9 },
        }),
        "gr-c_change-amount": Struct.parse.boolean(data, "gr-c_change-amount"),
        "gr-c_use-main-tx": Struct.parse.boolean(data, "gr-c_use-main-tx"),
        "gr-c_main-tx": Struct.parse.enumerableKey(data, "gr-c_main-tx", GridTextureLine, GridTextureLine.SIMPLE),
        "gr-c_use-main-col": Struct.parse.boolean(data, "gr-c_use-main-col"),
        "gr-c_main-col": Struct.parse.color(data, "gr-c_main-col"),
        "gr-c_main-col-spd": Struct.parse.number(data, "gr-c_main-col-spd", 0.0, 0.0, 999.9),
        "gr-c_use-main-alpha": Struct.parse.boolean(data, "gr-c_use-main-alpha"),
        "gr-c_main-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-c_main-alpha"),
        "gr-c_change-main-alpha": Struct.parse.boolean(data, "gr-c_change-main-alpha"),
        "gr-c_use-main-size": Struct.parse.boolean(data, "gr-c_use-main-size"),
        "gr-c_main-size": Struct.parse.numberTransformer(data, "gr-c_main-size", {
          clampValue: { from: 0.0, to: 9999.9 },
          clampTarget: { from: 0.0, to: 9999.9 },
        }),
        "gr-c_change-main-size": Struct.parse.boolean(data, "gr-c_change-main-size"),
        "gr-c_use-side-tx": Struct.parse.boolean(data, "gr-c_use-side-tx"),
        "gr-c_side-tx": Struct.parse.enumerableKey(data, "gr-c_side-tx", GridTextureLine, GridTextureLine.SIMPLE),
        "gr-c_use-side-col": Struct.parse.boolean(data, "gr-c_use-side-col"),
        "gr-c_side-col": Struct.parse.color(data, "gr-c_side-col"),
        "gr-c_side-col-spd": Struct.parse.number(data, "gr-c_side-col-spd", 0.0, 0.0, 999.9),
        "gr-c_use-side-alpha": Struct.parse.boolean(data, "gr-c_use-side-alpha"),
        "gr-c_side-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-c_side-alpha"),
        "gr-c_change-side-alpha": Struct.parse.boolean(data, "gr-c_change-side-alpha"),
        "gr-c_use-side-size": Struct.parse.boolean(data, "gr-c_use-side-size"),
        "gr-c_side-size": Struct.parse.numberTransformer(data, "gr-c_side-size", {
          clampValue: { from: 0.0, to: 9999.9 },
          clampTarget: { from: 0.0, to: 9999.9 },
        }),
        "gr-c_change-side-size": Struct.parse.boolean(data, "gr-c_change-side-size"),
      }
    },
    run: function(data, channel) {
      var controller = Beans.get(BeanVisuController)
      if (!controller.isChannelDifficultyValid(channel)) {
        return
      }

      var gridService = controller.gridService
      var properties = gridService.properties
      var pump = gridService.dispatcher
      var executor = gridService.executor

      ///@description feature TODO grid.column.mode
      Visu.resolvePropertyTrackEvent(data,
        "gr-c_use-mode",
        "gr-c_mode",
        "channelsMode",
        properties)
      
      ///@description feature TODO grid.column.amount
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-c_use-amount",
        "gr-c_amount",
        "gr-c_change-amount",
        "channels",
        properties, pump, executor)

      ///@description feature TODO grid.column.main.tx
      Visu.resolvePropertyTrackEvent(data,
        "gr-c_use-main-tx",
        "gr-c_main-tx",
        "channelsPrimaryTextureLine",
        properties)

      ///@description feature TODO grid.column.main.color
      Visu.resolveColorTransformerTrackEvent(data, 
        "gr-c_use-main-col",
        "gr-c_main-col",
        "gr-c_main-col-spd",
        "channelsPrimaryColor",
        properties, pump, executor)

      ///@description feature TODO grid.column.main.alpha
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-c_use-main-alpha",
        "gr-c_main-alpha",
        "gr-c_change-main-alpha",
        "channelsPrimaryAlpha",
        properties, pump, executor)

      ///@description feature TODO grid.column.main.size
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-c_use-main-size",
        "gr-c_main-size",
        "gr-c_change-main-size",
        "channelsPrimaryThickness",
        properties, pump, executor)

      ///@description feature TODO grid.column.side.tx
      Visu.resolvePropertyTrackEvent(data,
        "gr-c_use-side-tx",
        "gr-c_side-tx",
        "channelsSecondaryTextureLine",
        properties)

      ///@description feature TODO grid.column.side.color
      Visu.resolveColorTransformerTrackEvent(data, 
        "gr-c_use-side-col",
        "gr-c_side-col",
        "gr-c_side-col-spd",
        "channelsSecondaryColor",
        properties, pump, executor)

      ///@description feature TODO grid.column.side.alpha
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-c_use-side-alpha",
        "gr-c_side-alpha",
        "gr-c_change-side-alpha",
        "channelsSecondaryAlpha",
        properties, pump, executor)
      
      ///@description feature TODO grid.column.side.size
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-c_use-side-size",
        "gr-c_side-size",
        "gr-c_change-side-size",
        "channelsSecondaryThickness",
        properties, pump, executor)
    },
  },
  brush_grid_row: {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "gr-r_hide": Struct.parse.boolean(data, "gr-r_hide", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_hide-main": Struct.parse.boolean(data, "gr-r_hide-main", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_hide-main-amount": Struct.parse.boolean(data, "gr-r_hide-main-amount", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_hide-main-tx": Struct.parse.boolean(data, "gr-r_hide-main-tx", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_hide-main-col": Struct.parse.boolean(data, "gr-r_hide-main-col", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_hide-main-alpha": Struct.parse.boolean(data, "gr-r_hide-main-alpha", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_hide-main-size": Struct.parse.boolean(data, "gr-r_hide-main-size", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_hide-side": Struct.parse.boolean(data, "gr-r_hide-side", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_hide-side-amount": Struct.parse.boolean(data, "gr-r_hide-side-amount", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_hide-side-tx": Struct.parse.boolean(data, "gr-r_hide-side-tx", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_hide-side-col": Struct.parse.boolean(data, "gr-r_hide-side-col", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_hide-side-alpha": Struct.parse.boolean(data, "gr-r_hide-side-alpha", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_hide-side-size": Struct.parse.boolean(data, "gr-r_hide-side-size", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-r_use-mode": Struct.parse.boolean(data, "gr-r_use-mode"),
        "gr-r_mode": Struct.parse.enumerableKey(data, "gr-r_mode", GridMode, GridMode.DUAL),
        "gr-r_use-amount": Struct.parse.boolean(data, "gr-r_use-amount"),
        "gr-r_amount": Struct.parse.numberTransformer(data, "gr-r_amount", {
          clampValue: { from: 0.0, to: 999.9 },
          clampTarget: { from: 0.0, to: 999.9 },
        }),
        "gr-r_change-amount": Struct.parse.boolean(data, "gr-r_change-amount"),
        "gr-r_hide-amount": Struct.parse.boolean(data, "gr-r_hide-amount"),
        "gr-r_use-main-tx": Struct.parse.boolean(data, "gr-r_use-main-tx"),
        "gr-r_main-tx": Struct.parse.enumerableKey(data, "gr-r_main-tx", GridTextureLine, GridTextureLine.SIMPLE),
        "gr-r_use-main-col": Struct.parse.boolean(data, "gr-r_use-main-col"),
        "gr-r_main-col": Struct.parse.color(data, "gr-r_main-col"),
        "gr-r_main-col-spd": Struct.parse.number(data, "gr-r_main-col-spd", 0.0, 0.0, 999.9),
        "gr-r_use-main-alpha": Struct.parse.boolean(data, "gr-r_use-main-alpha"),
        "gr-r_main-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-r_main-alpha"),
        "gr-r_change-main-alpha": Struct.parse.boolean(data, "gr-r_change-main-alpha"),
        "gr-r_use-main-size": Struct.parse.boolean(data, "gr-r_use-main-size"),
        "gr-r_main-size": Struct.parse.numberTransformer(data, "gr-r_main-size", {
          clampValue: { from: 0.0, to: 9999.9 },
          clampTarget: { from: 0.0, to: 9999.9 },
        }),
        "gr-r_change-main-size": Struct.parse.boolean(data, "gr-r_change-main-size"),
        "gr-r_use-side-tx": Struct.parse.boolean(data, "gr-r_use-side-tx"),
        "gr-r_side-tx": Struct.parse.enumerableKey(data, "gr-r_side-tx", GridTextureLine, GridTextureLine.SIMPLE),
        "gr-r_use-side-col": Struct.parse.boolean(data, "gr-r_use-side-col"),
        "gr-r_side-col": Struct.parse.color(data, "gr-r_side-col"),
        "gr-r_side-col-spd": Struct.parse.number(data, "gr-r_side-col-spd", 0.0, 0.0, 999.9),
        "gr-r_use-side-alpha": Struct.parse.boolean(data, "gr-r_use-side-alpha"),
        "gr-r_side-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-r_side-alpha"),
        "gr-r_change-side-alpha": Struct.parse.boolean(data, "gr-r_change-side-alpha"),
        "gr-r_use-side-size": Struct.parse.boolean(data, "gr-r_use-side-size"),
        "gr-r_side-size": Struct.parse.numberTransformer(data, "gr-r_side-size", {
          clampValue: { from: 0.0, to: 9999.9 },
          clampTarget: { from: 0.0, to: 9999.9 },
        }),
        "gr-r_change-side-size": Struct.parse.boolean(data, "gr-r_change-side-size"),
      }
    },
    run: function(data, channel) {
      var controller = Beans.get(BeanVisuController)
      if (!controller.isChannelDifficultyValid(channel)) {
        return
      }

      var gridService = controller.gridService
      var properties = gridService.properties
      var pump = gridService.dispatcher
      var executor = gridService.executor

      ///@description feature TODO grid.row.mode
      Visu.resolvePropertyTrackEvent(data,
        "gr-r_use-mode",
        "gr-r_mode",
        "separatorsMode",
        properties)
      
      ///@description feature TODO grid.row.amount
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-r_use-amount",
        "gr-r_amount",
        "gr-r_change-amount",
        "separators",
        properties, pump, executor)

      ///@description feature TODO grid.row.main.tx
      Visu.resolvePropertyTrackEvent(data,
        "gr-r_use-main-tx",
        "gr-r_main-tx",
        "separatorsPrimaryTextureLine",
        properties)

      ///@description feature TODO grid.row.main.color
      Visu.resolveColorTransformerTrackEvent(data, 
        "gr-r_use-main-col",
        "gr-r_main-col",
        "gr-r_main-col-spd",
        "separatorsPrimaryColor",
        properties, pump, executor)

      ///@description feature TODO grid.row.main.alpha
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-r_use-main-alpha",
        "gr-r_main-alpha",
        "gr-r_change-main-alpha",
        "separatorsPrimaryAlpha",
        properties, pump, executor)

      ///@description feature TODO grid.row.main.size
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-r_use-main-size",
        "gr-r_main-size",
        "gr-r_change-main-size",
        "separatorsPrimaryThickness",
        properties, pump, executor)

      ///@description feature TODO grid.row.side.tx
      Visu.resolvePropertyTrackEvent(data,
        "gr-r_use-side-tx",
        "gr-r_side-tx",
        "separatorsSecondaryTextureLine",
        properties)

      ///@description feature TODO grid.row.side.color
      Visu.resolveColorTransformerTrackEvent(data, 
        "gr-r_use-side-col",
        "gr-r_side-col",
        "gr-r_side-col-spd",
        "separatorsSecondaryColor",
        properties, pump, executor)

      ///@description feature TODO grid.row.side.alpha
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-r_use-side-alpha",
        "gr-r_side-alpha",
        "gr-r_change-side-alpha",
        "separatorsSecondaryAlpha",
        properties, pump, executor)
      
      ///@description feature TODO grid.row.side.size
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-r_use-side-size",
        "gr-r_side-size",
        "gr-r_change-side-size",
        "separatorsSecondaryThickness",
        properties, pump, executor)
    },
  },
  "brush_grid_config": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "gr-cfg_hide-grid": Struct.parse.boolean(data, "gr-cfg_hide-grid", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-grid-blend": Struct.parse.boolean(data, "gr-cfg_hide-grid-blend", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-grid-spd": Struct.parse.boolean(data, "gr-cfg_hide-grid-spd", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-grid-z": Struct.parse.boolean(data, "gr-cfg_hide-grid-z", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-focus-grid": Struct.parse.boolean(data, "gr-cfg_hide-focus-grid", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-focus-col": Struct.parse.boolean(data, "gr-cfg_hide-focus-col", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-focus-grid-col": Struct.parse.boolean(data, "gr-cfg_hide-focus-grid-col", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-focus-grid-treshold": Struct.parse.boolean(data, "gr-cfg_hide-focus-grid-treshold", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-focus-grid-alpha": Struct.parse.boolean(data, "gr-cfg_hide-focus-grid-alpha", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-focus-color-alpha": Struct.parse.boolean(data, "gr-cfg_hide-focus-color-alpha", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-focus-alpha": Struct.parse.boolean(data, "gr-cfg_hide-focus-alpha", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-cls": Struct.parse.boolean(data, "gr-cfg_hide-cls", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-cls-col": Struct.parse.boolean(data, "gr-cfg_hide-cls-col", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_hide-cls-alpha": Struct.parse.boolean(data, "gr-cfg_hide-cls-alpha", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_use-render": Struct.parse.boolean(data, "gr-cfg_use-render"),
        "gr-cfg_render": Struct.parse.boolean(data, "gr-cfg_render"),
        "gr-cfg_use-spd": Struct.parse.boolean(data, "gr-cfg_use-spd"),
        "gr-cfg_spd": Struct.parse.numberTransformer(data, "gr-cfg_spd", {
          clampValue: { from: 0.0, to: 999.9 },
          clampTarget: { from: 0.0, to: 999.9 },
        }),
        "gr-cfg_change-spd": Struct.parse.boolean(data, "gr-cfg_change-spd"),
        "gr-cfg_use-z": Struct.parse.boolean(data, "gr-cfg_use-z"),
        "gr-cfg_z": Struct.parse.numberTransformer(data, "gr-cfg_z", {
          clampValue: { from: 0.0, to: 99999.9 },
          clampTarget: { from: 0.0, to: 99999.9 },
        }),
        "gr-cfg_change-z": Struct.parse.boolean(data, "gr-cfg_change-z"),
        "gr-cfg_use-cls-frame": Struct.parse.boolean(data, "gr-cfg_use-cls-frame"),
        "gr-cfg_cls-frame": Struct.parse.boolean(data, "gr-cfg_cls-frame"),
        "gr-cfg_use-cls-frame-col": Struct.parse.boolean(data, "gr-cfg_use-cls-frame-col"),
        "gr-cfg_cls-frame-col": Struct.parse.color(data, "gr-cfg_cls-frame-col"),
        "gr-cfg_cls-frame-col-spd": Struct.parse.number(data, "gr-cfg_cls-frame-col-spd", 0.0, 0.0, 999.9),
        "gr-cfg_use-cls-frame-alpha": Struct.parse.boolean(data, "gr-cfg_use-cls-frame-alpha"),
        "gr-cfg_cls-frame-alpha":  Struct.parse.normalizedNumberTransformer(data, "gr-cfg_cls-frame-alpha"),
        "gr-cfg_change-cls-frame-alpha": Struct.parse.boolean(data, "gr-cfg_change-cls-frame-alpha"),
        "gr-cfg_use-render-focus-grid": Struct.parse.boolean(data, "gr-cfg_use-render-focus-grid"),
        "gr-cfg_render-focus-grid": Struct.parse.boolean(data, "gr-cfg_render-focus-grid"),
        "gr-cfg_use-focus-grid-alpha": Struct.parse.boolean(data, "gr-cfg_use-focus-grid-alpha"),
        "gr-cfg_focus-grid-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-cfg_focus-grid-alpha"),
        "gr-cfg_change-focus-grid-alpha": Struct.parse.boolean(data, "gr-cfg_change-focus-grid-alpha"),
        "gr-cfg_use-focus-color-alpha": Struct.parse.boolean(data, "gr-cfg_use-focus-color-alpha"),
        "gr-cfg_focus-color-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-cfg_focus-color-alpha"),
        "gr-cfg_change-focus-color-alpha": Struct.parse.boolean(data, "gr-cfg_change-focus-color-alpha"),
        "gr-cfg_use-focus-alpha": Struct.parse.boolean(data, "gr-cfg_use-focus-alpha"),
        "gr-cfg_focus-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-cfg_focus-alpha"),
        "gr-cfg_change-focus-alpha": Struct.parse.boolean(data, "gr-cfg_change-focus-alpha"),
        "gr-cfg_use-focus-grid-treshold": Struct.parse.boolean(data, "gr-cfg_use-focus-grid-treshold"),
        "gr-cfg_focus-grid-treshold": Struct.parse.numberTransformer(data, "gr-cfg_focus-grid-treshold", {
          value: 32.0,
          clampValue: { from: 0.0, to: 99.9 },
          clampTarget: { from: 0.0, to: 99.9 },
        }),
        "gr-cfg_change-focus-grid-treshold": Struct.parse.boolean(data, "gr-cfg_change-focus-grid-treshold"),
        "gr-cfg_grid-use-blend": Struct.parse.boolean(data, "gr-cfg_grid-use-blend"),
        "gr-cfg_grid-blend-src": Struct.parse.enumerableKey(data, "gr-cfg_grid-blend-src", BlendModeExt, BlendModeExt.SRC_ALPHA),
        "gr-cfg_grid-blend-dest": Struct.parse.enumerableKey(data, "gr-cfg_grid-blend-dest", BlendModeExt, BlendModeExt.INV_SRC_ALPHA),
        "gr-cfg_grid-blend-eq": Struct.parse.enumerableKey(data, "gr-cfg_grid-blend-eq", BlendEquation, BlendEquation.ADD),
        "gr-cfg_grid-blend-eq-alpha": Struct.parse.enumerableKey(data, "gr-cfg_grid-blend-eq-alpha", BlendEquation, BlendEquation.ADD),
        "gr-cfg_focus-use-col": Struct.parse.boolean(data, "gr-cfg_focus-use-col"),
        "gr-cfg_focus-col": Struct.parse.color(data, "gr-cfg_focus-col", "#ffffff"),
        "gr-cfg_focus-col-spd": Struct.parse.number(data, "gr-cfg_focus-col-spd", 0.0, 0.0, 999.9),
        "gr-cfg_focus-use-grid-col": Struct.parse.boolean(data, "gr-cfg_focus-use-grid-col"),
        "gr-cfg_focus-grid-col": Struct.parse.color(data, "gr-cfg_focus-grid-col", "#ffffff"),
        "gr-cfg_focus-grid-col-spd": Struct.parse.number(data, "gr-cfg_focus-grid-col-spd", 0.0, 0.0, 999.9),

        "gr-cfg_hide-bpm": Struct.parse.boolean(data, "gr-cfg_hide-bpm", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "gr-cfg_use-bpm": Struct.parse.boolean(data, "gr-cfg_use-bpm"),
        "gr-cfg_bpm": Struct.parse.number(data, "gr-cfg_bpm"),
        "gr-cfg_use-bpm-count": Struct.parse.boolean(data, "gr-cfg_use-bpm-count"),
        "gr-cfg_bpm-count": Struct.parse.number(data, "gr-cfg_bpm-count"),
        "gr-cfg_use-bpm-sub": Struct.parse.boolean(data, "gr-cfg_use-bpm-sub"),
        "gr-cfg_bpm-sub": Struct.parse.number(data, "gr-cfg_bpm-sub"),
        "gr-cfg_use-bpm-shift": Struct.parse.boolean(data, "gr-cfg_use-bpm-shift"),
        "gr-cfg_bpm-shift": Struct.parse.number(data, "gr-cfg_bpm-shift"),
      }
    },
    run: function(data, channel) {
      var controller = Beans.get(BeanVisuController)
      if (!controller.isChannelDifficultyValid(channel)) {
        return
      }

      var gridService = controller.gridService
      var properties = gridService.properties
      var pump = gridService.dispatcher
      var executor = gridService.executor

      ///@description feature TODO grid.render
      Visu.resolveBooleanTrackEvent(data,
        "gr-cfg_use-render",
        "gr-cfg_render",
        "renderGrid",
        properties)

      ///@description feature TODO grid.speed
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-cfg_use-spd",
        "gr-cfg_spd",
        "gr-cfg_change-spd",
        "speed",
        properties, pump, executor)

      ///@description feature TODO grid.z
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-cfg_use-z",
        "gr-cfg_z",
        "gr-cfg_change-z",
        "gridZ",
        properties.depths, pump, executor)

      ///@description feature TODO grid.frame.clear
      Visu.resolveBooleanTrackEvent(data,
        "gr-cfg_use-cls-frame",
        "gr-cfg_cls-frame",
        "gridClearFrame",
        properties)

      ///@description feature TODO grid.frame.color
      Visu.resolveColorTransformerTrackEvent(data, 
        "gr-cfg_use-cls-frame-col",
        "gr-cfg_cls-frame-col",
        "gr-cfg_cls-frame-col-spd",
        "gridClearColor",
        properties, pump, executor)

      ///@description feature TODO grid.frame.alpha
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-cfg_use-cls-frame-alpha",
        "gr-cfg_cls-frame-alpha",
        "gr-cfg_change-cls-frame-alpha",
        "gridClearFrameAlpha",
        properties, pump, executor)

      ///@description feature TODO grid.blend
      Visu.resolveBlendConfigTrackEvent(data,
        "gr-cfg_grid-use-blend",
        "gr-cfg_grid-blend-src",
        "gr-cfg_grid-blend-dest",
        "gr-cfg_grid-blend-eq",
        properties.gridBlendConfig,
        "gr-cfg_grid-blend-eq-alpha")

      ///@description feature TODO focus-grid.render
      Visu.resolveBooleanTrackEvent(data,
        "gr-cfg_use-render-focus-grid",
        "gr-cfg_render-focus-grid",
        "renderSupportGrid",
        properties)

      ///@description feature TODO focus-grid.treshold
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-cfg_use-focus-grid-treshold",
        "gr-cfg_focus-grid-treshold",
        "gr-cfg_change-focus-grid-treshold",
        "supportGridTreshold",
        properties, pump, executor)

      ///@description feature TODO focus-grid.blend-color
      Visu.resolveColorTransformerTrackEvent(data, 
        "gr-cfg_focus-use-col",
        "gr-cfg_focus-col",
        "gr-cfg_focus-col-spd",
        "supportColor",
        properties, pump, executor)

      ///@description feature TODO focus.blend-color
      Visu.resolveColorTransformerTrackEvent(data, 
        "gr-cfg_focus-use-grid-col",
        "gr-cfg_focus-grid-col",
        "gr-cfg_focus-grid-col-spd",
        "supportGridColor",
        properties, pump, executor)
      
      ///@description feature TODO focus-color.alpha
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-cfg_use-focus-color-alpha",
        "gr-cfg_focus-color-alpha",
        "gr-cfg_change-focus-color-alpha",
        "supportColorAlpha",
        properties, pump, executor)

      ///@description feature TODO focus-grid.alpha
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-cfg_use-focus-grid-alpha",
        "gr-cfg_focus-grid-alpha",
        "gr-cfg_change-focus-grid-alpha",
        "supportGridAlpha",
        properties, pump, executor)

      ///@description feature TODO focus.alpha
      Visu.resolveNumberTransformerTrackEvent(data, 
        "gr-cfg_use-focus-alpha",
        "gr-cfg_focus-alpha",
        "gr-cfg_change-focus-alpha",
        "supportFocusAlpha",
        properties, pump, executor)

      var editor = Beans.get(Visu.modules().editor.controller)
      if (editor == null) {
        return
      }
      
      if (Struct.get(data, "gr-cfg_use-bpm")) {
        editor.store.get("bpm").set(Struct.get(data, "gr-cfg_bpm"))
      }

      if (Struct.get(data, "gr-cfg_use-bpm-count")) {
        editor.store.get("bpm-count").set(Struct.get(data, "gr-cfg_bpm-count"))
      }

      if (Struct.get(data, "gr-cfg_use-bpm-sub")) {
        editor.store.get("bpm-sub").set(Struct.get(data, "gr-cfg_bpm-sub"))
      }

      if (Struct.get(data, "gr-cfg_use-bpm-shift")) {
        editor.store.get("bpm-shift").set(Struct.get(data, "gr-cfg_bpm-shift"))
      }

    },
  },
}
#macro grid_track_event global.__grid_track_event
