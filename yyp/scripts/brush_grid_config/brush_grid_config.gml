///@package io.alkapivo.visu.editor.service.brush.grid

///@param {Struct} json
///@return {Struct}
function brush_grid_config(json) {
  return {
    name: "brush_grid_config",
    store: new Map(String, Struct, {
      "gr-cfg_use-render": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_use-render"),
      },
      "gr-cfg_render": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_render"),
      },
      "gr-cfg_use-spd": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_use-spd"),
      },
      "gr-cfg_spd": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-cfg_spd"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 999.9),
      },
      "gr-cfg_change-spd": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_change-spd"),
      },
      "gr-cfg_use-z": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_use-z"),
      },
      "gr-cfg_z": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-cfg_z"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 99999.9),
      },
      "gr-cfg_change-z": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_change-z"),
      },
      "gr-cfg_use-cls-frame": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_use-cls-frame"),
      },
      "gr-cfg_cls-frame": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_cls-frame"),
      },
      "gr-cfg_use-cls-frame-col": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_use-cls-frame-col"),
      },
      "gr-cfg_cls-frame-col": {
        type: Color,
        value: Struct.get(json, "gr-cfg_cls-frame-col"),
      },
      "gr-cfg_cls-frame-col-spd": {
        type: Number,
        value: Struct.get(json, "gr-cfg_cls-frame-col-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "gr-cfg_use-cls-frame-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_use-cls-frame-alpha"),
      },
      "gr-cfg_cls-frame-alpha": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-cfg_cls-frame-alpha"),
        passthrough: UIUtil.passthrough.getNormalizedNumberTransformer(),
      },
      "gr-cfg_change-cls-frame-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_change-cls-frame-alpha"),
      },
      "gr-cfg_use-render-focus-grid": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_use-render-focus-grid"),
      },
      "gr-cfg_render-focus-grid": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_render-focus-grid"),
      },
      "gr-cfg_use-focus-grid-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_use-focus-grid-alpha"),
      },
      "gr-cfg_focus-grid-alpha": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-cfg_focus-grid-alpha"),
        passthrough: UIUtil.passthrough.getNormalizedNumberTransformer(),
      },
      "gr-cfg_change-focus-grid-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_change-focus-grid-alpha"),
      },
      "gr-cfg_use-focus-grid-treshold": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_use-focus-grid-treshold"),
      },
      "gr-cfg_focus-grid-treshold": {
        type: NumberTransformer,
        value: Struct.get(json, "gr-cfg_focus-grid-treshold"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 32.0),
      },
      "gr-cfg_change-focus-grid-treshold": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_change-focus-grid-treshold"),
      },
      "gr-cfg_grid-use-blend": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_grid-use-blend"),
      },
      "gr-cfg_grid-blend-src": {
        type: String,
        value: Struct.get(json, "gr-cfg_grid-blend-src"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendModeExt.keys(),
      },
      "gr-cfg_grid-blend-dest": {
        type: String,
        value: Struct.get(json, "gr-cfg_grid-blend-dest"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendModeExt.keys(),
      },
      "gr-cfg_grid-blend-eq": {
        type: String,
        value: Struct.get(json, "gr-cfg_grid-blend-eq"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendEquation.keys(),
      },
      "gr-cfg_grid-blend-eq-alpha": {
        type: String,
        value: Struct.get(json, "gr-cfg_grid-blend-eq-alpha"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendEquation.keys(),
      },
      "gr-cfg_focus-grid-use-blend": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_focus-grid-use-blend"),
      },
      "gr-cfg_focus-grid-blend-src": {
        type: String,
        value: Struct.get(json, "gr-cfg_focus-grid-blend-src"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendModeExt.keys(),
      },
      "gr-cfg_focus-grid-blend-dest": {
        type: String,
        value: Struct.get(json, "gr-cfg_focus-grid-blend-dest"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendModeExt.keys(),
      },
      "gr-cfg_focus-grid-blend-eq": {
        type: String,
        value: Struct.get(json, "gr-cfg_focus-grid-blend-eq"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendEquation.keys(),
      },
      "gr-cfg_focus-grid-blend-eq-alpha": {
        type: String,
        value: Struct.get(json, "gr-cfg_focus-grid-blend-eq-alpha"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendEquation.keys(),
      },
      "gr-cfg_focus-grid-use-blend-col": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_focus-grid-use-blend-col"),
      },
      "gr-cfg_focus-grid-blend-col": {
        type: Color,
        value: Struct.get(json, "gr-cfg_focus-grid-blend-col"),
      },
      "gr-cfg_focus-grid-blend-col-spd": {
        type: Number,
        value: Struct.get(json, "gr-cfg_focus-grid-blend-col-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "gr-cfg_hide-grid": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_hide-grid"),
      },
      "gr-cfg_hide-grid-blend": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_hide-grid-blend"),
      },
      "gr-cfg_hide-grid-spd": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_hide-grid-spd"),
      },
      "gr-cfg_hide-grid-z": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_hide-grid-z"),
      },
      "gr-cfg_hide-focus-grid": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_hide-focus-grid"),
      },
      "gr-cfg_hide-focus-grid-blend": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_hide-focus-grid-blend"),
      },
      "gr-cfg_hide-focus-grid-col": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_hide-focus-grid-col"),
      },
      "gr-cfg_hide-focus-grid-treshold": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_hide-focus-grid-treshold"),
      },
      "gr-cfg_hide-focus-grid-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_hide-focus-grid-alpha"),
      },
      "gr-cfg_hide-cls": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_hide-cls"),
      },
      "gr-cfg_hide-cls-col": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_hide-cls-col"),
      },
      "gr-cfg_hide-cls-alpha": {
        type: Boolean,
        value: Struct.get(json, "gr-cfg_hide-cls-alpha"),
      },
    }),
    components: new Array(Struct, [
      {
        name: "gr-cfg_grid-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Grid",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-cfg_hide-grid" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_render",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render",
            enable: { key: "gr-cfg_use-render" },
            hidden: { key: "gr-cfg_hide-grid" },
            //backgroundColor: VETheme.color.side,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-cfg_use-render" },
            hidden: { key: "gr-cfg_hide-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-cfg_render" },
            enable: { key: "gr-cfg_use-render" },
            hidden: { key: "gr-cfg_hide-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_grid-use-blend",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Blend mode",
            //backgroundColor: VETheme.color.side,
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: { key: "gr-cfg_hide-grid" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-cfg_grid-use-blend" },
            hidden: { key: "gr-cfg_hide-grid" },
            //backgroundColor: VETheme.color.side,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-cfg_hide-grid-blend" },
            hidden: { key: "gr-cfg_hide-grid" },
            //backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "gr-cfg_grid-blend-src",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Source",
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
          previous: {
            store: { key: "gr-cfg_grid-blend-src" },
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_grid-blend-src" },
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
            preRender: function() { 
              Struct.set(this, "_text", this.label.text)
              this.label.text = String.toUpperCase(String.replaceAll(this.label.text, "_", " "))
            },
            postRender: function() { 
              this.label.text = this._text
            },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            store: { key: "gr-cfg_grid-blend-src" },
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
        },
      },
      {
        name: "gr-cfg_grid-blend-dest",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Target",
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
          previous: {
            store: { key: "gr-cfg_grid-blend-dest" },
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_grid-blend-dest" },
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
            preRender: function() { 
              Struct.set(this, "_text", this.label.text)
              this.label.text = String.toUpperCase(String.replaceAll(this.label.text, "_", " "))
            },
            postRender: function() { 
              this.label.text = this._text
            },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            store: { key: "gr-cfg_grid-blend-dest" },
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
        },
      },
      {
        name: "gr-cfg_grid-blend-eq",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Equation",
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
          previous: {
            store: { key: "gr-cfg_grid-blend-eq" },
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_grid-blend-eq" },
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
            preRender: function() { 
              Struct.set(this, "_text", this.label.text)
              this.label.text = String.toUpperCase(String.replaceAll(this.label.text, "_", " "))
            },
            postRender: function() { 
              this.label.text = this._text
            },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: {
            store: { key: "gr-cfg_grid-blend-eq" },
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
        },
      },
      {
        name: "gr-cfg_grid-blend-eq-alpha",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Eq. alpha",
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
          previous: {
            store: { key: "gr-cfg_grid-blend-eq-alpha" },
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_grid-blend-eq-alpha" },
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
            preRender: function() { 
              Struct.set(this, "_text", this.label.text)
              this.label.text = String.toUpperCase(String.replaceAll(this.label.text, "_", " "))
            },
            postRender: function() { 
              this.label.text = this._text
            },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: {
            store: { key: "gr-cfg_grid-blend-eq-alpha" },
            enable: { key: "gr-cfg_grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
        },
      },
      {
        name: "gr-cfg_blend-eq-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-blend" }
              ]
            },
          },
        },
      },
      {
        name: "gr-cfg_spd-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Speed",
            //backgroundColor: VETheme.color.side,
            hidden: { key: "gr-cfg_hide-grid" },
          },
          input: {
            //spriteOn: { name: "visu_texture_checkbox_switch_on" },
            //spriteOff: { name: "visu_texture_checkbox_switch_off" },
            hidden: { key: "gr-cfg_hide-grid" },
            //backgroundColor: VETheme.color.side,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-cfg_hide-grid-spd" },
            hidden: { key: "gr-cfg_hide-grid" },
            //backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "gr-cfg_spd",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-cfg_use-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
            },
            field: {
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_use-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
            },
            decrease: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_use-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_use-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_use-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-cfg_use-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
            },
            field: {
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
            },
            decrease: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
            },
            field: {
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
            },
            decrease: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
            },
            field: {
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
            },
            decrease: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-spd" }
                ]
              },
              factor: 1.0,
            },
          },
        },
      },
      {
        name: "gr-cfg_spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-spd" }
              ]
            },
          },
        },
      },
      {
        name: "gr-cfg_z-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Z",
            //backgroundColor: VETheme.color.side,
            hidden: { key: "gr-cfg_hide-grid" },
          },
          input: {
            //spriteOn: { name: "visu_texture_checkbox_switch_on" },
            //spriteOff: { name: "visu_texture_checkbox_switch_off" },
            hidden: { key: "gr-cfg_hide-grid" },
            //backgroundColor: VETheme.color.side,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-cfg_hide-grid-z" },
            hidden: { key: "gr-cfg_hide-grid" },
            //backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "gr-cfg_z",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-cfg_use-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
            },
            field: {
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_use-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
            },
            decrease: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_use-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_use-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
              store: { key: "gr-cfg_use-z" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-cfg_use-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
            },
            field: {
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
            },
            decrease: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
            },
            field: {
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
            },
            decrease: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
            },
            field: {
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
            },
            decrease: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-grid" },
                  { key: "gr-cfg_hide-grid-z" }
                ]
              },
              factor: 1.0,
            },
          },
        },
      },
      {
        name: "gr-cfg_z-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-cfg_hide-grid" },
                { key: "gr-cfg_hide-grid-z" }
              ]
            },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Focus grid",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-cfg_hide-focus-grid" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_render-focus-grid",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render",
            enable: { key: "gr-cfg_use-render-focus-grid" },
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-cfg_use-render-focus-grid" },
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-cfg_render-focus-grid" },
            enable: { key: "gr-cfg_use-render-focus-grid" },
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-use-blend",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Blend mode",
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.side,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.side,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-cfg_hide-focus-grid-blend" },
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-blend-src",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Source",
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
          },
          previous: {
            store: { key: "gr-cfg_focus-grid-blend-src" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_focus-grid-blend-src" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
            preRender: function() { 
              Struct.set(this, "_text", this.label.text)
              this.label.text = String.toUpperCase(String.replaceAll(this.label.text, "_", " "))
            },
            postRender: function() { 
              this.label.text = this._text
            },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            store: { key: "gr-cfg_focus-grid-blend-src" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-blend-dest",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Target",
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
          },
          previous: {
            store: { key: "gr-cfg_focus-grid-blend-dest" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_focus-grid-blend-dest" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
            preRender: function() { 
              Struct.set(this, "_text", this.label.text)
              this.label.text = String.toUpperCase(String.replaceAll(this.label.text, "_", " "))
            },
            postRender: function() { 
              this.label.text = this._text
            },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            store: { key: "gr-cfg_focus-grid-blend-dest" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-blend-eq",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Equation",
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
          },
          previous: {
            store: { key: "gr-cfg_focus-grid-blend-eq" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_focus-grid-blend-eq" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
            preRender: function() { 
              Struct.set(this, "_text", this.label.text)
              this.label.text = String.toUpperCase(String.replaceAll(this.label.text, "_", " "))
            },
            postRender: function() { 
              this.label.text = this._text
            },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: {
            store: { key: "gr-cfg_focus-grid-blend-eq" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-blend-eq-alpha",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Eq. alpha",
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
          },
          previous: {
            store: { key: "gr-cfg_focus-grid-blend-eq-alpha" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_focus-grid-blend-eq-alpha" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
            preRender: function() { 
              Struct.set(this, "_text", this.label.text)
              this.label.text = String.toUpperCase(String.replaceAll(this.label.text, "_", " "))
            },
            postRender: function() { 
              this.label.text = this._text
            },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: {
            store: { key: "gr-cfg_focus-grid-blend-eq-alpha" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-blend" }
              ],
            },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-blend-col-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Blend color",
            enable: { key: "gr-cfg_focus-grid-use-blend-col" },
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-cfg_focus-grid-use-blend-col" },
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-cfg_hide-focus-grid-col" },
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-blend-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-cfg_focus-grid-use-blend-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-col" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-blend-col" },
              enable: { key: "gr-cfg_focus-grid-use-blend-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-col" }
                ],
              },
            },
            slider: {
              store: { key: "gr-cfg_focus-grid-blend-col" },
              enable: { key: "gr-cfg_focus-grid-use-blend-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-col" }
                ],
              },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-cfg_focus-grid-use-blend-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-col" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-blend-col" },
              enable: { key: "gr-cfg_focus-grid-use-blend-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-col" }
                ],
              },
            },
            slider: {
              store: { key: "gr-cfg_focus-grid-blend-col" },
              enable: { key: "gr-cfg_focus-grid-use-blend-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-col" }
                ],
              },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-cfg_focus-grid-use-blend-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-col" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-blend-col" },
              enable: { key: "gr-cfg_focus-grid-use-blend-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-col" }
                ],
              },
            },
            slider: {
              store: { key: "gr-cfg_focus-grid-blend-col" },
              enable: { key: "gr-cfg_focus-grid-use-blend-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-col" }
                ],
              },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-cfg_focus-grid-use-blend-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-col" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-blend-col" },
              enable: { key: "gr-cfg_focus-grid-use-blend-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-col" }
                ],
              },
            },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-blend-col-spd",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Duration",
            enable: { key: "gr-cfg_focus-grid-use-blend-col" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-col" }
              ],
            },
          },  
          field: { 
            store: { key: "gr-cfg_focus-grid-blend-col-spd" },
            enable: { key: "gr-cfg_focus-grid-use-blend-col" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-col" }
              ],
            },
          },
          decrease: {
            store: { key: "gr-cfg_focus-grid-blend-col-spd" },
            enable: { key: "gr-cfg_focus-grid-use-blend-col" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-col" }
              ],
            },
            factor: -0.1,
          },
          increase: {
            store: { key: "gr-cfg_focus-grid-blend-col-spd" },
            enable: { key: "gr-cfg_focus-grid-use-blend-col" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-col" }
              ],
            },
            factor: 0.1,
          },
          stick: {
            store: { key: "gr-cfg_focus-grid-blend-col-spd" },
            enable: { key: "gr-cfg_focus-grid-use-blend-col" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-col" }
              ],
            },
            factor: 0.01,
          },
          checkbox: {
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-col" }
              ],
            },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-blend-col-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-col" }
              ],
            },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-treshold-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Treshold",
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-cfg_hide-focus-grid-treshold" },
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-treshold",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-cfg_use-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_use-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_use-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_use-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_use-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-cfg_use-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-treshold" }
                ],
              },
              factor: 1.0,
            },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-treshold-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-treshold" }
              ],
            },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-alpha-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Alpha",
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-cfg_hide-focus-grid-alpha" },
            hidden: { key: "gr-cfg_hide-focus-grid" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-cfg_use-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_use-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_use-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_use-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_use-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-cfg_use-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-focus-grid" },
                  { key: "gr-cfg_hide-focus-grid-alpha" }
                ],
              },
              factor: 1.0,
            },
          },
        },
      },
      {
        name: "gr-cfg_cls-focus-grid-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-cfg_hide-focus-grid" },
                { key: "gr-cfg_hide-focus-grid-alpha" }
              ],
            },
          },
        },
      },
      {
        name: "en-cfg_cls-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Properties",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-cfg_hide-cls" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "en-cfg_cls-frame-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear frame",
            enable: { key: "gr-cfg_use-cls-frame" },
            hidden: { key: "gr-cfg_hide-cls" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-cfg_use-cls-frame" },
            hidden: { key: "gr-cfg_hide-cls" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-cfg_cls-frame" },
            enable: { key: "gr-cfg_use-cls-frame" },
            hidden: { key: "gr-cfg_hide-cls" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "en-cfg_cls-frame-col-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear color",
            enable: { key: "gr-cfg_use-cls-frame-col" },
            hidden: { key: "gr-cfg_hide-cls" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-cfg_hide-cls-col" },
            hidden: { key: "gr-cfg_hide-cls" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-cfg_use-cls-frame-col" },
            hidden: { key: "gr-cfg_hide-cls" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_cls-frame-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-cfg_use-cls-frame-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-col" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-col" }
                ],
              },
            },
            slider: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-col" }
                ],
              },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-cfg_use-cls-frame-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-col" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-col" }
                ],
              },
            },
            slider: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-col" }
                ],
              },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-cfg_use-cls-frame-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-col" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-col" }
                ],
              },
            },
            slider: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-col" }
                ],
              },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-cfg_use-cls-frame-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-col" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-col" }
                ],
              },
            },
          },
        },
      },
      {
        name: "gr-cfg_cls-frame-col-spd",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Duration",
            enable: { key: "gr-cfg_use-cls-frame-col" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-cls" },
                { key: "gr-cfg_hide-cls-col" }
              ],
            },
          },  
          field: { 
            store: { key: "gr-cfg_cls-frame-col-spd" },
            enable: { key: "gr-cfg_use-cls-frame-col" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-cls" },
                { key: "gr-cfg_hide-cls-col" }
              ],
            },
          },
          decrease: {
            store: { key: "gr-cfg_cls-frame-col-spd" },
            enable: { key: "gr-cfg_use-cls-frame-col" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-cls" },
                { key: "gr-cfg_hide-cls-col" }
              ],
            },
            factor: -0.1,
          },
          increase: {
            store: { key: "gr-cfg_cls-frame-col-spd" },
            enable: { key: "gr-cfg_use-cls-frame-col" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-cls" },
                { key: "gr-cfg_hide-cls-col" }
              ],
            },
            factor: 0.1,
          },
          stick: {
            store: { key: "gr-cfg_cls-frame-col-spd" },
            enable: { key: "gr-cfg_use-cls-frame-col" },
            hidden: {
              keys: [
                { key: "gr-cfg_hide-cls" },
                { key: "gr-cfg_hide-cls-col" }
              ],
            },
            factor: 0.01,
          },
          checkbox: {
            hidden: {
              keys: [
                { key: "gr-cfg_hide-cls" },
                { key: "gr-cfg_hide-cls-col" }
              ],
            },
          },
        },
      },
      {
        name: "gr-cfg_cls-frame-col-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "gr-cfg_hide-cls" },
                { key: "gr-cfg_hide-cls-col" }
              ],
            },
          },
        },
      },
      {
        name: "gr-cfg_cls-frame-alpha-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear alpha",
            hidden: { key: "gr-cfg_hide-cls" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "gr-cfg_hide-cls-alpha" },
            hidden: { key: "gr-cfg_hide-cls" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //spriteOn: { name: "visu_texture_checkbox_switch_on" },
            //spriteOff: { name: "visu_texture_checkbox_switch_off" },
            hidden: { key: "gr-cfg_hide-cls" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_cls-frame-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "gr-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
            },
            decrease: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
              factor: -0.1,
            },
            increase: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
              factor: 0.1,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
            },
            decrease: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha"},
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
              factor: -0.1,
            },
            increase: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
              factor: 0.1,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
            },
            decrease: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
              factor: -0.1,
            },
            increase: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
              factor: 0.1,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
            },
            decrease: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
              factor: 0.001,
            },
            increase: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha"} ,
              hidden: {
                keys: [
                  { key: "gr-cfg_hide-cls" },
                  { key: "gr-cfg_hide-cls-alpha" }
                ],
              },
              factor: 0.001,
            },
          },
        },
      },
    ]),
  }
    
}