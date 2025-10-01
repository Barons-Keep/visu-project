///@package io.alkapivo.visu.editor.service.brush.view

///@param {?Struct} [json]
///@return {Struct}
function brush_view_config(json = null) {
  return {
    name: "brush_view_config",
    store: new Map(String, Struct, {
      "vw-cfg_use-render-hud": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_use-render-hud"),
      },
      "vw-cfg_render-hud": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_render-hud"),
      },
      "vw-cfg_use-render-subtitle": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_use-render-subtitle"),
      },
      "vw-cfg_render-subtitle": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_render-subtitle"),
      },
      "vw-cfg_use-render-video": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_use-render-video"),
      },
      "vw-cfg_render-video": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_render-video"),
      },
      "vw-cfg_cls-subtitle": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_cls-subtitle"),
      },    
      "vw-cfg_cls-bkg-texture": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_cls-bkg-texture"),
      },    
      "vw-cfg_cls-bkg-col": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_cls-bkg-col"),
      },
      "vw-cfg_cls-frg-texture": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_cls-frg-texture"),
      },    
      "vw-cfg_cls-frg-col": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_cls-frg-col"),
      },
      "vw-cfg_use-video-alpha": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_use-video-alpha"),
      },
      "vw-cfg_video-alpha": {
        type: NumberTransformer,
        value: Struct.get(json, "vw-cfg_video-alpha"),
        passthrough: UIUtil.passthrough.getNormalizedNumberTransformer(),
      },
      "vw-cfg_change-video-alpha": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_change-video-alpha"),
      },
      "vw-cfg_video-use-blend-col": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_video-use-blend-col"),
      },
      "vw-cfg_video-blend-col": {
        type: Color,
        value: Struct.get(json, "vw-cfg_video-blend-col"),
      },
      "vw-cfg_video-blend-col-spd": {
        type: Number,
        value: Struct.get(json, "vw-cfg_video-blend-col-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "vw-cfg_video-use-blend": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_video-use-blend"),
      },
      "vw-cfg_video-blend-src": {
        type: String,
        value: Struct.get(json, "vw-cfg_video-blend-src"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendModeExt.keys(),
      },
      "vw-cfg_video-blend-dest": {
        type: String,
        value: Struct.get(json, "vw-cfg_video-blend-dest"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendModeExt.keys(),
      },
      "vw-cfg_video-blend-eq": {
        type: String,
        value: Struct.get(json, "vw-cfg_video-blend-eq"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendEquation.keys(),
      },
      "vw-cfg_video-blend-eq-alpha": {
        type: String,
        value: Struct.get(json, "vw-cfg_video-blend-eq-alpha"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendEquation.keys(),
      },
      "vw-cfg_use-render-video-after": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_use-render-video-after"),
      },
      "vw-cfg_render-video-after": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_render-video-after"),
      },
      "vw-cfg_hide-render": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_hide-render"),
      },
      "vw-cfg_hide-cls": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_hide-cls"),
      },
      "vw-cfg_hide-video": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_hide-video"),
      },
      "vw-cfg_hide-video-blend": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_hide-video-blend"),
      },
      "vw-cfg_hide-video-col": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_hide-video-col"),
      },
      "vw-cfg_hide-video-alpha": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_hide-video-alpha"),
      },
    }),
    components: new Array(Struct, [
      {
        name: "vw-cfg_render",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-cfg_hide-render" },
            backgroundColor: VETheme.color.accentShadow
          },
          input: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-cfg_use-render-hud",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "HUD",
            enable: { key: "vw-cfg_use-render-hud" },
            hidden: { key: "vw-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_use-render-hud" },
            hidden: { key: "vw-cfg_hide-render" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-cfg_render-hud" },
            enable: { key: "vw-cfg_use-render-hud" },
            hidden: { key: "vw-cfg_hide-render" },
          }
        },
      },
      {
        name: "vw-cfg_use-render-subtitle",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Subtitle",
            enable: { key: "vw-cfg_use-render-subtitle" },
            hidden: { key: "vw-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_use-render-subtitle" },
            hidden: { key: "vw-cfg_hide-render" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-cfg_render-subtitle" },
            enable: { key: "vw-cfg_use-render-subtitle" },
            hidden: { key: "vw-cfg_hide-render" },
          }
        },
      },
      {
        name: "vw-cfg_use-render-video",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Video",
            enable: { key: "vw-cfg_use-render-video" },
            hidden: { key: "vw-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_use-render-video" },
            hidden: { key: "vw-cfg_hide-render" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-cfg_render-video" },
            enable: { key: "vw-cfg_use-render-video" },
            hidden: { key: "vw-cfg_hide-render" },
          }
        },
      },
      {
        name: "vw-cfg_use-render-video-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "vw-cfg_hide-render" } },
        },
      },
      {
        name: "vw-cfg_cls",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-cfg_hide-cls" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-cfg_cls-subtitle",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Subtitle",
            enable: { key: "vw-cfg_cls-subtitle" },
            hidden: { key: "vw-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_cls-subtitle" },
            hidden: { key: "vw-cfg_hide-cls" },
          },
          input: { },
        },
      },
      {
        name: "vw-cfg_cls-bkg-texture",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Background texture",
            enable: { key: "vw-cfg_cls-bkg-texture" },
            hidden: { key: "vw-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_cls-bkg-texture" },
            hidden: { key: "vw-cfg_hide-cls" },
          },
          input: { },
        },
      },
      {
        name: "vw-cfg_cls-bkg-col",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Background color",
            enable: { key: "vw-cfg_cls-bkg-col" },
            hidden: { key: "vw-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_cls-bkg-col" },
            hidden: { key: "vw-cfg_hide-cls" },
          },
          input: { },
        },
      },
      {
        name: "vw-cfg_cls-frg-texture",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Foreground texture",
            enable: { key: "vw-cfg_cls-frg-texture" },
            hidden: { key: "vw-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_cls-frg-texture" },
            hidden: { key: "vw-cfg_hide-cls" },
          },
          input: { },
        },
      },
      {
        name: "vw-cfg_cls-frg-col",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Foreground color",
            enable: { key: "vw-cfg_cls-frg-col" },
            hidden: { key: "vw-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_cls-frg-col" },
            hidden: { key: "vw-cfg_hide-cls" },
          },
          input: { },
        },
      },
      {
        name: "vw-cfg_cls-frg-col-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "vw-cfg_hide-cls" } },
        },
      },
      {
        name: "vw-cfg_video-config-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Video config",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-cfg_hide-video" },
          },
          input: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-cfg_use-render-video-after",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render after background",
            enable: { key: "vw-cfg_use-render-video-after" },
            hidden: { key: "vw-cfg_hide-video" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_use-render-video-after" },
            hidden: { key: "vw-cfg_hide-video" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-cfg_render-video-after" },
            enable: { key: "vw-cfg_use-render-video-after" },
            hidden: { key: "vw-cfg_hide-video" },
          }
        },
      },
      {
        name: "vw-cfg_video-use-blend",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Blend mode",
            //backgroundColor: VETheme.color.accentShadow,
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: { key: "vw-cfg_hide-video" },
          },
          //input: { backgroundColor: VETheme.color.accentShadow },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-cfg_video-use-blend" },
            hidden: { key: "vw-cfg_hide-video" }
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-cfg_hide-video-blend" },
            hidden: { key: "vw-cfg_hide-video" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "vw-cfg_video-blend-src",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Source",
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
          previous: {
            store: { key: "vw-cfg_video-blend-src" },
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-cfg_video-blend-src" },
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
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
            store: { key: "vw-cfg_video-blend-src" },
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
        },
      },
      {
        name: "vw-cfg_video-blend-dest",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Target",
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
          previous: {
            store: { key: "vw-cfg_video-blend-dest" },
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-cfg_video-blend-dest" },
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
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
            store: { key: "vw-cfg_video-blend-dest" },
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
        },
      },
      {
        name: "vw-cfg_video-blend-eq",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Equation",
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
          previous: {
            store: { key: "vw-cfg_video-blend-eq" },
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-cfg_video-blend-eq" },
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
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
            store: { key: "vw-cfg_video-blend-eq" },
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
        },
      },
      {
        name: "vw-cfg_video-blend-eq-alpha",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Eq. alpha",
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
          previous: {
            store: { key: "vw-cfg_video-blend-eq-alpha" },
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-cfg_video-blend-eq-alpha" },
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
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
            store: { key: "vw-cfg_video-blend-eq-alpha" },
            enable: { key: "vw-cfg_video-use-blend" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
        },
      },
      {
        name: "vw-cfg_video-blend-eq-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-blend" }
              ]
            },
          },
        },
      },
      {
        name: "vw-cfg_video-blend-col-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Blend color",
            enable: { key: "vw-cfg_video-use-blend-col" },
            hidden: { key: "vw-cfg_hide-video" },
            //backgroundColor: VETheme.color.side,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-cfg_hide-video-col" },
            hidden: { key: "vw-cfg_hide-video" },
            //backgroundColor: VETheme.color.side,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-cfg_video-use-blend-col" },
            hidden: { key: "vw-cfg_hide-video" },
            //backgroundColor: VETheme.color.side,
          }
        },
      },
      {
        name: "vw-cfg_video-blend-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          red: {
            label: {
              text: "Red",
              enable: { key: "vw-cfg_video-use-blend-col" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-col" }
                ]
              },
            },
            field: {
              store: { key: "vw-cfg_video-blend-col" },
              enable: { key: "vw-cfg_video-use-blend-col" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-col" }
                ]
              },
            },
            slider: {
              store: { key: "vw-cfg_video-blend-col" },
              enable: { key: "vw-cfg_video-use-blend-col" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-col" }
                ]
              },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "vw-cfg_video-use-blend-col" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-col" }
                ]
              },
            },
            field: {
              store: { key: "vw-cfg_video-blend-col" },
              enable: { key: "vw-cfg_video-use-blend-col" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-col" }
                ]
              },
            },
            slider: {
              store: { key: "vw-cfg_video-blend-col" },
              enable: { key: "vw-cfg_video-use-blend-col" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-col" }
                ]
              },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "vw-cfg_video-use-blend-col" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-col" }
                ]
              },
            },
            field: {
              store: { key: "vw-cfg_video-blend-col" },
              enable: { key: "vw-cfg_video-use-blend-col" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-col" }
                ]
              },
            },
            slider: {
              store: { key: "vw-cfg_video-blend-col" },
              enable: { key: "vw-cfg_video-use-blend-col" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-col" }
                ]
              },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "vw-cfg_video-use-blend-col" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-col" }
                ]
              },
            },
            field: {
              store: { key: "vw-cfg_video-blend-col" },
              enable: { key: "vw-cfg_video-use-blend-col" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-col" }
                ]
              },
            },
          },
        },
      },
      {
        name: "vw-cfg_video-blend-col-spd",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Duration",
            enable: { key: "vw-cfg_video-use-blend-col" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-col" }
              ]
            },
          },  
          field: { 
            store: { key: "vw-cfg_video-blend-col-spd" },
            enable: { key: "vw-cfg_video-use-blend-col" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-col" }
              ]
            },
          },
          decrease: {
            store: { key: "vw-cfg_video-blend-col-spd" },
            enable: { key: "vw-cfg_video-use-blend-col" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-col" }
              ]
            },
            factor: -0.1,
          },
          increase: {
            store: { key: "vw-cfg_video-blend-col-spd" },
            enable: { key: "vw-cfg_video-use-blend-col" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-col" }
              ]
            },
            factor: 0.1,
          },
          stick: {
            store: { key: "vw-cfg_video-blend-col-spd" },
            enable: { key: "vw-cfg_video-use-blend-col" },
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-col" }
              ]
            },
            factor: 0.01,
          },
          checkbox: {
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-col" }
              ]
            },
          },
        },
      },
      {
        name: "vw-cfg_video-blend-col-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "vw-cfg_hide-video" },
                { key: "vw-cfg_hide-video-col" }
              ]
            },
          },
        },
      },
      {
        name: "vw-cfg_video-alpha-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Alpha",
            //enable: { key: "vw-cfg_use-video-alpha" },
            hidden: { key: "vw-cfg_hide-video" },
            //backgroundColor: VETheme.color.side,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "vw-cfg_hide-video-alpha" },
            hidden: { key: "vw-cfg_hide-video" },
            //backgroundColor: VETheme.color.side,
          },
          input: {
            //spriteOn: { name: "visu_texture_checkbox_switch_on" },
            //spriteOff: { name: "visu_texture_checkbox_switch_off" },
            //store: { key: "vw-cfg_use-video-alpha" },
            hidden: { key: "vw-cfg_hide-video" },
            //backgroundColor: VETheme.color.side,
          }
        },
      },
      {
        name: "vw-cfg_video-alpha",
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
              enable: { key: "vw-cfg_use-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
            },
            field: {
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_use-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
            },
            decrease: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_use-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_use-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cfg_use-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-cfg_use-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
            },
            stick: {
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_use-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
              factor: 0.01,
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-cfg_change-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
            },
            field: {
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
            },
            decrease: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cfg_change-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-cfg_change-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
            },
            stick: {
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
              factor: 0.01,
            },
          },
          duration: {
            label: {
              text: "Duration",
              enable: { key: "vw-cfg_change-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
            },
            field: {
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
            },
            decrease: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
              factor: 0.01,
            },
            stick: {
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              hidden: {
                keys: [
                  { key: "vw-cfg_hide-video" },
                  { key: "vw-cfg_hide-video-alpha" }
                ]
              },
              factor: 0.01,
            },
          },
        },
      },
    ]),
  }
}