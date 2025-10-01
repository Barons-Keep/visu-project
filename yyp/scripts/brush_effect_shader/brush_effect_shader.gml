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
      VETitleComponent("ef-shd_hide", {
        label: { text: "Properties" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "ef-shd_hide" },
        },
      }),
      VETextInputComponent("sf-shd_template", {
        hidden: { key: "ef-shd_hide" },
        store: { key: "ef-shd_template" },
        value: { text: "Template" },
      }),
      VENumberInputComponent("ef-shd_duration", {
        hidden: { key: "ef-shd_hide" },
        store: { key: "ef-shd_duration" },
        value: {
          text: "Duration",
          factor: 0.01,
          stick: { factor: 0.01 },
        },
        checkbox: { }
      }),
      VENumberInputComponent("ef-shd_fade-in", {
        hidden: { key: "ef-shd_hide" },
        store: { key: "ef-shd_fade-in" },
        value: {
          text: "Fade in",
          factor: 0.01,
          stick: { factor: 0.01 },
        },
        checkbox: { }
      }),
      VENumberInputComponent("ef-shd_fade-out", {
        hidden: { key: "ef-shd_hide" },
        store: { key: "ef-shd_fade-out" },
        value: {
          text: "Fade out",
          factor: 0.01,
          stick: { factor: 0.01 },
        },
        checkbox: { }
      }),
      VENumberInputComponent("ef-shd_alpha", {
        hidden: { key: "ef-shd_hide" },
        store: { key: "ef-shd_alpha" },
        value: {
          text: "Alpha",
          factor: 0.01,
          slider:{
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
          },
        },
      }),
      VELineHComponent("ef-shd_alpha-line-h", {
        hidden: { key: "ef-shd_hide" },
      }),
      VESpinSelectComponent("ef-shd_pipeline", {
        hidden: { key: "ef-shd_hide" },
        store: { key: "ef-shd_pipeline" },
        layout: {
          height: function() { return 32 },
          margin: { top: 4, bottom: 4 },
        },
        label: { text: "Pipeline" },
      }),
      VELineHComponent("ef-shd_pipeline-line-h", {
        hidden: { key: "ef-shd_hide" },
      }),
      VETitleComponent("ef-shd_use-merge-cfg", {
        enable: { key: "ef-shd_use-merge-cfg" },
        label: { text: "Config" },
        input: {
          spriteOn: { name: "visu_texture_checkbox_switch_on" },
          spriteOff: { name: "visu_texture_checkbox_switch_off" },
          store: { key: "ef-shd_use-merge-cfg" },
        },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "ef-shd_hide-merge-cfg" },
        },
      }),
      VETextAreaInputComponent("ef-shd_merge-cfg", {
        store: { key: "ef-shd_merge-cfg" },
        enable: { key: "ef-shd_use-merge-cfg" },
        hidden: { key: "ef-shd_hide-merge-cfg" },
        value: {
          v_grow: true,
          w_min: 570,
          updateCustom: UIItemUtils.textField.getUpdateJSONTextArea(),
        }
      }),
      VELineHComponent("ef-shd_merge-cfg-line-h", {
        backgroundAlpha: 0.0,
        hidden: { key: "ef-shd_hide-merge-cfg" },
        layout: {
          margin: { top: 0, bottom: 0 },
          height: function() { return 0 },
        },
      }),
    ]),
  }
}