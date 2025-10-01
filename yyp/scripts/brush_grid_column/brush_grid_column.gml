///@package io.alkapivo.visu.editor.service.brush.grid

///@static
global.__event_grid_column = {
  parse: function(data) {
    return {
      "icon": Struct.parse.sprite(data, "icon"),
      "gr-c_hide": Struct.parse.boolean(data, "gr-c_hide", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
      "gr-c_hide-main": Struct.parse.boolean(data, "gr-c_hide-main", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
      "gr-c_hide-main-amount": Struct.parse.boolean(data, "gr-c_hide-main-amount", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
      "gr-c_hide-main-col": Struct.parse.boolean(data, "gr-c_hide-main-col", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
      "gr-c_hide-main-alpha": Struct.parse.boolean(data, "gr-c_hide-main-alpha", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
      "gr-c_hide-main-size": Struct.parse.boolean(data, "gr-c_hide-main-size", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
      "gr-c_hide-side": Struct.parse.boolean(data, "gr-c_hide-side", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
      "gr-c_hide-side-amount": Struct.parse.boolean(data, "gr-c_hide-side-amount", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
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
  store: function(json) {
    return new Map(String, Struct, {
      "gr-c_use-mode": {
        type: Boolean,
        value: Struct.get(json, "gr-c_use-mode"),
      },
      "gr-c_mode": {
        type: String,
        value: Struct.get(json, "gr-c_mode"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: GridMode.keys(),
      },
      "gr-c_use-amount": {
        type: Boolean,
        value: Struct.get(json, "gr-c_use-amount"),
      },
      "gr-c_amount": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-c_amount"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 999.9),
      },
      "gr-c_change-amount": {
        type: Boolean,
        value: Struct.get(json, "gr-c_change-amount"),
      },
      "gr-c_use-main-col": {
        type: Boolean,
        value: Struct.get(json, "gr-c_use-main-col"),
      },
      "gr-c_main-col": {
        type: Color,
        value: Struct.get(json, "gr-c_main-col"),
      },
      "gr-c_main-col-spd": {
        type: Number,
        value: Struct.get(json, "gr-c_main-col-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "gr-c_use-main-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-c_use-main-alpha"),
      },
      "gr-c_main-alpha": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-c_main-alpha"),
        passthrough: UIUtil.passthrough.getNormalizedNumberTransformer(),
      },
      "gr-c_change-main-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-c_change-main-alpha"),
      },
      "gr-c_use-main-size": {
        type: Boolean,
        value: Struct.get(json, "gr-c_use-main-size"),
      },
      "gr-c_main-size": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-c_main-size"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 9999.9),
      },
      "gr-c_change-main-size": {
        type: Boolean,
        value: Struct.get(json, "gr-c_change-main-size"),
      },
      "gr-c_use-side-col": {
        type: Boolean,
        value: Struct.get(json, "gr-c_use-side-col"),
      },
      "gr-c_side-col": {
        type: Color,
        value: Struct.get(json, "gr-c_side-col"),
      },
      "gr-c_side-col-spd": {
        type: Number,
        value: Struct.get(json, "gr-c_side-col-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "gr-c_use-side-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-c_use-side-alpha"),
      },
      "gr-c_side-alpha": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-c_side-alpha"),
        passthrough: UIUtil.passthrough.getNormalizedNumberTransformer(),
      },
      "gr-c_change-side-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-c_change-side-alpha"),
      },
      "gr-c_use-side-size": {
        type: Boolean,
        value: Struct.get(json, "gr-c_use-side-size"),
      },
      "gr-c_side-size": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-c_side-size"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 9999.9),
      },
      "gr-c_change-side-size": {
        type: Boolean,
        value: Struct.get(json, "gr-c_change-side-size"),
      },
      "gr-c_hide": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide"),
      },
      "gr-c_hide-main": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide-main"),
      },
      "gr-c_hide-main-amount": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide-main-amount"),
      },
      "gr-c_hide-main-col": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide-main-col"),
      },
      "gr-c_hide-main-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide-main-alpha"),
      },
      "gr-c_hide-main-size": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide-main-size"),
      },
      "gr-c_hide-side": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide-side"),
      },
      "gr-c_hide-side-amount": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide-side-amount"),
      },
      "gr-c_hide-side-col": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide-side-col"),
      },
      "gr-c_hide-side-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide-side-alpha"),
      },
      "gr-c_hide-side-size": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide-side-size"),
      },
    })
  },
  components: function(json) {
    return new Array(Struct, [
      VETitleComponent("gr-c_title", {
        label: { text: "Properties" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-c_hide" },
        },
      }),
      VETitleComponent("gr-c_use-mode", {
        hidden: { key: "gr-c_hide" },
        enable: { key: "gr-c_use-mode" },
        label: { text: "Columns render mode" },
        input: { },
        background: VETheme.color.side,
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_on" },
          spriteOff: { name: "visu_texture_checkbox_off" },
          store: { key: "gr-c_use-mode" },
        },
      }),
      VESpinSelectComponent("gr-c_mode", {
        hidden: { key: "gr-c_hide" },
        enable: { key: "gr-c_use-mode" },
        store: { key: "gr-c_mode" },
      }),
      VELineHComponent("gr-c_mode-line-h", {
        hidden: { key: "gr-c_hide" },
      }),
      VENumberTransformerComponent("gr-c_amount", {
        hidden: { key: "gr-c_hide" },
        store: {
          value: { key: "gr-c_amount" },
          use: { key: "gr-c_use-amount" },
          change: { key: "gr-c_change-amount" },
        },
        enable: {
          value: { key: "gr-c_use-amount" },
          target: { key: "gr-c_change-amount" },
        },  
        value: {
          text: "Amount",
          font: "font_inter_10_bold",
          factor: 0.1,
          stick: { factor: 0.1 },
        },
        duration: {
          factor: 0.1,
          stick: { factor: 0.1 },
        },
      }),
      VELineHComponent("gr-c_amount-line-h", {
        hidden: { key: "gr-c_hide" },
      }),
      VETitleComponent("gr-c_main-title", {
        background: VETheme.color.accentShadow,
        label: { text: "Main columns" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-c_hide-main" },
        },
      }),
      VETitleComponent("gr-c_main-size-title", {
        hidden: { key: "gr-c_hide-main" },
        label: { text: "Thickness" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-c_hide-main-size" },
        },
      }),
      VENumberTransformerComponent("gr-c_main-size", {
        hidden: {
          keys: [
            { key: "gr-c_hide-main" },
            { key: "gr-c_hide-main-size" }
          ]
        },
        store: {
          value: { key: "gr-c_main-size" },
          use: { key: "gr-c_use-main-size"  },
          change: { key: "gr-c_change-main-size"  },
        },
        enable: {
          value: { key: "gr-c_use-main-size"  },
          target: { key: "gr-c_change-main-size"  },
        },  
        value: {
          text: "Value",
          factor: 0.1,
          stick: { factor: 0.1 },
        },
        duration: {
          factor: 0.1,
          stick: { factor: 0.1 },
        },
      }),
      VELineHComponent("gr-c_main-size-line-h", {
        hidden: {
          keys: [
            { key: "gr-c_hide-main" },
            { key: "gr-c_hide-main-size" }
          ]
        },
      }),
      VETitleComponent("gr-c_main-alpha-title", {
        hidden: { key: "gr-c_hide-main" },
        label: { text: "Alpha" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-c_hide-main-alpha" },
        },
      }),
      VENumberTransformerComponent("gr-c_main-alpha", {
        hidden: {
          keys: [
            { key: "gr-c_hide-main" },
            { key: "gr-c_hide-main-alpha" }
          ]
        },
        store: {
          value: { key: "gr-c_main-alpha" },
          use: { key: "gr-c_use-main-alpha" },
          change: { key: "gr-c_change-main-alpha"  },
        },
        enable: {
          value: { key: "gr-c_use-main-alpha" },
          target: { key: "gr-c_change-main-alpha"  },
        },  
        value: {
          text: "Value",
          factor: 0.1,
          stick: { factor: 0.1 },
        },
        duration: {
          factor: 0.1,
          stick: { factor: 0.1 },
        },
      }),
      VELineHComponent("gr-c_main-alpha-line-h", {
        hidden: {
          keys: [
            { key: "gr-c_hide-main" },
            { key: "gr-c_hide-main-alpha" }
          ]
        },
      }),
      VETitleComponent("gr-c_main-col-title", {
        hidden: { key: "gr-c_hide-main" },
        label: { text: "Color" },
        input: {
          spriteOn: { name: "visu_texture_checkbox_switch_on" },
          spriteOff: { name: "visu_texture_checkbox_switch_off" },
          store: { key: "gr-c_use-main-col" },
        },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-c_hide-main-col" },
        },
      }),
      VEColorInputComponent("gr-c_main-col", {
        hidden: {
          keys: [
            { key: "gr-c_hide-main" },
            { key: "gr-c_hide-main-col" }
          ]
        },
        enable: { key: "gr-c_use-main-col" },
        store: { key: "gr-c_main-col" },
      }),
      VENumberInputComponent("gr-c_main-col-spd", {
        hidden: {
          keys: [
            { key: "gr-c_hide-main" },
            { key: "gr-c_hide-main-col" }
          ]
        },
        enable: { key: "gr-c_use-main-col" },
        store: { key: "gr-c_main-col-spd" },
        value: {
          text: "Duration",
          factor: 0.1,
          stick: { factor: 0.1 },
        },
        checkbox: { },
      }),
      VELineHComponent("gr-c_main-col-spd-line-h", {
        hidden: {
          keys: [
            { key: "gr-c_hide-main" },
            { key: "gr-c_hide-main-col" }
          ]
        },
      }),
      VETitleComponent("gr-c_side-title", {
        background: VETheme.color.accentShadow,
        label: { text: "Side columns" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-c_hide-side" },
        },
      }),
      VETitleComponent("gr-c_side-size-title", {
        hidden: { key: "gr-c_hide-side" },
        label: { text: "Thickness" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-c_hide-side-size" },
        },
      }),
      VENumberTransformerComponent("gr-c_side-size", {
        hidden: {
          keys: [
            { key: "gr-c_hide-side" },
            { key: "gr-c_hide-side-size" }
          ]
        },
        store: {
          value: { key: "gr-c_side-size" },
          use: { key: "gr-c_use-side-size" },
          change: { key: "gr-c_change-side-size"  },
        },
        enable: {
          value: { key: "gr-c_use-side-size" },
          target: { key: "gr-c_change-side-size" },
        },  
        value: {
          text: "Value",
          factor: 0.1,
          stick: { factor: 0.1 },
        },
        duration: {
          factor: 0.1,
          stick: { factor: 0.1 },
        },
      }),
      VELineHComponent("gr-c_side-size-line-h", {
        hidden: {
          keys: [
            { key: "gr-c_hide-side" },
            { key: "gr-c_hide-side-size" }
          ]
        },
      }),
      VETitleComponent("gr-c_side-alpha-title", {
        hidden: { key: "gr-c_hide-side" },
        label: { text: "Alpha" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-c_hide-side-alpha" },
        },
      }),
      VENumberTransformerComponent("gr-c_side-alpha", {
        hidden: {
          keys: [
            { key: "gr-c_hide-side" },
            { key: "gr-c_hide-side-alpha" }
          ]
        },
        store: {
          value: { key: "gr-c_side-alpha" },
          use: { key: "gr-c_use-side-alpha" },
          change: { key: "gr-c_change-side-alpha"  },
        },
        enable: {
          value: { key: "gr-c_use-side-alpha" },
          target: { key: "gr-c_change-side-alpha" },
        },  
        value: {
          text: "Value",
          factor: 0.1,
          stick: { factor: 0.1 },
        },
        duration: {
          factor: 0.1,
          stick: { factor: 0.1 },
        },
      }),
      VELineHComponent("gr-c_side-alpha-line-h", {
        hidden: {
          keys: [
            { key: "gr-c_hide-side" },
            { key: "gr-c_hide-side-alpha" }
          ]
        },
      }),
      VETitleComponent("gr-c_side-col-title", {
        hidden: { key: "gr-c_hide-side" },
        enable: { key: "gr-c_use-side-col" },
        label: { text: "Color" },
        input: {
          spriteOn: { name: "visu_texture_checkbox_switch_on" },
          spriteOff: { name: "visu_texture_checkbox_switch_off" },
          store: { key: "gr-c_use-side-col" },
        },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-c_hide-side-col" },
        },
      }),
      VEColorInputComponent("gr-c_side-col", {
        hidden: {
          keys: [
            { key: "gr-c_hide-side" },
            { key: "gr-c_hide-side-col" }
          ]
        },
        enable: { key: "gr-c_use-side-col" },
        store: { key: "gr-c_side-col" },
      }),
      VENumberInputComponent("gr-c_side-col-spd", {
        hidden: {
          keys: [
            { key: "gr-c_hide-side" },
            { key: "gr-c_hide-side-col" }
          ]
        },
        enable: { key: "gr-c_use-side-col" },
        store: { key: "gr-c_side-col-spd" },
        value: {
          text: "Duration",
          factor: 0.1,
          stick: { factor: 0.1 },
        },
        checkbox: { }
      }),
      VELineHComponent("gr-c_side-col-spd-line-h", {
        hidden: {
          keys: [
            { key: "gr-c_hide-side" },
            { key: "gr-c_hide-side-col" }
          ]
        },
      }),
    ])
  },
}
#macro event_grid_column global.__event_grid_column


///@param {Struct} json
///@return {Struct}
function brush_grid_column(json) {
  return {
    name: "brush_grid_column",
    store: event_grid_column.store(json),
    components: event_grid_column.components(json),
  }
}