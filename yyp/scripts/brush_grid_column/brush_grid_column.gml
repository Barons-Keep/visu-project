///@package io.alkapivo.visu.editor.service.brush.grid

///@param {Struct} json
///@return {Struct}
function brush_grid_column(json) {
  return {
    name: "brush_grid_column",
    store: new Map(String, Struct, {
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
      "gr-c_use-main-tx": {
        type: Boolean,
        value: Struct.get(json, "gr-c_use-main-tx"),
      },
      "gr-c_main-tx": {
        type: String,
        value: Struct.get(json, "gr-c_main-tx"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: GridTextureLine.keys(),
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
      "gr-c_use-side-tx": {
        type: Boolean,
        value: Struct.get(json, "gr-c_use-side-tx"),
      },
      "gr-c_side-tx": {
        type: String,
        value: Struct.get(json, "gr-c_side-tx"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: GridTextureLine.keys(),
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
      "gr-c_hide-main-tx": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide-main-tx"),
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
      "gr-c_hide-side-tx": {
        type: Boolean,
        value: Struct.get(json, "gr-c_hide-side-tx"),
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
    }),
    components: new Array(Struct, [
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
      VETitleComponent("gr-c_main-tx-title", {
        hidden: { key: "gr-c_hide-main" },
        label: { text: "Texture line" },
        input: {
          spriteOn: { name: "visu_texture_checkbox_switch_on" },
          spriteOff: { name: "visu_texture_checkbox_switch_off" },
          store: { key: "gr-c_use-main-tx" },
        },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-c_hide-main-tx" },
        },
      }),
      VESpinSelectComponent("gr-c_main-tx", {
        hidden: {
          keys: [
            { key: "gr-c_hide-main" },
            { key: "gr-c_hide-main-tx" }
          ]
        },
        enable: { key: "gr-c_use-main-tx" },
        store: { key: "gr-c_main-tx" },
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
      VETitleComponent("gr-c_side-tx-title", {
        hidden: { key: "gr-c_hide-side" },
        label: { text: "Texture line" },
        input: {
          spriteOn: { name: "visu_texture_checkbox_switch_on" },
          spriteOff: { name: "visu_texture_checkbox_switch_off" },
          store: { key: "gr-c_use-side-tx" },
        },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "gr-c_hide-side-tx" },
        },
      }),
      VESpinSelectComponent("gr-c_side-tx", {
        hidden: {
          keys: [
            { key: "gr-c_hide-side" },
            { key: "gr-c_hide-side-tx" }
          ]
        },
        enable: { key: "gr-c_use-side-tx" },
        store: { key: "gr-c_side-tx" },
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
    ]),
  }
}