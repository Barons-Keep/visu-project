///@package io.alkapivo.visu.editor.service.brush.effect

///@param {?Struct} [json]
///@return {Struct}
function brush_effect_glitch(json = null) {
  return {
    name: "brush_effect_glitch",
    store: new Map(String, Struct, {
      "ef-glt_hide": {
        type: Boolean,
        value: Struct.get(json, "ef-glt_hide"),
      },
      "ef-glt_use-fade-out": {
        type: Boolean,
        value: Struct.get(json, "ef-glt_use-fade-out"),
      },
      "ef-glt_fade-out": {
        type: Number,
        value: Struct.get(json, "ef-glt_fade-out"),
        passthrough: UIUtil.passthrough.getNormalizedStringNumber(),
      },
      "ef-glt_glitch": {
        type: String,
        value: Struct.get(json, "ef-glt_glitch"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: GlitchType.keys(),
      },
      "ef-glt_use-config": {
        type: Boolean,
        value: Struct.get(json, "ef-glt_use-config"),
      },
      "ef-glt_hide-cfg": {
        type: Boolean,
        value: Struct.get(json, "ef-glt_hide-cfg"),
      },
      "ef-glt_hide-line": {
        type: Boolean,
        value: Struct.get(json, "ef-glt_hide-line"),
      },
      "ef-glt_line-spd": {
        type: Number,
        value: Struct.get(json, "ef-glt_line-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 0.5),
      },
      "ef-glt_line-shift": {
        type: Number,
        value: Struct.get(json, "ef-glt_line-shift"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 0.05),
      },
      "ef-glt_line-res": {
        type: Number,
        value: Struct.get(json, "ef-glt_line-res"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 3.0),
      },
      "ef-glt_line-v-shift": {
        type: Number,
        value: Struct.get(json, "ef-glt_line-v-shift"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 1.0),
      },
      "ef-glt_line-drift": {
        type: Number,
        value: Struct.get(json, "ef-glt_line-drift"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 1.0),
      },
      "ef-glt_hide-jumb": {
        type: Boolean,
        value: Struct.get(json, "ef-glt_hide-jumb"),
      },
      "ef-glt_jumb-spd": {
        type: Number,
        value: Struct.get(json, "ef-glt_jumb-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 25.0),
      },
      "ef-glt_jumb-shift": {
        type: Number,
        value: Struct.get(json, "ef-glt_jumb-shift"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 1.0),
      },
      "ef-glt_jumb-res": {
        type: Number,
        value: Struct.get(json, "ef-glt_jumb-res"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 1.0),
      },
      "ef-glt_jumb-chaos": {
        type: Number,
        value: Struct.get(json, "ef-glt_jumb-chaos"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 1.0),
      },
      "ef-glt_hide-shd": {
        type: Boolean,
        value: Struct.get(json, "ef-glt_hide-shd"),
      },
      "ef-glt_shd-dispersion": {
        type: Number,
        value: Struct.get(json, "ef-glt_shd-dispersion"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 0.5),
      },
      "ef-glt_shd-ch-shift": {
        type: Number,
        value: Struct.get(json, "ef-glt_shd-ch-shift"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 0.05),
      },
      "ef-glt_shd-noise": {
        type: Number,
        value: Struct.get(json, "ef-glt_shd-noise"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 1.0),
      },
      "ef-glt_shd-shakiness": {
        type: Number,
        value: Struct.get(json, "ef-glt_shd-shakiness"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 10.0),
      },
      "ef-glt_shd-rng-seed": {
        type: Number,
        value: Struct.get(json, "ef-glt_shd-rng-seed"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 1.0),
      },
      "ef-glt_shd-intensity": {
        type: Number,
        value: Struct.get(json, "ef-glt_shd-intensity"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 5.0),
      },  
    }),
    components: new Array(Struct, [
      {
        name: "ef-glt_fade_out-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Properties",
            //color: VETheme.color.textShadow,
            enable: { key: "ef-glt_use-fade-out" },
            //backgroundColor: VETheme.color.side,
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "ef-glt_hide" },
            //backgroundColor: VETheme.color.side,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-glt_use-fade-out" },
            //backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "ef-glt_fade-out",  
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            //margin: { top: 4.0 },
          },
          label: { 
            text: "Factor",
            enable: { key: "ef-glt_use-fade-out" },
            hidden: { key: "ef-glt_hide" },
          },
          field: { 
            enable: { key: "ef-glt_use-fade-out" },
            store: { key: "ef-glt_fade-out" },
            hidden: { key: "ef-glt_hide" },
          },
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.001 / 1.0,
            store: { key: "ef-glt_fade-out" },
            enable: { key: "ef-glt_use-fade-out" },
            hidden: { key: "ef-glt_hide" },
          },
          decrease: {
            factor: -0.001,
            store: { key: "ef-glt_fade-out" },
            enable: { key: "ef-glt_use-fade-out" },
            hidden: { key: "ef-glt_hide" },
          },
          increase: {
            factor: 0.001,
            store: { key: "ef-glt_fade-out" },
            enable: { key: "ef-glt_use-fade-out" },
            hidden: { key: "ef-glt_hide" },
          },
        },
      },
            {
        name: "ef-glt_glitch",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            height: function() { return 32 },
            margin: { top: 4, bottom: 4 },
          },
          label: {
            text: "Glitch",
            hidden: { key: "ef-glt_hide" },
          },
          previous: {
            store: { key: "ef-glt_glitch" },
            hidden: { key: "ef-glt_hide" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "ef-glt_glitch" },
            hidden: { key: "ef-glt_hide" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: {
            store: { key: "ef-glt_glitch" },
            hidden: { key: "ef-glt_hide" },
          },
        },
      },
      /*
      {
        name: "ef-glt_fade-out-slider",  
        template: VEComponents.get("numeric-slider"),
        layout: VELayouts.get("numeric-slider"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Factor",
            font: "font_inter_10_bold",
            color: VETheme.color.textShadow,
            offset: { y: 14 },
            //enable: { key: "ef-glt_use-fade-out" },
          },
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.001 / 1.0,
            store: { key: "ef-glt_fade-out" },
            enable: { key: "ef-glt_use-fade-out" },
          },
        },
      },
      {
        name: "ef-glt_fade-out",
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "" },
          field: { 
            store: { key: "ef-glt_fade-out"
          },
            enable: { key: "ef-glt_use-fade-out" },
          },
          increase: {
            factor: 0.001,
            store: { key: "ef-glt_fade-out" },
            enable: { key: "ef-glt_use-fade-out" },
          },
          decrease: {
            factor: -0.001,
            store: { key: "ef-glt_fade-out" },
            enable: { key: "ef-glt_use-fade-out" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-glt_use-fade-out" },
          },
          title: { 
            text: "Enable",
            enable: { key: "ef-glt_use-fade-out" },
          },
        },
      },
      */
      {
        name: "ef-glt_use-config_line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "ef-glt_hide" } },
        },
      },
      {
        name: "ef-glt_cfg",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Config",
            backgroundColor: VETheme.color.accentShadow,
            enable: { key: "ef-glt_use-config" },
          },
          checkbox: {
            backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "ef-glt_hide-cfg" },
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-glt_use-config" },
          },
        },
      },
      {
        name: "ef-glt_line-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Line",
            //color: VETheme.color.textShadow,
            enable: { key: "ef-glt_use-config" },
            //backgroundColor: VETheme.color.side,
            hidden: { key: "ef-glt_hide-cfg" },
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "ef-glt_hide-line" },
            hidden: { key: "ef-glt_hide-cfg" },
            //backgroundColor: VETheme.color.side,
          },
          input: {
            hidden: { key: "ef-glt_hide-cfg" },
            //backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "ef-glt_line-spd",  
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            //margin: { top: 4.0 },
          },
          label: { 
            text: "Speed",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_line-spd" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          slider: { 
            minValue: 0.0,
            maxValue: 0.5,
            snapValue: 0.01 / 0.5,
            store: { key: "ef-glt_line-spd" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_line-spd" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_line-spd" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
        },
      },
      {
        name: "ef-glt_line-shift",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: { 
            text: "Shift",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_line-shift" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 0.05,
            snapValue: 0.001 / 0.05,
            store: { key: "ef-glt_line-shift" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_line-shift" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.001,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_line-shift" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.001,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_line-res",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: { 
            text: "Resolution",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_line-res" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 3.0,
            snapValue: 0.01 / 3.0,
            store: { key: "ef-glt_line-res" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_line-res" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
            factor: -0.01,
          },
          increase: {
            store: { key: "ef-glt_line-res" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_line-v-shift",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "V shift",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_line-v-shift" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
            store: { key: "ef-glt_line-v-shift" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_line-v-shift" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_line-v-shift" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_line-drift",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: {
            type: UILayoutType.VERTICAL,
            margin: { bottom: 4.0 },
          },
          label: {
            text: "Drift",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_line-drift" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
            store: { key: "ef-glt_line-drift" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_line-drift" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_line-drift" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_jumb-title_line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-line" }
              ]
            },
          },
        },
      },
      {
        name: "ef-glt_jumb-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Jumble",
            //color: VETheme.color.textShadow,
            enable: { key: "ef-glt_use-config" },
            //backgroundColor: VETheme.color.side,
            hidden: { key: "ef-glt_hide-cfg" },
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "ef-glt_hide-jumb" },
            //backgroundColor: VETheme.color.side,
            hidden: { key: "ef-glt_hide-cfg" },
          },
          input: {
            hidden: { key: "ef-glt_hide-cfg" },
            //backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "ef-glt_jumb-spd",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: {
            type: UILayoutType.VERTICAL,
            //margin: { top: 4.0 },
          },
          label: {
            text: "Speed",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_jumb-spd" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 25.0,
            snapValue: 0.1 / 25.0,
            store: { key: "ef-glt_jumb-spd" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_jumb-spd" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.1,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_jumb-spd" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.1,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_jumb-shift",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Shift",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_jumb-shift" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
            store: { key: "ef-glt_jumb-shift" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_jumb-shift" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_jumb-shift" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_jumb-res",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: { 
            text: "Resolution",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_jumb-res" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
            store: { key: "ef-glt_jumb-res" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_jumb-res" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_jumb-res" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_jumb-chaos",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: {
            type: UILayoutType.VERTICAL,
            margin: { bottom: 4.0 },
          },
          label: {
            text: "Chaos",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_jumb-chaos" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
            store: { key: "ef-glt_jumb-chaos" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_jumb-chaos" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_jumb-chaos" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_shd-title_line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-jumb" }
              ]
            },
          },
        },
      },
      {
        name: "ef-glt_shd-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Shader",
            //color: VETheme.color.textShadow,
            enable: { key: "ef-glt_use-config" },
            //backgroundColor: VETheme.color.side,
            hidden: { key: "ef-glt_hide-cfg" },
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "ef-glt_hide-shd" },
            hidden: { key: "ef-glt_hide-cfg" },
            //backgroundColor: VETheme.color.side,
          },
          input: {
            hidden: { key: "ef-glt_hide-cfg" },
            //backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "ef-glt_shd-dispersion",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: {
            type: UILayoutType.VERTICAL,
            //margin: { top: 4.0 },
          },
          label: {
            text: "Dispersion",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_shd-dispersion" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 0.5,
            snapValue: 0.001 / 0.5,
            store: { key: "ef-glt_shd-dispersion" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_shd-dispersion" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.001,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_shd-dispersion" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.001,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_shd-ch-shift",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Ch. shift",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_shd-ch-shift" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 0.05,
            snapValue: 0.0001 / 0.05,
            store: { key: "ef-glt_shd-ch-shift" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_shd-ch-shift" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.001,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_shd-ch-shift" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.001,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_shd-noise",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Noise level",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_shd-noise" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
            store: { key: "ef-glt_shd-noise" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_shd-noise" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_shd-noise" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_shd-shakiness",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Shakiness",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_shd-shakiness" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 10.0,
            snapValue: 0.1 / 10.0,
            store: { key: "ef-glt_shd-shakiness" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_shd-shakiness" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.1,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_shd-shakiness" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.1,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_shd-rng-seed",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "RNG seed",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          field: { 
            enable: { key: "ef-glt_use-config" },
            store: { key: "ef-glt_shd-rng-seed" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
            store: { key: "ef-glt_shd-rng-seed" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_shd-rng-seed" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_shd-rng-seed" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
        }
      },
      {
        name: "ef-glt_shd-intensity",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: {
          layout: {
            type: UILayoutType.VERTICAL,
            margin: { bottom: 4.0 },
          },
          label: {
            text: "Intensity",
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          field: { 
            store: { key: "ef-glt_shd-intensity" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 5.0,
            snapValue: 0.01 / 5.0,
            store: { key: "ef-glt_shd-intensity" },
            enable: { key: "ef-glt_use-config" },
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          decrease: {
            store: { key: "ef-glt_shd-intensity" },
            enable: { key: "ef-glt_use-config" },
            factor: -0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
          increase: {
            store: { key: "ef-glt_shd-intensity" },
            enable: { key: "ef-glt_use-config" },
            factor: 0.01,
            hidden: {
              keys: [
                { key: "ef-glt_hide-cfg" },
                { key: "ef-glt_hide-shd" }
              ]
            },
          },
        }
      },
    ]),
  }
}