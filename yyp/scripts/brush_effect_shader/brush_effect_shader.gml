///@package io.alkapivo.visu.editor.service.brush.effect

///@param {Struct} json
///@return {Struct}
function brush_effect_shader(json) {
  return {
    name: "brush_effect_shader",
    store: new Map(String, Struct, {
      "ef-shd_hide": {
        type: Boolean,
        value: Struct.get(json, "ef-shd_hide"),
      },
      "ef-shd_template": {
        type: String,
        value: Struct.get(json, "ef-shd_template"),
        passthrough: UIUtil.passthrough.getCallbackValue(),
        data: {
          callback: Beans.get(BeanVisuController).shaderTemplateExists,
          defaultValue: "shader-default",
        },
      },
      "ef-shd_duration": {
        type: Number,
        value: Struct.get(json, "ef-shd_duration"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 9999.9),
      },
      "ef-shd_fade-in": {
        type: Number,
        value: Struct.get(json, "ef-shd_fade-in"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 9999.9),
      },
      "ef-shd_fade-out": {
        type: Number,
        value: Struct.get(json, "ef-shd_fade-out"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 9999.9),
      },
      "ef-shd_alpha": {
        type: Number,
        value: Struct.get(json, "ef-shd_alpha"),
        passthrough: UIUtil.passthrough.getNormalizedStringNumber(),
      },
      "ef-shd_pipeline": {
        type: String,
        value: Struct.get(json, "ef-shd_pipeline"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: ShaderPipelineType.keys(),
      },
      "ef-shd_use-merge-cfg": {
        type: Boolean,
        value: Struct.get(json, "ef-shd_use-merge-cfg"),
      },
      "ef-shd_hide-merge-cfg": {
        type: Boolean,
        value: Struct.get(json, "ef-shd_hide-merge-cfg"),
      },
      "ef-shd_merge-cfg": {
        type: String,
        value: JSON.stringify(Struct.get(json, "ef-shd_merge-cfg"), { pretty: true }),
        serialize: UIUtil.serialize.getStringStruct(),
        passthrough: UIUtil.passthrough.getStringStruct(),
      },
    }),
    components: new Array(Struct, [
      {
        name: "ef-shd_hide",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Properties",
            //enable: { key: "ef-shd_hide" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "ef-shd_hide" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "ef-shd_template",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            //margin: { top: 2, bottom: 0 },
          },
          label: {
            text: "Template",
            hidden: { key: "ef-shd_hide" },
          },
          field: {
            store: { key: "ef-shd_template" },
            hidden: { key: "ef-shd_hide" },
          },
        },
      },
      {
        name: "ef-shd_duration",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            //margin: { top: 1, bottom: 0 },
          },
          label: { 
            text: "Duration",
            hidden: { key: "ef-shd_hide" },
          },  
          field: { 
            store: { key: "ef-shd_duration" },
            hidden: { key: "ef-shd_hide" },
          },
          decrease: {
            store: { key: "ef-shd_duration" },
            hidden: { key: "ef-shd_hide" },
            factor: -0.01,
          },
          increase: {
            store: { key: "ef-shd_duration" },
            hidden: { key: "ef-shd_hide" },
            factor: 0.01,
          },
          stick: {
            store: { key: "ef-shd_duration" },
            hidden: { key: "ef-shd_hide" },
            factor: 0.01,
          },
          checkbox: {
            hidden: { key: "ef-shd_hide" },
          },
        },
      },
      {
        name: "ef-shd_fade-in",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            //margin: { top: 1, bottom: 0 },
          },
          label: { 
            text: "Fade in",
            hidden: { key: "ef-shd_hide" },
          },  
          field: { 
            store: { key: "ef-shd_fade-in" },
            hidden: { key: "ef-shd_hide" },
          },
          decrease: {
            store: { key: "ef-shd_fade-in" },
            hidden: { key: "ef-shd_hide" },
            factor: -0.01,
          },
          increase: {
            store: { key: "ef-shd_fade-in" },
            hidden: { key: "ef-shd_hide" },
            factor: 0.01,
          },
          stick: {
            store: { key: "ef-shd_fade-in" },
            hidden: { key: "ef-shd_hide" },
            factor: 0.01,
          },
          checkbox: {
            hidden: { key: "ef-shd_hide" },
          },
        },
      },
      {
        name: "ef-shd_fade-out",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            //margin: { top: 1, bottom: 0 },
          },
          label: { 
            text: "Fade out",
            hidden: { key: "ef-shd_hide" },
          },  
          field: { 
            store: { key: "ef-shd_fade-out" },
            hidden: { key: "ef-shd_hide" },
          },
          decrease: {
            store: { key: "ef-shd_fade-out" },
            hidden: { key: "ef-shd_hide" },
            factor: -0.01,
          },
          increase: {
            store: { key: "ef-shd_fade-out" },
            hidden: { key: "ef-shd_hide" },
            factor: 0.01,
          },
          stick: {
            store: { key: "ef-shd_fade-out" },
            hidden: { key: "ef-shd_hide" },
            factor: 0.01,
          },
          checkbox: {
            hidden: { key: "ef-shd_hide" },
          },
        },
      },
      {
        name: "ef-shd_alpha",  
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            //margin: { top: 2, bottom: 2 },
          },
          label: { 
            text: "Alpha",
            hidden: { key: "ef-shd_hide" },
          },
          field: { 
            store: { key: "ef-shd_alpha" },
            hidden: { key: "ef-shd_hide" },
          },
          slider:{
            store: { key: "ef-shd_alpha" },
            hidden: { key: "ef-shd_hide" },
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
          },
          decrease: {
            store: { key: "ef-shd_alpha" },
            hidden: { key: "ef-shd_hide" },
            factor: -0.01,
          },
          increase: {
            store: { key: "ef-shd_alpha" },
            hidden: { key: "ef-shd_hide" },
            factor: 0.01,
          },
        },
      },
      {
        name: "ef-shd_alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "ef-shd_hide" } },
        },
      },
      {
        name: "ef-shd_pipeline",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            height: function() { return 32 },
            margin: { top: 4, bottom: 4 },
          },
          label: {
            text: "Pipeline",
            hidden: { key: "ef-shd_hide" },
          },
          previous: {
            store: { key: "ef-shd_pipeline" },
            hidden: { key: "ef-shd_hide" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "ef-shd_pipeline" },
            hidden: { key: "ef-shd_hide" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: {
            store: { key: "ef-shd_pipeline" },
            hidden: { key: "ef-shd_hide" },
          },
        },
      },
      {
        name: "ef-shd_pipeline-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "ef-shd_hide" } },
        },
      },
      {
        name: "ef-shd_use-merge-cfg",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Config",
            enable: { key: "ef-shd_use-merge-cfg" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "ef-shd_hide-merge-cfg" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-shd_use-merge-cfg" },
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "ef-shd_merge-cfg",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "ef-shd_merge-cfg" },
            enable: { key: "ef-shd_use-merge-cfg" },
            hidden: { key: "ef-shd_hide-merge-cfg" },
            updateCustom: UIItemUtils.textField.getUpdateJSONTextArea(),
          },
        },
      },
      {
        name: "ef-shd_merge-cfg-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: {
            type: UILayoutType.VERTICAL,
            margin: { top: 0, bottom: 0 },
            height: function() { return 0 },
          },
          image: { 
            hidden: { key: "ef-shd_hide-merge-cfg" },
            backgroundAlpha: 0.0,
          },
        },
      },
    ]),
  }
}