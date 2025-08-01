///@package io.alkapivo.visu.editor.service.brush.view

///@param {?Struct} [json]
///@return {Struct}
function brush_view_layer(json = null) {
  return {
    name: "brush_view_layer",
    store: new Map(String, Struct, {
      "vw-layer_type": {
        type: String,
        value: Struct.get(json, "vw-layer_type"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: WallpaperType.keys(),
      },
      "vw-layer_fade-in": {
        type: Number,
        value: Struct.get(json, "vw-layer_fade-in"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 99.9),
      },
      "vw-layer_fade-out": {
        type: Number,
        value: Struct.get(json, "vw-layer_fade-out"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 99.9),
      },
      "vw-layer_use-texture": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_use-texture"),
      },
      "vw-layer_texture": {
        type: Sprite,
        value: Struct.get(json, "vw-layer_texture"),
      },
      "vw-layer_use-texture-blend": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_use-texture-blend"),
      },
      "vw-layer_texture-blend": {
        type: Color,
        value: Struct.get(json, "vw-layer_texture-blend"),
      },
      "vw-layer_use-col": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_use-col"),
      },
      "vw-layer_col": {
        type: Color,
        value: Struct.get(json, "vw-layer_col"),
      },
      "vw-layer_cls-texture": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_cls-texture"),
      },
      "vw-layer_cls-col": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_cls-col"),
      },
      "vw-layer_use-blend": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_use-blend"),
      },
      "vw-layer_blend-src": {
        type: String,
        value: Struct.get(json, "vw-layer_blend-src"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendModeExt.keys(),
      },
      "vw-layer_blend-dest": {
        type: String,
        value: Struct.get(json, "vw-layer_blend-dest"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendModeExt.keys(),
      },
      "vw-layer_blend-eq": {
        type: String,
        value: Struct.get(json, "vw-layer_blend-eq"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendEquation.keys(),
      },
      "vw-layer_blend-eq-alpha": {
        type: String,
        value: Struct.get(json, "vw-layer_blend-eq-alpha"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendEquation.keys(),
      },
      "vw-layer_use-spd": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_use-spd"),
      },
      "vw-layer_spd": {
        type: NumberTransformer,
        value: Struct.get(json, "vw-layer_spd"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 99.9),
      },
      "vw-layer_change-spd": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_change-spd"),
      },
      "vw-layer_use-dir": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_use-dir"),
      },
      "vw-layer_dir": {
        type: NumberTransformer,
        value: Struct.get(json, "vw-layer_dir"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(-9999.9, 9999.9),
      },
      "vw-layer_change-dir": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_change-dir"),
      },
      "vw-layer_use-scale-x": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_use-scale-x"),
      },
      "vw-layer_scale-x": {
        type: NumberTransformer,
        value: Struct.get(json, "vw-layer_scale-x"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(-99.9, 99.9),
      },
      "vw-layer_change-scale-x": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_change-scale-x"),
      },
      "vw-layer_use-scale-y": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_use-scale-y"),
      },
      "vw-layer_scale-y": {
        type: NumberTransformer,
        value: Struct.get(json, "vw-layer_scale-y"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(-99.9, 99.9),
      },
      "vw-layer_change-scale-y": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_change-scale-y"),
      },
      "vw-layer_use-texture-tiled": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_use-texture-tiled"),
      },
      "vw-layer_use-texture-replace": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_use-texture-replace"),
      },
      "vw-layer_texture-reset-pos": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_texture-reset-pos"),
      },
      "vw-layer_texture-use-lifespan": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_texture-use-lifespan"),
      },
      "vw-layer_texture-lifespan": {
        type: Number,
        value: Struct.get(json, "vw-layer_texture-lifespan"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 9999.9),
      },
      "vw-layer_hide": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_hide"),
      },
      "vw-layer_hide-blend": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_hide-blend"),
      },
      "vw-layer_hide-cls": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_hide-cls"),
      },
      "vw-layer_hide-tx-layer": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_hide-tx-layer"),
      },
      "vw-layer_hide-tx": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_hide-tx"),
      },
      "vw-layer_hide-tx-blend": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_hide-tx-blend"),
      },
      "vw-layer_hide-tx-spd": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_hide-tx-spd"),
      },
      "vw-layer_hide-tx-dir": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_hide-tx-dir"),
      },
      "vw-layer_hide-tx-scale-x": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_hide-tx-scale-x"),
      },
      "vw-layer_hide-tx-scale-y": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_hide-tx-scale-y"),
      },
      "vw-layer_hide-col": {
        type: Boolean,
        value: Struct.get(json, "vw-layer_hide-col"),
      },
    }),
    components: new Array(Struct, [
      {
        name: "vw-layer_title",
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
            store: { key: "vw-layer_hide" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "vw-layer_texture-lifespan",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Lifespan",
            enable: { key: "vw-layer_texture-use-lifespan" },
            hidden: { key: "vw-layer_hide" },
          },
          field: { 
            store: { key: "vw-layer_texture-lifespan" },
            enable: { key: "vw-layer_texture-use-lifespan" },
            hidden: { key: "vw-layer_hide" },
          },
          decrease: {
            store: { key: "vw-layer_texture-lifespan" },
            enable: { key: "vw-layer_texture-use-lifespan" },
            hidden: { key: "vw-layer_hide" },
            factor: -0.25,
          },
          increase: {
            store: { key: "vw-layer_texture-lifespan" },
            enable: { key: "vw-layer_texture-use-lifespan" },
            hidden: { key: "vw-layer_hide" },
            factor: 0.25,
          },
          stick: {
            store: { key: "vw-layer_texture-lifespan" },
            enable: { key: "vw-layer_texture-use-lifespan" },
            hidden: { key: "vw-layer_hide" },
            factor: 0.001,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-layer_texture-use-lifespan" },
            hidden: { key: "vw-layer_hide" },
          },
          title: { 
            text: "Override",
            enable: { key: "vw-layer_texture-use-lifespan" },
            hidden: { key: "vw-layer_hide" },
          },
        }
      },
      {
        name: "vw-layer_fade-in",  
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Fade in",
            hidden: { key: "vw-layer_hide" },
          },
          field: {
            store: { key: "vw-layer_fade-in" },
            hidden: { key: "vw-layer_hide" },
          },
          decrease: {
            store: { key: "vw-layer_fade-in" },
            hidden: { key: "vw-layer_hide" },
            factor: -0.25,
          },
          increase: {
            store: { key: "vw-layer_fade-in" },
            hidden: { key: "vw-layer_hide" },
            factor: 0.25,
          },
          stick: {
            store: { key: "vw-layer_fade-in" },
            hidden: { key: "vw-layer_hide" },
            factor: 0.01,
          },
          checkbox: { hidden: { key: "vw-layer_hide" } },
        },
      },
      {
        name: "vw-layer_fade-out",  
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Fade out",
            hidden: { key: "vw-layer_hide" },
          },
          field: {
            store: { key: "vw-layer_fade-out" },
            hidden: { key: "vw-layer_hide" },
          },
          decrease: {
            store: { key: "vw-layer_fade-out" },
            hidden: { key: "vw-layer_hide" },
            factor: -0.25,
          },
          increase: {
            store: { key: "vw-layer_fade-out" },
            hidden: { key: "vw-layer_hide" },
            factor: 0.25,
          },
          stick: {
            store: { key: "vw-layer_fade-out" },
            hidden: { key: "vw-layer_hide" },
            factor: 0.01,
          },
          checkbox: { hidden: { key: "vw-layer_hide" } },
        },
      },
      {
        name: "vw-layer_type",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Type",
            //font: "font_inter_10_bold",
            //color: VETheme.color.text,
            hidden: { key: "vw-layer_hide" },
          },
          previous: {
            store: { key: "vw-layer_type" },
            hidden: { key: "vw-layer_hide" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-layer_type" },
            hidden: { key: "vw-layer_hide" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: {
            store: { key: "vw-layer_type" },
            hidden: { key: "vw-layer_hide" },
          },
        },
      },
      {
        name: "vw-layer_blend-mode-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Blend mode",
            enable: { key: "vw-layer_use-blend" },
            hidden: { key: "vw-layer_hide" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-layer_use-blend" },
            hidden: { key: "vw-layer_hide" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-layer_hide-blend" },
            hidden: { key: "vw-layer_hide" },
          },
        },
      },
      {
        name: "vw-layer_blend-src",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Source",
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
          previous: {
            store: { key: "vw-layer_blend-src" },
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-layer_blend-src" },
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
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
            store: { key: "vw-layer_blend-src" },
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
        },
      },
      {
        name: "vw-layer_blend-dest",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Target",
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
          previous: {
            store: { key: "vw-layer_blend-dest" },
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-layer_blend-dest" },
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
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
            store: { key: "vw-layer_blend-dest" },
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
        },
      },
      {
        name: "vw-layer_blend-eq",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Equation",
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
          previous: {
            store: { key: "vw-layer_blend-eq" },
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-layer_blend-eq" },
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
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
            store: { key: "vw-layer_blend-eq" },
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
        },
      },
      {
        name: "vw-layer_blend-eq-alpha",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Eq. alpha",
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
          previous: {
            store: { key: "vw-layer_blend-eq-alpha" },
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-layer_blend-eq-alpha" },
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
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
            store: { key: "vw-layer_blend-eq-alpha" },
            enable: { key: "vw-layer_use-blend" },
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
        },
      },
      {
        name: "vw-layer_blend-eq-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "vw-layer_hide" },
                { key: "vw-layer_hide-blend" }
              ],
            },
          },
        },
      },


      
      {
        name: "vw-cls-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Remove",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-layer_hide-cls" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "vw-layer_cls-texture",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Texture",
            enable: { key: "vw-layer_cls-texture" },
            hidden: { key: "vw-layer_hide-cls" },
          },
          input: { 
            hidden: { key: "vw-layer_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-layer_cls-texture" },
            hidden: { key: "vw-layer_hide-cls" },
          },
        },
      },
      {
        name: "vw-layer_cls-col",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Color",
            enable: { key: "vw-layer_cls-col" },
            hidden: { key: "vw-layer_hide-cls" },
          },
          input: {
            hidden: { key: "vw-layer_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-layer_cls-col" },
            hidden: { key: "vw-layer_hide-cls" },
          },
        },
      },
      {
        name: "vw-layer_cls-col-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "vw-layer_hide-cls" } },
        },
      },
      {
        name: "vw-layer_use-texture",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Texture",
            enable: { key: "vw-layer_use-texture" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-layer_use-texture" },
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-layer_hide-tx-layer" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "vw-layer_use-texture-tiled",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render texture tiled",
            enable: {
              keys: [ 
                { key: "vw-layer_use-texture" },
                { key: "vw-layer_use-texture-tiled" }
              ],
            },
            updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          input: {
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-layer_use-texture-tiled" },
            enable: { key: "vw-layer_use-texture" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
        },
      },
      {
        name: "vw-layer_use-texture-replace",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Replace texture layer",
            enable: {
              keys: [ 
                { key: "vw-layer_use-texture" },
                { key: "vw-layer_use-texture-replace" }
              ],
            },
            updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          input: {
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-layer_use-texture-replace" },
            enable: { key: "vw-layer_use-texture" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
        },
      },
      {
        name: "vw-layer_texture-reset-pos",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Restart texture position",
            enable: {
              keys: [ 
                { key: "vw-layer_use-texture" },
                { key: "vw-layer_texture-reset-pos" }
              ],
            },
            updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          input: {
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-layer_texture-reset-pos" },
            enable: { key: "vw-layer_use-texture" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
        },
      },
      {
        name: "vw-layer_texture-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Texture",
            enable: { key: "vw-layer_use-texture" },
            hidden: { key: "vw-layer_hide-tx-layer" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-layer_hide-tx" },
            hidden: { key: "vw-layer_hide-tx-layer" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            hidden: { key: "vw-layer_hide-tx-layer" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "vw-layer_texture",
        template: VEComponents.get("texture-field"),
        layout: VELayouts.get("texture-field"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
          },
          texture: {
            label: { 
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            }, 
            field: {
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
          },
          preview: {
            image: { name: "texture_empty" },
            store: { key: "vw-layer_texture" },
            enable: { key: "vw-layer_use-texture" },
            hidden: {
              keys: [
                { key: "vw-layer_hide-tx-layer" },
                { key: "vw-layer_hide-tx" }
              ],
            },
            imageBlendStoreKey: "vw-layer_texture-blend",
            useImageBlendStoreKey: "vw-layer_use-texture-blend",
            updateCustom: function() {
              var key = Struct.get(this, "imageBlendStoreKey")
              var use = Struct.get(this, "useImageBlendStoreKey")
              if (!Core.isType(this.store, UIStore) ||
                  !Core.isType(key, String) ||
                  !Core.isType(use, String) ||
                  !Core.isType(this.image, Sprite)) {
                return
              }

              var store = this.store.getStore()
              if (!Core.isType(store, Store)) {
                return
              }

              var color = store.getValue(key)
              if (!Core.isType(color, Color)) {
                return
              }

              this.image.setBlend(store.getValue(use) ? color.toGMColor() : c_white)
            },
          },
          resolution: {
            store: { key: "vw-layer_texture" },
            enable: { key: "vw-layer_use-texture" },
            hidden: {
              keys: [
                { key: "vw-layer_hide-tx-layer" },
                { key: "vw-layer_hide-tx" }
              ],
            },
          },
          frame: {
            label: {
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            field: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            decrease: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            increase: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            title: {
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
          },
          speed: {
            label: {
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            field: { 
              enable: { key: "vw-layer_use-texture" },
              store: { key: "vw-layer_texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            decrease: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            increase: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            title: {
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
          },
          alpha: {
            label: {
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            field: { 
              enable: { key: "vw-layer_use-texture" },
              store: { key: "vw-layer_texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            decrease: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            increase: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
            slider: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx" }
                ],
              },
            },
          },
        },
      },
      {
        name: "vw-layer_texture-blend-property",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Blend texture",
            enable: {
              keys: [ 
                { key: "vw-layer_use-texture" },
                { key: "vw-layer_use-texture-blend" }
              ],
            },
            updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            enable: { key: "vw-layer_use-texture" },
            store: { key: "vw-layer_use-texture-blend" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-layer_hide-tx-blend" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
        },
      },
      {
        name: "vw-layer_texture-blend",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          red: {
            label: {
              text: "Red",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            increase: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            slider: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            increase: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            slider: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            increase: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            slider: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_texture-blend" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-texture-blend" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-blend" }
                ],
              },
            },
          },
        },
      },
      {
        name: "vw-layer_texture-blend-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "vw-layer_hide-tx-layer" },
                { key: "vw-layer_hide-tx-blend" }
              ],
            },
          },
        },
      },
      {
        name: "vw-layer_spd-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Speed",
            enable: { key: "vw-layer_use-texture" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          input: {
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-layer_hide-tx-spd" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
        },
      },
      {
        name: "vw-layer_spd",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              enable: { key: "vw-layer_use-spd" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_spd" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_spd" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_spd" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
              factor: 0.25,        
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_use-spd" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
            title: { 
              text: "Override",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_spd" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_spd" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_spd" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_change-spd" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
            title: { 
              text: "Change",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_spd" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_spd" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "vw-layer_spd" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
              factor: 0.01,
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_spd" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_spd" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "vw-layer_spd" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
              factor: 0.001,      
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-spd" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-spd" }
                ],
              },
            },
          },
          duration: {
            label: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            field: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            decrease: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            increase: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            stick: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            checkbox: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            title: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
          },
          ease: {
            label: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            previous: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            preview: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            next: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
          },
        },
      },
      {
        name: "vw-layer_spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "vw-layer_hide-tx-layer" },
                { key: "vw-layer_hide-tx-spd" }
              ],
            },
          },
        },
      },
      {
        name: "vw-layer_dir-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Angle",
            enable: { key: "vw-layer_use-texture" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          input: {
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-layer_hide-tx-dir" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
        },
      },
      {
        name: "vw-layer_dir",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              enable: { key: "vw-layer_use-dir" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_dir" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_dir" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_dir" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
              factor: 0.25,        
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              enable: { key: "vw-layer_use-texture" },
              store: { key: "vw-layer_use-dir" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
            title: { 
              text: "Override",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            }
          },
          target: {
            label: {
              text: "Target",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_dir" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_dir" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_dir" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              enable: { key: "vw-layer_use-texture" },
              store: { key: "vw-layer_change-dir" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
            title: { 
              text: "Change",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_dir" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_dir" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "vw-layer_dir" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
              factor: 0.01,
            },
            checkbox: { 
              store: { 
                key: "vw-layer_dir",
                callback: function(value, data) { 
                  if (!Core.isType(value, NumberTransformer)) {
                    return
                  }

                  var sprite = Struct.get(data, "sprite")
                  if (!Core.isType(sprite, Sprite)) {
                    sprite = SpriteUtil.parse({ name: "visu_texture_ui_angle_arrow" })
                    Struct.set(data, "sprite", sprite)
                  }

                  sprite.setAngle(value.value)
                },
                set: function(value) { return },
              },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
              render: function() {
                if (!Optional.is(this.store) || this.store.getStore() == null) {
                  return
                }

                var sprite = Struct.get(this, "sprite")
                if (!Core.isType(sprite, Sprite)) {
                  sprite = SpriteUtil.parse({ name: "visu_texture_ui_angle_arrow" })
                  Struct.set(this, "sprite", sprite)
                }

                sprite.scaleToFit(this.area.getWidth() * 2, this.area.getHeight() * 2)

                var itemUse = this.store.getStore().get("vw-layer_use-dir")
                if (Optional.is(itemUse) && itemUse.get()) {
                  sprite.render(
                    this.context.area.getX() + this.area.getX() + 2 + sprite.texture.offsetX * sprite.getScaleX(),
                    this.context.area.getY() + this.area.getY() + 4 + sprite.texture.offsetY * sprite.getScaleY()
                  )
                }

                var transformer = this.store.getValue()
                var itemChange = this.store.getStore().get("vw-layer_change-dir")
                if (Optional.is(itemChange) && itemChange.get() && Optional.is(transformer)) {
                  var alpha = sprite.getAlpha()
                  sprite.setAngle(transformer.target)
                    .setAlpha(alpha * 0.66)
                    .render(
                      this.context.area.getX() + this.area.getX() + 2 + sprite.texture.offsetX * sprite.getScaleX(),
                      this.context.area.getY() + this.area.getY() + 4 + sprite.texture.offsetY * sprite.getScaleY()
                    )
                    .setAngle(transformer.value)
                    .setAlpha(alpha)
                }
                
                return this
              },
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_dir" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_dir" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "vw-layer_dir" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
              factor: 0.001,      
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-dir" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-dir" }
                ],
              },
            },
          },
          duration: {
            label: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            field: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            decrease: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            increase: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            stick: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            checkbox: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            title: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
          },
          ease: {
            label: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            previous: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            preview: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            next: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
          },
        },
      },
      {
        name: "vw-layer_dir-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "vw-layer_hide-tx-layer" },
                { key: "vw-layer_hide-tx-dir" }
              ],
            },
          },
        },
      },
      {
        name: "vw-layer_scale-x-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Scale X",
            enable: { key: "vw-layer_use-texture" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          input: {
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-layer_hide-tx-scale-x" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
        },
      },
      {
        name: "vw-layer_scale-x",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              enable: { key: "vw-layer_use-scale-x" },
            },
            field: {
              store: { key: "vw-layer_scale-x" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_scale-x" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_scale-x" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
              factor: 0.25,        
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_use-scale-x" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            title: { 
              text: "Override",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_scale-x" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_scale-x" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_scale-x" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
              factor: 0.25,
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_change-scale-x" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            title: { 
              text: "Change",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_scale-x" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_scale-x" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "vw-layer_scale-x" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
              factor: 0.01,
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            checkbox: {
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_scale-x" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_scale-x" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "vw-layer_scale-x" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
              factor: 0.001,      
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-x" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
            checkbox: {
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-x" }
                ],
              },
            },
          },
          duration: {
            label: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            field: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            decrease: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            increase: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            stick: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            checkbox: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            title: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
          },
          ease: {
            label: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            previous: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            preview: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            next: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
          },
        },
      },
      {
        name: "vw-layer_scale-x-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "vw-layer_hide-tx-layer" },
                { key: "vw-layer_hide-tx-scale-x" }
              ],
            },
          },
        },
      },
      {
        name: "vw-layer_scale-y-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Scale Y",
            enable: { key: "vw-layer_use-texture" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          input: {
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-layer_hide-tx-scale-y" },
            hidden: { key: "vw-layer_hide-tx-layer" },
          },
        },
      },
      {
        name: "vw-layer_scale-y",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              enable: { key: "vw-layer_use-scale-y" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_scale-y" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_scale-y" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_scale-y" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
              factor: 0.25,        
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_use-scale-y" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            title: { 
              text: "Override",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_use-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_scale-y" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_scale-y" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_scale-y" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
              factor: 0.25,
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_change-scale-y" },
              enable: { key: "vw-layer_use-texture" },
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            title: { 
              text: "Change",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_scale-y" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_scale-y" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
              factor: -0.01,
            },
            increase: {
              store: { key: "vw-layer_scale-y" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
              factor: 0.01,
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            checkbox: {
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            field: {
              store: { key: "vw-layer_scale-y" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            decrease: {
              store: { key: "vw-layer_scale-y" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
              factor: -0.001,
            },
            increase: {
              store: { key: "vw-layer_scale-y" },
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
              factor: 0.001,      
            },
            stick: {
              enable: {
                keys: [ 
                  { key: "vw-layer_use-texture" },
                  { key: "vw-layer_change-scale-y" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
            checkbox: {
              hidden: {
                keys: [
                  { key: "vw-layer_hide-tx-layer" },
                  { key: "vw-layer_hide-tx-scale-y" }
                ],
              },
            },
          },
          duration: {
            label: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            field: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            decrease: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            increase: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            stick: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            checkbox: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            title: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
          },
          ease: {
            label: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            previous: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            preview: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
            next: { updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")) },
          },
        },
      },
      {
        name: "vw-layer-col-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "vw-layer_hide-tx-layer" },
                { key: "vw-layer_hide-tx-scale-y" }
              ],
            },
          },
        },
      },
      {
        name: "vw-layer_col-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Color",
            enable: { key: "vw-layer_use-col" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-layer_use-col" },
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-layer_hide-col" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "vw-layer_col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker-alpha"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          red: {
            label: { 
              text: "Red",
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
            field: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
            slider: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
          },
          green: {
            label: { 
              text: "Green",
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
            field: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
            slider: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
          },
          blue: {
            label: { 
              text: "Blue",
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
            field: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
            slider: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
          },
          alpha: {
            label: { 
              text: "Alpha",
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
            field: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
            slider: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
          },
          hex: { 
            label: { 
              text: "Hex",
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
            field: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
              hidden: { key: "vw-layer_hide-col" },
            },
          },
        },
      },
    ]),
  }
}