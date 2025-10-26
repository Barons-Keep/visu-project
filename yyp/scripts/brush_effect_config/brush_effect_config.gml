///@package io.alkapivo.visu.editor.service.brush.effect

///@param {Struct} json
///@return {Struct}
function brush_effect_config(json) {
  return {
    name: "brush_effect_config",
    store: new Map(String, Struct, {
      "ef-cfg_use-render-shd-bkg": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_use-render-shd-bkg"),
      },
      "ef-cfg_render-shd-bkg": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_render-shd-bkg"),
      },
      "ef-cfg_cls-shd-bkg": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_cls-shd-bkg"),
      },
      "ef-cfg_use-render-shd-gr": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_use-render-shd-gr"),
      },
      "ef-cfg_render-shd-gr": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_render-shd-gr"),
      },
      "ef-cfg_cls-shd-gr": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_cls-shd-gr"),
      },
      "ef-cfg_use-render-shd-all": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_use-render-shd-all"),
      },
      "ef-cfg_render-shd-all": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_render-shd-all"),
      },
      "ef-cfg_cls-shd-all": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_cls-shd-all"),
      },
      "ef-cfg_use-render-glt": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_use-render-glt"),
      },
      "ef-cfg_render-glt": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_render-glt"),
      },
      "ef-cfg_cls-glt": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_cls-glt"),
      },
      "ef-cfg_use-render-gr-glt": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_use-render-gr-glt"),
      },
      "ef-cfg_render-gr-glt": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_render-gr-glt"),
      },
      "ef-cfg_cls-gr-glt": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_cls-gr-glt"),
      },
      "ef-cfg_use-render-bkg-glt": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_use-render-bkg-glt"),
      },
      "ef-cfg_render-bkg-glt": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_render-bkg-glt"),
      },
      "ef-cfg_cls-bkg-glt": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_cls-bkg-glt"),
      },
      "ef-cfg_use-render-part": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_use-render-part"),
      },
      "ef-cfg_render-part": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_render-part"),
      },
      "ef-cfg_cls-part": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_cls-part"),
      },
      /*
      "ef-cfg_use-cls-frame": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_use-cls-frame"),
      },
      "ef-cfg_cls-frame": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_cls-frame"),
      },
      "ef-cfg_use-cls-frame-col": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_use-cls-frame-col"),
      },
      "ef-cfg_cls-frame-col": {
        type: Color,
        value: Struct.get(json, "ef-cfg_cls-frame-col"),
      },
      "ef-cfg_cls-frame-col-spd": {
        type: Number,
        value: Struct.get(json, "ef-cfg_cls-frame-col-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "ef-cfg_cls-frame-alpha": {
        type: NumberTransformer,
        value: Struct.get(json, "ef-cfg_cls-frame-alpha"),
        passthrough: UIUtil.passthrough.getNormalizedNumberTransformer(),
      },
      "ef-cfg_use-cls-frame-alpha": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_use-cls-frame-alpha"),
      },
      "ef-cfg_change-cls-frame-alpha": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_change-cls-frame-alpha"),
      },
      */
      "ef-cfg_use-particle-z": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_use-particle-z"),
      },
      "ef-cfg_particle-z": {
        type: NumberTransformer,
        value: Struct.get(json, "ef-cfg_particle-z"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 99999.9),
      },
      "ef-cfg_change-particle-z": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_change-particle-z"),
      },
      "ef-cfg_hide-render": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_hide-render"),
      },
      "ef-cfg_hide-cls": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_hide-cls"),
      },
      "ef-cfg_hide-cfg": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_hide-cfg"),
      },
      "ef-cfg_hide-shd-cls-col": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_hide-shd-cls-col"),
      },
      "ef-cfg_hide-shd-cls-alpha": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_hide-shd-cls-alpha"),
      },
      "ef-cfg_hide-particle-z": {
        type: Boolean,
        value: Struct.get(json, "ef-cfg_hide-particle-z"),
      },

    }),
    components: new Array(Struct, [
      {
        name: "ef-cfg_render",
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
            store: { key: "ef-cfg_hide-render" },
            backgroundColor: VETheme.color.accentShadow
          },
          input: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "ef-cfg_render-shd-bkg",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Background shaders",
            enable: { key: "ef-cfg_use-render-shd-bkg" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-render-shd-bkg" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_render-shd-bkg" },
            enable: { key: "ef-cfg_use-render-shd-bkg" },
            hidden: { key: "ef-cfg_hide-render" },
          },
        },
      },
      {
        name: "ef-cfg_render-shd-gr",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Grid shaders",
            enable: { key: "ef-cfg_use-render-shd-gr" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-render-shd-gr" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_render-shd-gr" },
            enable: { key: "ef-cfg_use-render-shd-gr" },
            hidden: { key: "ef-cfg_hide-render" },
          },
        },
      },
      {
        name: "ef-cfg_render-shd-all",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Combined shaders",
            enable: { key: "ef-cfg_use-render-shd-all" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-render-shd-all" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_render-shd-all" },
            enable: { key: "ef-cfg_use-render-shd-all" },
            hidden: { key: "ef-cfg_hide-render" },
          },
        },
      },
      {
        name: "ef-cfg_render-glt",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Combined glitches",
            enable: { key: "ef-cfg_use-render-glt" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-render-glt" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_render-glt" },
            enable: { key: "ef-cfg_use-render-glt" },
            hidden: { key: "ef-cfg_hide-render" },
          },
        },
      },
      {
        name: "ef-cfg_render-gr-glt",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Grid glitches",
            enable: { key: "ef-cfg_use-render-gr-glt" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-render-gr-glt" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_render-gr-glt" },
            enable: { key: "ef-cfg_use-render-gr-glt" },
            hidden: { key: "ef-cfg_hide-render" },
          },
        },
      },
      {
        name: "ef-cfg_render-bkg-glt",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Background glitches",
            enable: { key: "ef-cfg_use-render-bkg-glt" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-render-bkg-glt" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_render-bkg-glt" },
            enable: { key: "ef-cfg_use-render-bkg-glt" },
            hidden: { key: "ef-cfg_hide-render" },
          },
        },
      },
      {
        name: "ef-cfg_render-part",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Particles",
            enable: { key: "ef-cfg_use-render-part" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-render-part" },
            hidden: { key: "ef-cfg_hide-render" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_render-part" },
            enable: { key: "ef-cfg_use-render-part" },
            hidden: { key: "ef-cfg_hide-render" },
          },
        },
      },
      {
        name: "ef-cfg_cls-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "ef-cfg_hide-render" } },
        },
      },
      {
        name: "ef-cfg_cls",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "ef-cfg_hide-cls" },
            backgroundColor: VETheme.color.accentShadow
          },
          input: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "ef-cfg_cls-shd-bkg",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Background shaders",
            enable: { key: "ef-cfg_cls-shd-bkg" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_cls-shd-bkg" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          input: {
            hidden: { key: "ef-cfg_hide-cls" },
          },
        },
      },
      {
        name: "ef-cfg_cls-shd-gr",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Grid shaders",
            enable: { key: "ef-cfg_cls-shd-gr" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_cls-shd-gr" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          input: {
            hidden: { key: "ef-cfg_hide-cls" },
          },
        },
      },
      {
        name: "ef-cfg_cls-shd-all",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Combined shaders",
            enable: { key: "ef-cfg_cls-shd-all" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_cls-shd-all" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          input: {
            hidden: { key: "ef-cfg_hide-cls" },
          },
        },
      },
      {
        name: "ef-cfg_cls-glt",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Combined glitches",
            enable: { key: "ef-cfg_cls-glt" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_cls-glt" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          input: {
            hidden: { key: "ef-cfg_hide-cls" },
          },
        },
      },
      {
        name: "ef-cfg_cls-gr-glt",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Grid glitches",
            enable: { key: "ef-cfg_cls-gr-glt" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_cls-gr-glt" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          input: {
            hidden: { key: "ef-cfg_hide-cls" },
          },
        },
      },
      {
        name: "ef-cfg_cls-bkg-glt",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Background glitches",
            enable: { key: "ef-cfg_cls-bkg-glt" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_cls-bkg-glt" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          input: {
            hidden: { key: "ef-cfg_hide-cls" },
          },
        },
      },
      {
        name: "ef-cfg_cls-part",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Particles",
            enable: { key: "ef-cfg_cls-part" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_cls-part" },
            hidden: { key: "ef-cfg_hide-cls" },
          },
          input: {
            hidden: { key: "ef-cfg_hide-cls" },
          },
        },
      },
      {
        name: "ef-cfg_cls-frame-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "ef-cfg_hide-cls" } },
        },
      },
      {
        name: "ef-cfg_cfg",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Properties",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "ef-cfg_hide-cfg" },
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      /*
      {
        name: "ef-cfg_cls-frame",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear frame",
            enable: { key: "ef-cfg_use-cls-frame" },
            hidden: { key: "ef-cfg_hide-cfg" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-cls-frame" },
            hidden: { key: "ef-cfg_hide-cfg" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            enable: { key: "ef-cfg_use-cls-frame" },
            store: { key: "ef-cfg_cls-frame" },
            hidden: { key: "ef-cfg_hide-cfg" },
          },
        },
      },
      {
        name: "ef-cfg_cls-frame-col-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear color",
            enable: { key: "ef-cfg_use-cls-frame-col" },
            hidden: { key: "ef-cfg_hide-cfg" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "ef-cfg_hide-shd-cls-col" },
            hidden: { key: "ef-cfg_hide-cfg" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_use-cls-frame-col" },
            hidden: { key: "ef-cfg_hide-cfg" },
          },
        },
      },
      {
        name: "ef-cfg_cls-frame-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          red: {
            label: { 
              text: "Red",
              enable: { key: "ef-cfg_use-cls-frame-col" },
              hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            },
            field: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
              hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            },
            slider: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
              hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            },
          },
          green: {
            label: { 
              text: "Green",
              enable: { key: "ef-cfg_use-cls-frame-col" },
              hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            },
            field: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
              hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            },
            slider: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
              hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            },
          },
          blue: {
            label: { 
              text: "Blue",
              enable: { key: "ef-cfg_use-cls-frame-col" },
              hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            },
            field: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
              hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            },
            slider: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
              hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            },
          },
          hex: { 
            label: { 
              text: "Hex",
              enable: { key: "ef-cfg_use-cls-frame-col" },
              hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            },
            field: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
              hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            },
          },
        },
      },
      {
        name: "ef-cfg_cls-frame-col-spd",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Duration",
            enable: { key: "ef-cfg_use-cls-frame-col" },
            hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
          },  
          field: { 
            store: { key: "ef-cfg_cls-frame-col-spd" },
            enable: { key: "ef-cfg_use-cls-frame-col" },
            hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-cfg_cls-frame-col-spd" },
            enable: { key: "ef-cfg_use-cls-frame-col" },
            hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            factor: -0.01,
          },
          increase: {
            store: { key: "ef-cfg_cls-frame-col-spd" },
            enable: { key: "ef-cfg_use-cls-frame-col" },
            hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            factor: 0.01,
          },
          stick: {
            store: { key: "ef-cfg_cls-frame-col-spd" },
            enable: { key: "ef-cfg_use-cls-frame-col" },
            hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
            factor: 0.01,
          },
          checkbox: {
            hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
          },
        },
      },
      {
        name: "ef-cfg_cls-frame-col-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-col" }
              ]
            },
          },
        },
      },
      {
        name: "ef-cfg_cls-frame-alpha-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear alpha",
            enable: { key: "ef-cfg_use-cls-frame-alpha" },
            hidden: { key: "ef-cfg_hide-cfg" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "ef-cfg_hide-shd-cls-alpha" },
            hidden: { key: "ef-cfg_hide-cfg" },
          },
          input: {
            hidden: { key: "ef-cfg_hide-cfg" },
          },
        },
      },
      {
        name: "ef-cfg_cls-frame-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "ef-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            field: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            decrease: { 
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: { 
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: 0.01,
            },
            stick: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "ef-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "ef-cfg_use-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            field: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            decrease: { 
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha"},
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: { 
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: 0.01,
            },
            stick: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              store: { key: "ef-cfg_change-cls-frame-alpha" },
            },
            title: { 
              text: "Change",
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            field: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            decrease: { 
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: { 
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: 0.001,
            },
            stick: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            title: { 
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            field: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            decrease: { 
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: { 
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: 0.01,
            },
            stick: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            title: { 
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
          },
          duration: {
            label: {
              text: "Duration",
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            field: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            decrease: { 
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: -0.01,
            },
            increase: { 
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: 0.01,
            },
            stick: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
              factor: 0.01,
            },
            checkbox: { 
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
            title: { 
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-shd-cls-alpha" }
                ]
              },
            },
          },
        },
      },
      {
        name: "ef-cfg_cls-frame-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "ef-cfg_hide-cfg" },
                { key: "ef-cfg_hide-shd-cls-alpha" }
              ]
            },
          },
        },
      },
      */
      {
        name: "ef-cfg_particle-z-col-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Particle Z",
            hidden: { key: "ef-cfg_hide-cfg" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "ef-cfg_hide-particle-z" },
            hidden: { key: "ef-cfg_hide-cfg" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            hidden: { key: "ef-cfg_hide-cfg" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "ef-cfg_particle-z",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              enable: { key: "ef-cfg_use-particle-z" },
            },
            field: {
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_use-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
            },
            decrease: { 
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_use-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_use-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              factor: 1.0,
            },
            stick: { 
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_use-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "ef-cfg_use-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "ef-cfg_use-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
            },
            field: {
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
            },
            decrease: { 
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              factor: 1.0,
            },
            stick: { 
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              store: { key: "ef-cfg_change-particle-z" },
            },
            title: { 
              text: "Change",
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
            },
            field: {
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
            },
            decrease: { 
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              factor: -0.01,
            },
            increase: { 
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              factor: 0.01,
            },
            stick: { 
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
            },
            field: {
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
            },
            decrease: { 
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              factor: -0.001,
            },
            increase: { 
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              factor: 0.001,
            },
            stick: { 
              store: { key: "ef-cfg_particle-z" },
              enable: { key: "ef-cfg_change-particle-z" },
              hidden: {
                keys: [
                  { key: "ef-cfg_hide-cfg" },
                  { key: "ef-cfg_hide-particle-z" }
                ]
              },
              factor: 0.001,
            },
          },
        },
      }
    ]),
  }
}