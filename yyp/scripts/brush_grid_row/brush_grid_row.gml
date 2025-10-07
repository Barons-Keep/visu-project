///@package io.alkapivo.visu.editor.service.brush.grid

///@param {Struct} json
///@return {Struct}
function brush_grid_row(json) {
  return {
    name: "brush_grid_row",
    store: new Map(String, Struct, {
      "gr-r_use-mode": {
        type: Boolean,
        value: Struct.get(json, "gr-r_use-mode"),
      },
      "gr-r_mode": {
        type: String,
        value: Struct.get(json, "gr-r_mode"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: GridMode.keys(),
      },
      "gr-r_use-amount": {
        type: Boolean,
        value: Struct.get(json, "gr-r_use-amount"),
      },
      "gr-r_amount": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-r_amount"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 999.9),
      },
      "gr-r_change-amount": {
        type: Boolean,
        value: Struct.get(json, "gr-r_change-amount"),
      },
      "gr-r_hide-amount": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-amount"),
      },
      "gr-r_use-main-tx": {
        type: Boolean,
        value: Struct.get(json, "gr-r_use-main-tx"),
      },
      "gr-r_main-tx": {
        type: String,
        value: Struct.get(json, "gr-r_main-tx"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: GridTextureLine.keys(),
      },
      "gr-r_use-main-col": {
        type: Boolean,
        value: Struct.get(json, "gr-r_use-main-col"),
      },
      "gr-r_main-col": {
        type: Color,
        value: Struct.get(json, "gr-r_main-col"),
      },
      "gr-r_main-col-spd": {
        type: Number,
        value: Struct.get(json, "gr-r_main-col-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "gr-r_use-main-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-r_use-main-alpha"),
      },
      "gr-r_main-alpha": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-r_main-alpha"),
        passthrough: UIUtil.passthrough.getNormalizedNumberTransformer(),
      },
      "gr-r_change-main-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-r_change-main-alpha"),
      },
      "gr-r_use-main-size": {
        type: Boolean,
        value: Struct.get(json, "gr-r_use-main-size"),
      },
      "gr-r_main-size": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-r_main-size"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 9999.9),
      },
      "gr-r_change-main-size": {
        type: Boolean,
        value: Struct.get(json, "gr-r_change-main-size"),
      },
      "gr-r_use-side-tx": {
        type: Boolean,
        value: Struct.get(json, "gr-r_use-side-tx"),
      },
      "gr-r_side-tx": {
        type: String,
        value: Struct.get(json, "gr-r_side-tx"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: GridTextureLine.keys(),
      },
      "gr-r_use-side-col": {
        type: Boolean,
        value: Struct.get(json, "gr-r_use-side-col"),
      },
      "gr-r_side-col": {
        type: Color,
        value: Struct.get(json, "gr-r_side-col"),
      },
      "gr-r_side-col-spd": {
        type: Number,
        value: Struct.get(json, "gr-r_side-col-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "gr-r_use-side-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-r_use-side-alpha"),
      },
      "gr-r_side-alpha": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-r_side-alpha"),
        passthrough: UIUtil.passthrough.getNormalizedNumberTransformer(),
      },
      "gr-r_change-side-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-r_change-side-alpha"),
      },
      "gr-r_use-side-size": {
        type: Boolean,
        value: Struct.get(json, "gr-r_use-side-size"),
      },
      "gr-r_side-size": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-r_side-size"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 9999.9),
      },
      "gr-r_change-side-size": {
        type: Boolean,
        value: Struct.get(json, "gr-r_change-side-size"),
      },
      "gr-r_hide": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide"),
      },
      "gr-r_hide-main": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-main"),
      },
      "gr-r_hide-main-amount": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-main-amount"),
      },
      "gr-r_hide-main-tx": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-main-tx"),
      },
      "gr-r_hide-main-col": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-main-col"),
      },
      "gr-r_hide-main-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-main-alpha"),
      },
      "gr-r_hide-main-size": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-main-size"),
      },
      "gr-r_hide-side": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-side"),
      },
      "gr-r_hide-side-tx": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-side-tx"),
      },
      "gr-r_hide-side-amount": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-side-amount"),
      },
      "gr-r_hide-side-col": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-side-col"),
      },
      "gr-r_hide-side-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-side-alpha"),
      },
      "gr-r_hide-side-size": {
        type: Boolean,
        value: Struct.get(json, "gr-r_hide-side-size"),
      },
    }),
    components: new Array(Struct, [
      VETitleComponent("gr-r_title", {
        label: { text: "Properties" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-r_hide" },
        },
      }),
      VETitleComponent("gr-r_use-mode", {
        hidden: { key: "gr-r_hide" },
        enable: { key: "gr-r_use-mode" },
        label: { text: "Rows render mode" },
        input: { },
        background: VETheme.color.side,
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_on" },
          spriteOff: { name: "visu_texture_checkbox_off" },
          store: { key: "gr-r_use-mode" },
        },
      }),
      VESpinSelectComponent("gr-r_mode", {
        hidden: { key: "gr-r_hide" },
        enable: { key: "gr-r_use-mode" },
        store: { key: "gr-r_mode" },
      }),
      VELineHComponent("gr-r_mode-line-h", {
        hidden: { key: "gr-r_hide" },
      }),
      VENumberTransformerComponent("gr-r_amount", {
        hidden: { key: "gr-r_hide" },
        store: {
          value: { key: "gr-r_amount" },
          use: { key: "gr-r_use-amount" },
          change: { key: "gr-r_change-amount" },
        },
        enable: {
          value: { key: "gr-r_use-amount" },
          target: { key: "gr-r_change-amount" },
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
      VELineHComponent("gr-r_amount-line-h", {
        hidden: { key: "gr-r_hide" },
      }),
      VETitleComponent("gr-r_main-title", {
        background: VETheme.color.accentShadow,
        label: { text: "Main rows" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-r_hide-main" },
        },
      }),
      VETitleComponent("gr-r_main-tx-title", {
        hidden: { key: "gr-r_hide-main" },
        label: { text: "Texture line" },
        input: {
          spriteOn: { name: "visu_texture_checkbox_switch_on" },
          spriteOff: { name: "visu_texture_checkbox_switch_off" },
          store: { key: "gr-r_use-main-tx" },
        },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-r_hide-main-tx" },
        },
      }),
      VESpinSelectComponent("gr-r_main-tx", {
        hidden: {
          keys: [
            { key: "gr-r_hide-main" },
            { key: "gr-r_hide-main-tx" }
          ]
        },
        enable: { key: "gr-r_use-main-tx" },
        store: { key: "gr-r_main-tx" },
      }),
      VETitleComponent("gr-r_main-size-title", {
        hidden: { key: "gr-r_hide-main" },
        label: { text: "Thickness" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-r_hide-main-size" },
        },
      }),
      VENumberTransformerComponent("gr-r_main-size", {
        hidden: {
          keys: [
            { key: "gr-r_hide-main" },
            { key: "gr-r_hide-main-size" }
          ]
        },
        store: {
          value: { key: "gr-r_main-size" },
          use: { key: "gr-r_use-main-size"  },
          change: { key: "gr-r_change-main-size"  },
        },
        enable: {
          value: { key: "gr-r_use-main-size"  },
          target: { key: "gr-r_change-main-size"  },
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
      VELineHComponent("gr-r_main-size-line-h", {
        hidden: {
          keys: [
            { key: "gr-r_hide-main" },
            { key: "gr-r_hide-main-size" }
          ]
        },
      }),
      VETitleComponent("gr-r_main-alpha-title", {
        hidden: { key: "gr-r_hide-main" },
        label: { text: "Alpha" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-r_hide-main-alpha" },
        },
      }),
      VENumberTransformerComponent("gr-r_main-alpha", {
        hidden: {
          keys: [
            { key: "gr-r_hide-main" },
            { key: "gr-r_hide-main-alpha" }
          ]
        },
        store: {
          value: { key: "gr-r_main-alpha" },
          use: { key: "gr-r_use-main-alpha" },
          change: { key: "gr-r_change-main-alpha"  },
        },
        enable: {
          value: { key: "gr-r_use-main-alpha" },
          target: { key: "gr-r_change-main-alpha"  },
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
      VELineHComponent("gr-r_main-alpha-line-h", {
        hidden: {
          keys: [
            { key: "gr-r_hide-main" },
            { key: "gr-r_hide-main-alpha" }
          ]
        },
      }),
      VETitleComponent("gr-r_main-col-title", {
        hidden: { key: "gr-r_hide-main" },
        label: { text: "Color" },
        input: {
          spriteOn: { name: "visu_texture_checkbox_switch_on" },
          spriteOff: { name: "visu_texture_checkbox_switch_off" },
          store: { key: "gr-r_use-main-col" },
        },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-r_hide-main-col" },
        },
      }),
      VEColorInputComponent("gr-r_main-col", {
        hidden: {
          keys: [
            { key: "gr-r_hide-main" },
            { key: "gr-r_hide-main-col" }
          ]
        },
        enable: { key: "gr-r_use-main-col" },
        store: { key: "gr-r_main-col" },
      }),
      VENumberInputComponent("gr-r_main-col-spd", {
        hidden: {
          keys: [
            { key: "gr-r_hide-main" },
            { key: "gr-r_hide-main-col" }
          ]
        },
        enable: { key: "gr-r_use-main-col" },
        store: { key: "gr-r_main-col-spd" },
        value: {
          text: "Duration",
          factor: 0.1,
          stick: { factor: 0.1 },
        },
        checkbox: { },
      }),
      VELineHComponent("gr-r_main-col-spd-line-h", {
        hidden: {
          keys: [
            { key: "gr-r_hide-main" },
            { key: "gr-r_hide-main-col" }
          ]
        },
      }),
      VETitleComponent("gr-r_side-title", {
        background: VETheme.color.accentShadow,
        label: { text: "Side rows" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-r_hide-side" },
        },
      }),
      VETitleComponent("gr-r_side-tx-title", {
        hidden: { key: "gr-r_hide-side" },
        label: { text: "Texture line" },
        input: {
          spriteOn: { name: "visu_texture_checkbox_switch_on" },
          spriteOff: { name: "visu_texture_checkbox_switch_off" },
          store: { key: "gr-r_use-side-tx" },
        },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-r_hide-side-tx" },
        },
      }),
      VESpinSelectComponent("gr-r_side-tx", {
        hidden: {
          keys: [
            { key: "gr-r_hide-side" },
            { key: "gr-r_hide-side-tx" }
          ]
        },
        enable: { key: "gr-r_use-side-tx" },
        store: { key: "gr-r_side-tx" },
      }),
      VETitleComponent("gr-r_side-size-title", {
        hidden: { key: "gr-r_hide-side" },
        label: { text: "Thickness" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-r_hide-side-size" },
        },
      }),
      VENumberTransformerComponent("gr-r_side-size", {
        hidden: {
          keys: [
            { key: "gr-r_hide-side" },
            { key: "gr-r_hide-side-size" }
          ]
        },
        store: {
          value: { key: "gr-r_side-size" },
          use: { key: "gr-r_use-side-size" },
          change: { key: "gr-r_change-side-size"  },
        },
        enable: {
          value: { key: "gr-r_use-side-size" },
          target: { key: "gr-r_change-side-size" },
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
      VELineHComponent("gr-r_side-size-line-h", {
        hidden: {
          keys: [
            { key: "gr-r_hide-side" },
            { key: "gr-r_hide-side-size" }
          ]
        },
      }),
      VETitleComponent("gr-r_side-alpha-title", {
        hidden: { key: "gr-r_hide-side" },
        label: { text: "Alpha" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-r_hide-side-alpha" },
        },
      }),
      VENumberTransformerComponent("gr-r_side-alpha", {
        hidden: {
          keys: [
            { key: "gr-r_hide-side" },
            { key: "gr-r_hide-side-alpha" }
          ]
        },
        store: {
          value: { key: "gr-r_side-alpha" },
          use: { key: "gr-r_use-side-alpha" },
          change: { key: "gr-r_change-side-alpha"  },
        },
        enable: {
          value: { key: "gr-r_use-side-alpha" },
          target: { key: "gr-r_change-side-alpha" },
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
      VELineHComponent("gr-r_side-alpha-line-h", {
        hidden: {
          keys: [
            { key: "gr-r_hide-side" },
            { key: "gr-r_hide-side-alpha" }
          ]
        },
      }),
      VETitleComponent("gr-r_side-col-title", {
        hidden: { key: "gr-r_hide-side" },
        enable: { key: "gr-r_use-side-col" },
        label: { text: "Color" },
        input: {
          spriteOn: { name: "visu_texture_checkbox_switch_on" },
          spriteOff: { name: "visu_texture_checkbox_switch_off" },
          store: { key: "gr-r_use-side-col" },
        },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-r_hide-side-col" },
        },
      }),
      VEColorInputComponent("gr-r_side-col", {
        hidden: {
          keys: [
            { key: "gr-r_hide-side" },
            { key: "gr-r_hide-side-col" }
          ]
        },
        enable: { key: "gr-r_use-side-col" },
        store: { key: "gr-r_side-col" },
      }),
      VENumberInputComponent("gr-r_side-col-spd", {
        hidden: {
          keys: [
            { key: "gr-r_hide-side" },
            { key: "gr-r_hide-side-col" }
          ]
        },
        enable: { key: "gr-r_use-side-col" },
        store: { key: "gr-r_side-col-spd" },
        value: {
          text: "Duration",
          factor: 0.1,
          stick: { factor: 0.1 },
        },
        checkbox: { }
      }),
      VELineHComponent("gr-r_side-col-spd-line-h", {
        hidden: {
          keys: [
            { key: "gr-r_hide-side" },
            { key: "gr-r_hide-side-col" }
          ]
        },
      }),
    ]),
  }
}