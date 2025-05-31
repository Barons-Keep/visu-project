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
      {
        name: "gr-r_title",
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
            store: { key: "gr-r_hide" },
          },
        },
      },
      {
        name: "gr-r_use-mode",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Rows render mode",
            enable: { key: "gr-r_use-mode" },
            hidden: { key: "gr-r_hide" },
            backgroundColor: VETheme.color.side,
          },
          input: {
            backgroundColor: VETheme.color.side,
            hidden: { key: "gr-r_hide" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-r_use-mode" },
            hidden: { key: "gr-r_hide" },
            backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "gr-r_mode",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "",
            enable: { key: "gr-r_use-mode" },
            hidden: { key: "gr-r_hide" },
          },
          previous: { 
            enable: { key: "gr-r_use-mode" },
            store: { key: "gr-r_mode" },
            hidden: { key: "gr-r_hide" },
          },
          preview: Struct.appendRecursive({ 
            enable: { key: "gr-r_use-mode" },
            store: { key: "gr-r_mode" },
            hidden: { key: "gr-r_hide" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            enable: { key: "gr-r_use-mode" },
            store: { key: "gr-r_mode" },
            hidden: { key: "gr-r_hide" },
          },
        },
      },
      {
        name: "gr-r_mode-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "gr-r_hide" } },
        },
      },
      {
        name: "gr-r_amount",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Amount",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-r_use-amount" },
              hidden: { key: "gr-r_hide" },
            },
            field: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_use-amount" },
              hidden: { key: "gr-r_hide" },
            },
            decrease: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_use-amount" },
              hidden: { key: "gr-r_hide" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_use-amount" },
              hidden: { key: "gr-r_hide" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_use-amount" },
              hidden: { key: "gr-r_hide" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-r_use-amount" },
              hidden: { key: "gr-r_hide" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-r_change-amount" },
              hidden: { key: "gr-r_hide" },
            },
            field: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_change-amount" },
              hidden: { key: "gr-r_hide" },
            },
            decrease: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_change-amount" },
              hidden: { key: "gr-r_hide" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_change-amount" },
              hidden: { key: "gr-r_hide" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_change-amount" },
              hidden: { key: "gr-r_hide" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-r_change-amount" },
              hidden: { key: "gr-r_hide" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-r_change-amount" },
              hidden: { key: "gr-r_hide" },
            },
            field: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_change-amount" },
              hidden: { key: "gr-r_hide" },
            },
            decrease: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_change-amount" },
              hidden: { key: "gr-r_hide" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_change-amount" },            
              hidden: { key: "gr-r_hide" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-r_change-amount" },
              hidden: { key: "gr-r_hide" },
            },
            field: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_change-amount" },
              hidden: { key: "gr-r_hide" },
            },
            decrease: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_change-amount" },
              hidden: { key: "gr-r_hide" },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_change-amount" },            
              hidden: { key: "gr-r_hide" },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "gr-r_amount-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "gr-r_hide" } },
        },
      },
      {
        name: "gr-r_main-title",
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
            store: { key: "gr-r_hide-main" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-r_main-size-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Thickness",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-r_hide-main" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            hidden: { key: "gr-r_hide-main" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-r_hide-main-size" },
            hidden: { key: "gr-r_hide-main" },
          },
        },
      },
      {
        name: "gr-r_main-size",
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
              enable: { key: "gr-r_use-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_use-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_use-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
              value: -0.25,
            },
            increase: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_use-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
              value: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_use-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-r_use-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
              value: -0.25,
            },
            increase: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
              value: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
              store: { key: "gr-r_change-main-size" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
              value: -0.01,
            },
            increase: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
              value: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
              value: -0.001,
            },
            increase: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_change-main-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-size" }
                ]
              },
              value: 0.001,
            },
          },
        },
      },
      {
        name: "gr-r_main-size-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-r_hide-main" },
                { key: "gr-r_hide-main-size" }
              ]
            },
          },
        },
      },
      {
        name: "gr-r_main-alpha-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Alpha",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-r_hide-main" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            hidden: { key: "gr-r_hide-main" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-r_hide-main-alpha" },
            hidden: { key: "gr-r_hide-main" },
          },
        },
      },
      {
        name: "gr-r_main-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-r_use-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_use-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_use-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_use-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_use-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-r_use-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
              factor: 0.001,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
              factor: -0.0001,
            },
            increase: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_change-main-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-alpha" }
                ]
              },
              factor: 0.0001,
            },
          },
        },
      },
      {
        name: "gr-r_main-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-r_hide-main" },
                { key: "gr-r_hide-main-alpha" }
              ]
            },
          },
        },
      },
      {
        name: "gr-r_main-col-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Color",
            hidden: { key: "gr-r_hide-main" },
            enable: { key: "gr-r_use-main-col" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-r_use-main-col" },
            hidden: { key: "gr-r_hide-main" },
            //backgroundColor: VETheme.color.accentShadow
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-r_hide-main-col" },
            hidden: { key: "gr-r_hide-main" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-r_main-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-r_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-col" }
                ]
              },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-r_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-col" }
                ]
              },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-r_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-col" }
                ]
              },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-r_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-main" },
                  { key: "gr-r_hide-main-col" }
                ]
              },
            },
          },
        },
      },
      {
        name: "gr-r_main-col-spd",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Duration",
            enable: { key: "gr-r_use-main-col" },
            hidden: {
              keys: [
                { key: "gr-r_hide-main" },
                { key: "gr-r_hide-main-col" }
              ]
            },
          },  
          field: { 
            store: { key: "gr-r_main-col-spd" },
            enable: { key: "gr-r_use-main-col" },
            hidden: {
              keys: [
                { key: "gr-r_hide-main" },
                { key: "gr-r_hide-main-col" }
              ]
            },
          },
          decrease: {
            store: { key: "gr-r_main-col-spd" },
            enable: { key: "gr-r_use-main-col" },
            hidden: {
              keys: [
                { key: "gr-r_hide-main" },
                { key: "gr-r_hide-main-col" }
              ]
            },
            factor: -0.1,
          },
          increase: {
            store: { key: "gr-r_main-col-spd" },
            enable: { key: "gr-r_use-main-col" },
            hidden: {
              keys: [
                { key: "gr-r_hide-main" },
                { key: "gr-r_hide-main-col" }
              ]
            },
            factor: 0.1,
          },
          stick: {
            store: { key: "gr-r_main-col-spd" },
            enable: { key: "gr-r_use-main-col" },
            hidden: {
              keys: [
                { key: "gr-r_hide-main" },
                { key: "gr-r_hide-main-col" }
              ]
            },
          },
          checkbox: {
            hidden: {
              keys: [
                { key: "gr-r_hide-main" },
                { key: "gr-r_hide-main-col" }
              ]
            },
          },
        },
      },
      {
        name: "gr-r_main-col-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-r_hide-main" },
                { key: "gr-r_hide-main-col" }
              ]
            },
          },
        },
      },
      {
        name: "gr-r_side-title",
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
            store: { key: "gr-r_hide-side" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-r_side-size-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Thickness",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-r_hide-side" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            hidden: { key: "gr-r_hide-side" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-r_hide-side-size" },
            hidden: { key: "gr-r_hide-side" },
          },
        },
      },
      {
        name: "gr-r_side-size",
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
              enable: { key: "gr-r_use-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_use-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_use-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
              value: -0.25,
            },
            increase: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_use-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
              value: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_use-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-r_use-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
              value: -0.25,
            },
            increase: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
              value: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
              store: { key: "gr-r_change-side-size" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
              value: -0.01,
            },
            increase: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
              value: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
              value: -0.001,
            },
            increase: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_change-side-size" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-size" }
                ]
              },
              value: 0.001,
            },
          },
        },
      },
      {
        name: "gr-r_side-size-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-r_hide-side" },
                { key: "gr-r_hide-side-size" }
              ]
            },
          },
        },
      },
      {
        name: "gr-r_side-alpha-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Alpha",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-r_hide-side" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            hidden: { key: "gr-r_hide-side" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-r_hide-side-alpha" },
            hidden: { key: "gr-r_hide-side" },
          },
        },
      },
      {
        name: "gr-r_side-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-r_use-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_use-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_use-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_use-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_use-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-r_use-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
              factor: 0.001,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
              factor: -0.0001,
            },
            increase: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_change-side-alpha" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-alpha" }
                ]
              },
              factor: 0.0001,
            },
          },
        },
      },
      {
        name: "gr-r_side-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-r_hide-side" },
                { key: "gr-r_hide-side-alpha" }
              ]
            },
          },
        },
      },
      {
        name: "gr-r_side-col-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Color",
            hidden: { key: "gr-r_hide-side" },
            enable: { key: "gr-r_use-side-col" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-r_use-side-col" },
            hidden: { key: "gr-r_hide-side" },
            //backgroundColor: VETheme.color.accentShadow
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-r_hide-side-col" },
            hidden: { key: "gr-r_hide-side" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-r_side-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-r_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-col" }
                ]
              },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-r_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-col" }
                ]
              },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-r_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-col" }
                ]
              },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-r_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
              hidden: {
                keys: [
                  { key: "gr-r_hide-side" },
                  { key: "gr-r_hide-side-col" }
                ]
              },
            },
          },
        },
      },
      {
        name: "gr-r_side-col-spd",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Duration",
            enable: { key: "gr-r_use-side-col" },
            hidden: {
              keys: [
                { key: "gr-r_hide-side" },
                { key: "gr-r_hide-side-col" }
              ]
            },
          },  
          field: { 
            store: { key: "gr-r_side-col-spd" },
            enable: { key: "gr-r_use-side-col" },
            hidden: {
              keys: [
                { key: "gr-r_hide-side" },
                { key: "gr-r_hide-side-col" }
              ]
            },
          },
          decrease: {
            store: { key: "gr-r_side-col-spd" },
            enable: { key: "gr-r_use-side-col" },
            hidden: {
              keys: [
                { key: "gr-r_hide-side" },
                { key: "gr-r_hide-side-col" }
              ]
            },
            factor: -0.1,
          },
          increase: {
            store: { key: "gr-r_side-col-spd" },
            enable: { key: "gr-r_use-side-col" },
            hidden: {
              keys: [
                { key: "gr-r_hide-side" },
                { key: "gr-r_hide-side-col" }
              ]
            },
            factor: 0.1,
          },
          stick: {
            store: { key: "gr-r_side-col-spd" },
            enable: { key: "gr-r_use-side-col" },
            hidden: {
              keys: [
                { key: "gr-r_hide-side" },
                { key: "gr-r_hide-side-col" }
              ]
            },
          },
          checkbox: {
            hidden: {
              keys: [
                { key: "gr-r_hide-side" },
                { key: "gr-r_hide-side-col" }
              ]
            },
          },
        },
      },
      {
        name: "gr-r_side-col-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-r_hide-side" },
                { key: "gr-r_hide-side-col" }
              ]
            },
          },
        },
      },
    ]),
  }
}