///@package io.alkapivo.visu.editor.service.brush.grid

///@param {Struct} json
///@return {Struct}
function brush_grid_area(json) {
  return {
    name: "brush_grid_area",
    store: new Map(String, Struct, {
      "gr-area_use-h": {
        type: Boolean,
        value: Struct.get(json, "gr-area_use-h"),
      },
      "gr-area_h": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-area_h"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 10.0),
      },
      "gr-area_change-h": {
        type: Boolean,
        value: Struct.get(json, "gr-area_change-h"),
      },
      "gr-area_use-h-col": {
        type: Boolean,
        value: Struct.get(json, "gr-area_use-h-col"),
      },
      "gr-area_h-col": {
        type: Color,
        value: Struct.get(json, "gr-area_h-col"),
      },
      "gr-area_h-col-spd": {
        type: Number,
        value: Struct.get(json, "gr-area_h-col-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "gr-area_use-h-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-area_use-h-alpha"),
      },
      "gr-area_h-alpha": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-area_h-alpha"),
        passthrough: UIUtil.passthrough.getNormalizedNumberTransformer(),
      },
      "gr-area_change-h-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-area_change-h-alpha"),
      },
      "gr-area_use-h-size": {
        type: Boolean,
        value: Struct.get(json, "gr-area_use-h-size"),
      },
      "gr-area_h-size": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-area_h-size"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 9999.9),
      },
      "gr-area_change-h-size": {
        type: Boolean,
        value: Struct.get(json, "gr-area_change-h-size"),
      },
      "gr-area_use-v": {
        type: Boolean,
        value: Struct.get(json, "gr-area_use-v"),
      },
      "gr-area_v": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-area_v"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 10.0),
      },
      "gr-area_change-v": {
        type: Boolean,
        value: Struct.get(json, "gr-area_change-v"),
      },
      "gr-area_use-v-col": {
        type: Boolean,
        value: Struct.get(json, "gr-area_use-v-col"),
      },
      "gr-area_v-col": {
        type: Color,
        value: Struct.get(json, "gr-area_v-col"),
      },
      "gr-area_v-col-spd": {
        type: Number,
        value: Struct.get(json, "gr-area_v-col-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "gr-area_use-v-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-area_use-v-alpha"),
      },
      "gr-area_v-alpha": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-area_v-alpha"),
        passthrough: UIUtil.passthrough.getNormalizedNumberTransformer(),
      },
      "gr-area_change-v-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-area_change-v-alpha"),
      },
      "gr-area_use-v-size": {
        type: Boolean,
        value: Struct.get(json, "gr-area_use-v-size"),
      },
      "gr-area_v-size": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-area_v-size"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 9999.9),
      },
      "gr-area_change-v-size": {
        type: Boolean,
        value: Struct.get(json, "gr-area_change-v-size"),
      },
      "gr-area_hide-h": {
        type: Boolean,
        value: Struct.get(json, "gr-area_hide-h"),
      },
      "gr-area_hide-h-length": {
        type: Boolean,
        value: Struct.get(json, "gr-area_hide-h-length"),
      },
      "gr-area_hide-h-size": {
        type: Boolean,
        value: Struct.get(json, "gr-area_hide-h-size"),
      },
      "gr-area_hide-h-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-area_hide-h-alpha"),
      },
      "gr-area_hide-h-col": {
        type: Boolean,
        value: Struct.get(json, "gr-area_hide-h-col"),
      },
      "gr-area_hide-v": {
        type: Boolean,
        value: Struct.get(json, "gr-area_hide-v"),
      },
      "gr-area_hide-v-length": {
        type: Boolean,
        value: Struct.get(json, "gr-area_hide-v-length"),
      },
      "gr-area_hide-v-size": {
        type: Boolean,
        value: Struct.get(json, "gr-area_hide-v-size"),
      },
      "gr-area_hide-v-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-area_hide-v-alpha"),
      },
      "gr-area_hide-v-col": {
        type: Boolean,
        value: Struct.get(json, "gr-area_hide-v-col"),
      },
    }),
    components: new Array(Struct, [
      {
        name: "gr-area_h-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Horizontal border",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-area_hide-h" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-area_h-length-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Length",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-area_hide-h" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            hidden: { key: "gr-area_hide-h" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-area_hide-h-length" },
            hidden: { key: "gr-area_hide-h" },
          },
        },
      },
      {
        name: "gr-area_h-length",
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
              enable: { key: "gr-area_use-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_use-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_use-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_use-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-area_use-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-length" }
                ]
              },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "gr-area_h-length-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: { 
              keys: [
                { key: "gr-area_hide-h" }, 
                { key: "gr-area_hide-h-length" }
              ]
            },
          },
        },
      },
      {
        name: "gr-area_h-size-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Thickness",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-area_hide-h" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            hidden: { key: "gr-area_hide-h" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-area_hide-h-size" },
            hidden: { key: "gr-area_hide-h" },
          },
        },
      },
      {
        name: "gr-area_h-size",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-area_use-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
              factor: 0.25,        
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-area_use-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_change-h-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-size" }
                ]
              },
              factor: 0.001,      
            },
          },
        },
      },
      {
        name: "gr-area_h-size-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: { 
              keys: [
                { key: "gr-area_hide-h" }, 
                { key: "gr-area_hide-h-size" }
              ]
            },
          },
        },
      },
      {
        name: "gr-area_h-alpha-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Alpha",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-area_hide-h" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            hidden: { key: "gr-area_hide-h" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-area_hide-h-alpha" },
            hidden: { key: "gr-area_hide-h" },
          },
        },
      },
      {
        name: "gr-area_h-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-area_use-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_use-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_use-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_use-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-area_use-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-area_change-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" }, 
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
              factor: 0.01,     
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_change-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-area_change-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-area_change-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },      
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
              factor: 0.001,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-area_change-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
              factor: -0.0001,
            },
            increase: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-alpha" }
                ]
              },
              factor: 0.0001,
            },
          },
        },
      },
      {
        name: "gr-area_h-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: { 
              keys: [
                { key: "gr-area_hide-h" }, 
                { key: "gr-area_hide-h-alpha" }
              ]
            },
          },
        },
      },
      {
        name: "gr-area_h-col-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Color",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-area_hide-h" },
            enable: { key: "gr-area_use-h-col" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-area_use-h-col" },
            hidden: { key: "gr-area_hide-h" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-area_hide-h-col" },
            hidden: { key: "gr-area_hide-h" },
          },
        },
      },
      {
        name: "gr-area_h-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-area_use-h-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-col" }
                ]
              },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-area_use-h-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-col" }
                ]
              },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-area_use-h-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-col" }
                ]
              },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-area_use-h-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-h" }, 
                  { key: "gr-area_hide-h-col" }
                ]
              },
            },
          },
        },
      },
      {
        name: "gr-area_h-col-spd",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Duration",
            enable: { key: "gr-area_use-h-col" },
            hidden: { 
              keys: [
                { key: "gr-area_hide-h" }, 
                { key: "gr-area_hide-h-col" }
              ]
            },
          },  
          field: { 
            store: { key: "gr-area_h-col-spd" },
            enable: { key: "gr-area_use-h-col" },
            hidden: { 
              keys: [
                { key: "gr-area_hide-h" }, 
                { key: "gr-area_hide-h-col" }
              ]
            },
          },
          decrease: {
            store: { key: "gr-area_h-col-spd" },
            enable: { key: "gr-area_use-h-col" },
            hidden: { 
              keys: [
                { key: "gr-area_hide-h" }, 
                { key: "gr-area_hide-h-col" }
              ]
            },
            factor: -0.1,
          },
          increase: {
            store: { key: "gr-area_h-col-spd" },
            enable: { key: "gr-area_use-h-col" },
            hidden: { 
              keys: [
                { key: "gr-area_hide-h" }, 
                { key: "gr-area_hide-h-col" }
              ]
            },
            factor: 0.1,
          },
          stick: {
            store: { key: "gr-area_h-col-spd" },
            enable: { key: "gr-area_use-h-col" },
            hidden: { 
              keys: [
                { key: "gr-area_hide-h" }, 
                { key: "gr-area_hide-h-col" }
              ]
            },
            factor: 0.01,
          },
          checkbox: {
            hidden: { 
              keys: [
                { key: "gr-area_hide-h" }, 
                { key: "gr-area_hide-h-col" }
              ]
            },
          },
        },
      },
      {
        name: "gr-area_h-col-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: { 
              keys: [
                { key: "gr-area_hide-h" }, 
                { key: "gr-area_hide-h-col" }
              ],
            },
          },
        },
      },
      {
        name: "gr-area_v-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Vertical border",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            backgroundColor: VETheme.color.accentShadow
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-area_hide-v" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-area_v-length-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Length",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-area_hide-v" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-area_hide-v" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            hidden: { key: "gr-area_hide-v" },
            store: { key: "gr-area_hide-v-length" },
          },
        },
      },
      {
        name: "gr-area_v-length",
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
              font: "font_inter_10_bold",
              color: VETheme.color.textShadow,
              enable: { key: "gr-area_use-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_use-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_use-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_use-v" },    
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-area_use-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-length" }
                ]
              },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "gr-area_v-length-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: { 
              keys: [
                { key: "gr-area_hide-v" }, 
                { key: "gr-area_hide-v-length" }
              ]
            },
          },
        },
      },
      {
        name: "gr-area_v-size-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Thickness",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-area_hide-v" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            hidden: { key: "gr-area_hide-v" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-area_hide-v-size" },
            hidden: { key: "gr-area_hide-v" },
          },
        },
      },
      {
        name: "gr-area_v-size",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-area_use-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_use-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_use-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_use-v-size" },          
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-area_use-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-area_change-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },             
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_change-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-area_change-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-area_change-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },             
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-area_change-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-size" }
                ]
              },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "gr-area_v-size-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: { 
              keys: [
                { key: "gr-area_hide-v" }, 
                { key: "gr-area_hide-v-size" }
              ]
            },
          }
        },
      },
      {
        name: "gr-area_v-alpha-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Alpha",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-area_hide-v" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            hidden: { key: "gr-area_hide-v" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-area_hide-v-alpha" },
            hidden: { key: "gr-area_hide-v" },
          },
        },
      },
      {
        name: "gr-area_v-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-area_use-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_use-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_use-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_use-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-area_use-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-area_change-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },  
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_change-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-area_change-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-area_change-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },  
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
              factor: 0.001,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-area_change-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
            },
            decrease: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
              factor: -0.0001,
            },
            increase: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },  
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-alpha" }
                ]
              },
              factor: 0.0001,
            },
          },
        },
      },
      {
        name: "gr-area_v-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: { 
              keys: [
                { key: "gr-area_hide-v" }, 
                { key: "gr-area_hide-v-alpha" }
              ]
            },
          },
        },
      },
      {
        name: "gr-area_v-col-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Color",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "gr-area_hide-v" },
            enable: { key: "gr-area_use-v-col" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-area_use-v-col" },
            hidden: { key: "gr-area_hide-v" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-area_hide-v-col" },
            hidden: { key: "gr-area_hide-v" },
          },
        },
      },
      {
        name: "gr-area_v-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-area_use-v-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-col" }
                ]
              },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-area_use-v-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-col" }
                ]
              },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-area_use-v-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-col" }
                ]
              },
            },
            slider: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-col" }
                ]
              },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-area_use-v-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-col" }
                ]
              },
            },
            field: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
              hidden: { 
                keys: [
                  { key: "gr-area_hide-v" }, 
                  { key: "gr-area_hide-v-col" }
                ]
              },
            },
          },
        },
      },
      {
        name: "gr-area_v-col-spd",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Duration",
            enable: { key: "gr-area_use-v-col" },
            hidden: { 
              keys: [
                { key: "gr-area_hide-v" }, 
                { key: "gr-area_hide-v-col" }
              ]
            },
          },  
          field: { 
            store: { key: "gr-area_v-col-spd" },
            enable: { key: "gr-area_use-v-col" },
            hidden: { 
              keys: [
                { key: "gr-area_hide-v" }, 
                { key: "gr-area_hide-v-col" }
              ]
            },
          },
          decrease: {
            store: { key: "gr-area_v-col-spd" },
            enable: { key: "gr-area_use-v-col" },
            hidden: { 
              keys: [
                { key: "gr-area_hide-v" }, 
                { key: "gr-area_hide-v-col" }
              ]
            },
            factor: -0.1,
          },
          increase: {
            store: { key: "gr-area_v-col-spd" },
            enable: { key: "gr-area_use-v-col" },
            hidden: { 
              keys: [
                { key: "gr-area_hide-v" }, 
                { key: "gr-area_hide-v-col" }
              ]
            },
            factor: 0.1,
          },
          stick: {
            store: { key: "gr-area_v-col-spd" },
            enable: { key: "gr-area_use-v-col" },
            hidden: { 
              keys: [
                { key: "gr-area_hide-v" }, 
                { key: "gr-area_hide-v-col" }
              ]
            },
            factor: 0.01,
          },
          checkbox: {
            hidden: { 
              keys: [
                { key: "gr-area_hide-v" }, 
                { key: "gr-area_hide-v-col" }
              ]
            },
          },
        },
      },
    ]),
  }
}