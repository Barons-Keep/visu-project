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
        data: new Vector2(0.0, SHROOM_SPAWN_AMOUNT),
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
      VETitleComponent("ef-glt_fade_out-title", {
        enable: { key: "ef-glt_use-fade-out" },
        label: { text: "Properties" },
        input: {
          spriteOn: { name: "visu_texture_checkbox_switch_on" },
          spriteOff: { name: "visu_texture_checkbox_switch_off" },
          store: { key: "ef-glt_use-fade-out" },
        },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "ef-glt_hide" },
        },
      }),
      VENumberInputComponent("ef-glt_fade-out", {
        hidden: { key: "ef-glt_hide" },
        store: { key: "ef-glt_fade-out" },
        enable: { key: "ef-glt_use-fade-out" },
        value: {
          text: "Factor",
          factor: 0.001,
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.001 / 1.0,
          },
        },
      }),
      VESpinSelectComponent("ef-glt_glitch", {
        hidden: { key: "ef-glt_hide" },
        store: { key: "ef-glt_glitch" },
        layout: {
          height: function() { return 32 },
          margin: { top: 4, bottom: 4 },
        },
        label: { text: "Glitch" },
      }),
      VELineHComponent("ef-glt_use-config_line-h", {
        hidden: { key: "ef-glt_hide" },
      }),
      VETitleComponent("ef-glt_cfg", {
        enable: { key: "ef-glt_use-config" },
        label: { text: "Config" },
        input: {
          spriteOn: { name: "visu_texture_checkbox_switch_on" },
          spriteOff: { name: "visu_texture_checkbox_switch_off" },
          store: { key: "ef-glt_use-config" },
        },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "ef-glt_hide-cfg" },
        },
      }),
      VETitleComponent("ef-glt_line-title", {
        hidden: { key: "ef-glt_hide-cfg" },
        enable: { key: "ef-glt_use-config" },
        label: { text: "Line" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "ef-glt_hide-line" },
        },
      }),
      VENumberInputComponent("ef-glt_line-spd", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-line" }
          ]
        },
        store: { key: "ef-glt_line-spd" },
        enable: { key: "ef-glt_use-config" },
        value: {
          text: "Speed",
          factor: 0.01,
          slider: { 
            minValue: 0.0,
            maxValue: 0.5,
            snapValue: 0.01 / 0.5,
          },
        },
      }),
      VENumberInputComponent("ef-glt_line-shift", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-line" }
          ]
        },
        store: { key: "ef-glt_line-shift" },
        enable: { key: "ef-glt_use-config" },
        value: {
          text: "Shift",
          factor: 0.001,
          slider: { 
            minValue: 0.0,
            maxValue: 0.05,
            snapValue: 0.001 / 0.05,
          },
        },
      }),
      VENumberInputComponent("ef-glt_line-res", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-line" }
          ]
        },
        store: { key: "ef-glt_line-res" },
        enable: { key: "ef-glt_use-config" },
        value: {
          text: "Resolution",
          factor: 0.01,
          slider: { 
            minValue: 0.0,
            maxValue: 3.0,
            snapValue: 0.01 / 3.0,
          },
        },
      }),
      VENumberInputComponent("ef-glt_line-v-shift", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-line" }
          ]
        },
        store: { key: "ef-glt_line-v-shift" },
        enable: { key: "ef-glt_use-config" },
        value: {
          text: "V shift",
          factor: 0.01,
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
          },
        },
      }),
      VENumberInputComponent("ef-glt_line-drift", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-line" }
          ]
        },
        store: { key: "ef-glt_line-drift" },
        enable: { key: "ef-glt_use-config" },
        layout: { margin: { bottom: 4.0 } },
        value: {
          text: "Drift",
          factor: 0.01,
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
          },
        },
      }),
      VELineHComponent("ef-glt_jumb-title_line-h", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-line" }
          ]
        },
      }),
      VETitleComponent("ef-glt_jumb-title", {
        hidden: { key: "ef-glt_hide-cfg" },
        enable: { key: "ef-glt_use-config" },
        label: { text: "Jumble" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "ef-glt_hide-jumb" },
        },
      }),
      VENumberInputComponent("ef-glt_jumb-spd", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-jumb" }
          ]
        },
        store: { key: "ef-glt_jumb-spd" },
        enable: { key: "ef-glt_use-config" },
        value: {
          text: "Speed",
          factor: 0.1,
          slider: { 
            minValue: 0.0,
            maxValue: SHROOM_SPAWN_AMOUNT,
            snapValue: 0.1 / SHROOM_SPAWN_AMOUNT,
          },
        },
      }),
      VENumberInputComponent("ef-glt_jumb-shift", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-jumb" }
          ]
        },
        store: { key: "ef-glt_jumb-shift" },
        enable: { key: "ef-glt_use-config" },
        value: {
          text: "Shift",
          factor: 0.01,
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
          },
        },
      }),
      VENumberInputComponent("ef-glt_jumb-res", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-jumb" }
          ]
        },
        store: { key: "ef-glt_jumb-res" },
        enable: { key: "ef-glt_use-config" },
        value: {
          text: "Resolution",
          factor: 0.01,
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
          },
        },
      }),
      VENumberInputComponent("ef-glt_jumb-chaos", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-jumb" }
          ]
        },
        store: { key: "ef-glt_jumb-chaos" },
        enable: { key: "ef-glt_use-config" },
        layout: { margin: { bottom: 4.0 } },
        value: {
          text: "Chaos",
          factor: 0.01,
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
          },
        },
      }),
      VELineHComponent("ef-glt_shd-title_line-h", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-jumb" }
          ]
        },
      }),
      VETitleComponent("ef-glt_shd-title", {
        hidden: { key: "ef-glt_hide-cfg" },
        enable: { key: "ef-glt_use-config" },
        label: { text: "Shader" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "ef-glt_hide-shd" },
        },
      }),
      VENumberInputComponent("ef-glt_shd-dispersion", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-shd" }
          ]
        },
        store: { key: "ef-glt_shd-dispersion" },
        enable: { key: "ef-glt_use-config" },
        value: {
          text: "Dispersion",
          factor: 0.001,
          slider: { 
            minValue: 0.0,
            maxValue: 0.5,
            snapValue: 0.001 / 0.5,
          },
        },
      }),
      VENumberInputComponent("ef-glt_shd-ch-shift", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-shd" }
          ]
        },
        store: { key: "ef-glt_shd-ch-shift" },
        enable: { key: "ef-glt_use-config" },
        value: {
          text: "Ch. shift",
          factor: 0.001,
          slider: { 
            minValue: 0.0,
            maxValue: 0.05,
            snapValue: 0.0001 / 0.05,
          },
        },
      }),
      VENumberInputComponent("ef-glt_shd-noise", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-shd" }
          ]
        },
        store: { key: "ef-glt_shd-noise" },
        enable: { key: "ef-glt_use-config" },
        value: {
          text: "Noise level",
          factor: 0.01,
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
          },
        },
      }),
      VENumberInputComponent("ef-glt_shd-shakiness", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-shd" }
          ]
        },
        store: { key: "ef-glt_shd-shakiness" },
        enable: { key: "ef-glt_use-config" },
        value: {
          text: "Shakiness",
          factor: 0.1,
          slider: { 
            minValue: 0.0,
            maxValue: 10.0,
            snapValue: 0.1 / 10.0,
          },
        },
      }),
      VENumberInputComponent("ef-glt_shd-rng-seed", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-shd" }
          ]
        },
        store: { key: "ef-glt_shd-rng-seed" },
        enable: { key: "ef-glt_use-config" },
        value: {
          text: "RNG seed",
          factor: 0.01,
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
          },
        },
      }),
      VENumberInputComponent("ef-glt_shd-intensity", {
        hidden: {
          keys: [
            { key: "ef-glt_hide-cfg" },
            { key: "ef-glt_hide-shd" }
          ]
        },
        store: { key: "ef-glt_shd-intensity" },
        enable: { key: "ef-glt_use-config" },
        layout: { margin: { bottom: 4.0 } },
        value: {
          text: "Intensity",
          factor: 0.01,
          slider: { 
            minValue: 0.0,
            maxValue: 5.0,
            snapValue: 0.01 / 5.0,
          },
        },
      }),
    ]),
  }
}