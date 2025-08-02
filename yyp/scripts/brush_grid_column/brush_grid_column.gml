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
    }),
    components: new Array(Struct, [
      {
        name: "gr-c_title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Properties",
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-c_hide" },
          },
        },
      },
      {
        name: "gr-c_use-mode",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Columns render mode",
            enable: { key: "gr-c_use-mode" },
            hidden: { key: "gr-c_hide" },
            backgroundColor: VETheme.color.side,
          },
          input: {
            backgroundColor: VETheme.color.side,
            hidden: { key: "gr-c_hide" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-c_use-mode" },
            hidden: { key: "gr-c_hide" },
            backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "gr-c_mode",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "",
            enable: { key: "gr-c_use-mode" },
            hidden: { key: "gr-c_hide" },
          },
          previous: { 
            enable: { key: "gr-c_use-mode" },
            store: { key: "gr-c_mode" },
            hidden: { key: "gr-c_hide" },
          },
          preview: Struct.appendRecursive({ 
            enable: { key: "gr-c_use-mode" },
            store: { key: "gr-c_mode" },
            hidden: { key: "gr-c_hide" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            enable: { key: "gr-c_use-mode" },
            store: { key: "gr-c_mode" },
            hidden: { key: "gr-c_hide" },
          },
        },
      },
      {
        name: "gr-c_mode-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "gr-c_hide" } },
        },
      },
      {
        name: "gr-c_amount",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Amount",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-c_use-amount" },
              hidden: { key: "gr-c_hide" },
            },
            field: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_use-amount" },
              hidden: { key: "gr-c_hide" },
            },
            decrease: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_use-amount" },
              hidden: { key: "gr-c_hide" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_use-amount" },
              hidden: { key: "gr-c_hide" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_use-amount" },
              hidden: { key: "gr-c_hide" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-c_use-amount" },
              hidden: { key: "gr-c_hide" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-c_change-amount" },
              hidden: { key: "gr-c_hide" },
            },
            field: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
              hidden: { key: "gr-c_hide" },
            },
            decrease: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
              hidden: { key: "gr-c_hide" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
              hidden: { key: "gr-c_hide" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_change-amount" },
              hidden: { key: "gr-c_hide" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-c_change-amount" },
              hidden: { key: "gr-c_hide" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-c_change-amount" },
              hidden: { key: "gr-c_hide" },
            },
            field: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
              hidden: { key: "gr-c_hide" },
            },
            decrease: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
              hidden: { key: "gr-c_hide" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },            
              hidden: { key: "gr-c_hide" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-c_change-amount" },
              hidden: { key: "gr-c_hide" },
            },
            field: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
              hidden: { key: "gr-c_hide" },
            },
            decrease: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
              hidden: { key: "gr-c_hide" },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },            
              hidden: { key: "gr-c_hide" },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "gr-c_amount-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "gr-c_hide" } },
        },
      },
      {
        name: "gr-c_main-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Main columns",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-c_hide-main" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
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
      {
        name: "gr-c_main-size",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            margin: { top: 4 },
          },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-c_use-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_use-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_use-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
              value: -0.25,
            },
            increase: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_use-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
              value: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_use-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-c_use-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
              value: -0.25,
            },
            increase: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
              value: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
              store: { key: "gr-c_change-main-size" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
              value: -0.01,
            },
            increase: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
              value: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
              value: -0.001,
            },
            increase: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-size" }
                ]
              },
              value: 0.001,
            },
          },
        },
      },
      {
        name: "gr-c_main-size-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-c_hide-main" },
                { key: "gr-c_hide-main-size" }
              ]
            },
          },
        },
      },
      {
        name: "gr-c_main-alpha-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Alpha",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-c_hide-main" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            hidden: { key: "gr-c_hide-main" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-c_hide-main-alpha" },
            hidden: { key: "gr-c_hide-main" },
          },
        },
      },
      {
        name: "gr-c_main-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-c_use-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_use-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_use-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_use-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_use-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-c_use-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
              factor: 0.001,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
              factor: -0.0001,
            },
            increase: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-alpha" }
                ]
              },
              factor: 0.0001,
            },
          },
        },
      },
      {
        name: "gr-c_main-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-c_hide-main" },
                { key: "gr-c_hide-main-alpha" }
              ]
            },
          },
        },
      },
      {
        name: "gr-c_main-col-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Color",
            hidden: { key: "gr-c_hide-main" },
            enable: { key: "gr-c_use-main-col" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-c_use-main-col" },
            hidden: { key: "gr-c_hide-main" },
            //backgroundColor: VETheme.color.accentShadow
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-c_hide-main-col" },
            hidden: { key: "gr-c_hide-main" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-c_main-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-c_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-col" }
                ]
              },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-c_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-col" }
                ]
              },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-c_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-col" }
                ]
              },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-c_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-main" },
                  { key: "gr-c_hide-main-col" }
                ]
              },
            },
          },
        },
      },
      {
        name: "gr-c_main-col-spd",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Duration",
            enable: { key: "gr-c_use-main-col" },
            hidden: {
              keys: [
                { key: "gr-c_hide-main" },
                { key: "gr-c_hide-main-col" }
              ]
            },
          },  
          field: { 
            store: { key: "gr-c_main-col-spd" },
            enable: { key: "gr-c_use-main-col" },
            hidden: {
              keys: [
                { key: "gr-c_hide-main" },
                { key: "gr-c_hide-main-col" }
              ]
            },
          },
          decrease: {
            store: { key: "gr-c_main-col-spd" },
            enable: { key: "gr-c_use-main-col" },
            hidden: {
              keys: [
                { key: "gr-c_hide-main" },
                { key: "gr-c_hide-main-col" }
              ]
            },
            factor: -0.1,
          },
          increase: {
            store: { key: "gr-c_main-col-spd" },
            enable: { key: "gr-c_use-main-col" },
            hidden: {
              keys: [
                { key: "gr-c_hide-main" },
                { key: "gr-c_hide-main-col" }
              ]
            },
            factor: 0.1,
          },
          stick: {
            store: { key: "gr-c_main-col-spd" },
            enable: { key: "gr-c_use-main-col" },
            hidden: {
              keys: [
                { key: "gr-c_hide-main" },
                { key: "gr-c_hide-main-col" }
              ]
            },
          },
          checkbox: {
            hidden: {
              keys: [
                { key: "gr-c_hide-main" },
                { key: "gr-c_hide-main-col" }
              ]
            },
          },
        },
      },
      {
        name: "gr-c_main-col-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-c_hide-main" },
                { key: "gr-c_hide-main-col" }
              ]
            },
          },
        },
      },
      {
        name: "gr-c_side-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Side columns",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-c_hide-side" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-c_side-size-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Thickness",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-c_hide-side" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            hidden: { key: "gr-c_hide-side" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-c_hide-side-size" },
            hidden: { key: "gr-c_hide-side" },
          },
        },
      },
      {
        name: "gr-c_side-size",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            margin: { top: 4 },
          },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-c_use-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_use-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_use-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
              value: -0.25,
            },
            increase: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_use-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
              value: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_use-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-c_use-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
              value: -0.25,
            },
            increase: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
              value: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
              store: { key: "gr-c_change-side-size" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
              value: -0.01,
            },
            increase: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
              value: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
              value: -0.001,
            },
            increase: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-size" }
                ]
              },
              value: 0.001,
            },
          },
        },
      },
      {
        name: "gr-c_side-size-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-c_hide-side" },
                { key: "gr-c_hide-side-size" }
              ]
            },
          },
        },
      },
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
      {
        name: "gr-c_side-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-c_use-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_use-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_use-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_use-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_use-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-c_use-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
              factor: 0.001,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
              factor: -0.0001,
            },
            increase: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-alpha" }
                ]
              },
              factor: 0.0001,
            },
          },
        },
      },
      {
        name: "gr-c_side-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-c_hide-side" },
                { key: "gr-c_hide-side-alpha" }
              ]
            },
          },
        },
      },
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
      {
        name: "gr-c_side-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-c_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-col" }
                ]
              },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-c_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-col" }
                ]
              },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-c_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-col" }
                ]
              },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-c_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-c_hide-side" },
                  { key: "gr-c_hide-side-col" }
                ]
              },
            },
          },
        },
      },
      {
        name: "gr-c_side-col-spd",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Duration",
            enable: { key: "gr-c_use-side-col" },
            hidden: {
              keys: [
                { key: "gr-c_hide-side" },
                { key: "gr-c_hide-side-col" }
              ]
            },
          },  
          field: { 
            store: { key: "gr-c_side-col-spd" },
            enable: { key: "gr-c_use-side-col" },
            hidden: {
              keys: [
                { key: "gr-c_hide-side" },
                { key: "gr-c_hide-side-col" }
              ]
            },
          },
          decrease: {
            store: { key: "gr-c_side-col-spd" },
            enable: { key: "gr-c_use-side-col" },
            hidden: {
              keys: [
                { key: "gr-c_hide-side" },
                { key: "gr-c_hide-side-col" }
              ]
            },
            factor: -0.1,
          },
          increase: {
            store: { key: "gr-c_side-col-spd" },
            enable: { key: "gr-c_use-side-col" },
            hidden: {
              keys: [
                { key: "gr-c_hide-side" },
                { key: "gr-c_hide-side-col" }
              ]
            },
            factor: 0.1,
          },
          stick: {
            store: { key: "gr-c_side-col-spd" },
            enable: { key: "gr-c_use-side-col" },
            hidden: {
              keys: [
                { key: "gr-c_hide-side" },
                { key: "gr-c_hide-side-col" }
              ]
            },
          },
          checkbox: {
            hidden: {
              keys: [
                { key: "gr-c_hide-side" },
                { key: "gr-c_hide-side-col" }
              ]
            },
          },
        },
      },
      {
        name: "gr-c_side-col-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-c_hide-side" },
                { key: "gr-c_hide-side-col" }
              ]
            },
          },
        },
      },
    ]),
  }
}