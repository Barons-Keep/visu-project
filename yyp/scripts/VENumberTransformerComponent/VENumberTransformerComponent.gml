///@package io.alkapivo.visu.editor.ui.component

//@param {String} name
//@param {?Struct} [config]
function VENumberTransformerComponent(name, config = null) {
  var enableConfig = Struct.get(config, "enable")
  var storeConfig = Struct.get(config, "store"),
  var valueConfig = Struct.get(config, "value")
  var targetConfig = Struct.get(config, "target")
  var durationConfig = Struct.get(config, "duration")
  var hidden = Struct.get(config, "hidden")
  var enable = {
    value: Struct.get(enableConfig, "value"),
    target: Struct.get(enableConfig, "target"),
    use: Struct.get(enableConfig, "use"),
    change: Struct.get(enableConfig, "change"),
  }
  var store = {
    value: Struct.get(storeConfig, "value"),
    use: Struct.get(storeConfig, "use"),
    change: Struct.get(storeConfig, "change"),
  }
  
  var value = {
    label: {
      text: Struct.getIfType(valueConfig, "text", String, "Value"),
      hidden: hidden,
      enable: enable.value,
    },
    field: {
      hidden: hidden,
      enable: enable.value,
      store: store.value,
    },
    decrease: {
      hidden: hidden,
      enable: enable.value,
      store: store.value,
      factor: -1.0 * abs(Struct.getIfType(valueConfig, "factor", Number, 1.0)),
    },
    increase: {
      hidden: hidden,
      enable: enable.value,
      store: store.value,
      factor: abs(Struct.getIfType(valueConfig, "factor", Number, 1.0)),
    },
    stick: Struct.appendRecursive({
      hidden: hidden,
      enable: enable.value,
      store: store.value,
    }, Struct.get(valueConfig, "stick"), false),
    checkbox: {
      hidden: hidden,
      enable: enable.use,
      store: store.use,
      spriteOn: { name: "visu_texture_checkbox_on" },
      spriteOff: { name: "visu_texture_checkbox_off" },
    },
    title: {
      hidden: hidden,
      enable: enable.use,
      store: store.use,
      text: Struct.getIfType(Struct.get(config, "use"), "text", String, "Override"),
    },
  }

  var target = {
    label: {
      text: Struct.getIfType(targetConfig, "text", String, "Target"),
      hidden: hidden,
      enable: enable.target,
    },
    field: {
      hidden: hidden,
      enable: enable.target,
      store: store.value,
    },
    decrease: {
      hidden: hidden,
      enable: enable.target,
      store: store.value,
      factor: -1.0 * abs(Struct.getIfType(targetConfig, "factor", Number, value.decrease.factor)),
    },
    increase: {
      hidden: hidden,
      enable: enable.target,
      store: store.value,
      factor: abs(Struct.getIfType(targetConfig, "factor", Number, value.increase.factor)),
    },
    stick: Struct.appendRecursiveUnique(Struct.appendRecursive({
      hidden: hidden,
      enable: enable.target,
      store: store.value,
    }, Struct.get(targetConfig, "stick"), false), Struct.get(valueConfig, "stick"), false),
    checkbox: {
      hidden: hidden,
      enable: enable.change,
      store: store.change,
      spriteOn: { name: "visu_texture_checkbox_on" },
      spriteOff: { name: "visu_texture_checkbox_off" },
    },
    title: {
      hidden: hidden,
      enable: enable.change,
      store: store.change,
      text: Struct.getIfType(Struct.get(config, "change"), "text", String, "Transform"),
    },
  }

  var duration = {
    label: {
      text: Struct.getIfType(durationConfig, "text", String, "Duration"),
      hidden: hidden,
      enable: enable.target,
    },
    field: {
      hidden: hidden,
      enable: enable.target,
      store: store.value,
    },
    decrease: {
      hidden: hidden,
      enable: enable.target,
      store: store.value,
      factor: -1.0 * abs(Struct.getIfType(durationConfig, "factor", Number, 1.0)),
    },
    increase: {
      hidden: hidden,
      enable: enable.target,
      store: store.value,
      factor: abs(Struct.getIfType(durationConfig, "factor", Number, 1.0)),
    },
    stick: Struct.appendRecursive({
      hidden: hidden,
      enable: enable.target,
      store: store.value,
    }, Struct.get(durationConfig, "stick"), false),
  }

  var ease = {
    label: {
      hidden: hidden,
      enable: enable.target,
    },
    previous: {
      hidden: hidden,
      enable: enable.target,
      store: store.value,
    },
    preview: {
      hidden: hidden,
      enable: enable.target,
      store: store.value,
    },
    next: {
      hidden: hidden,
      enable: enable.target,
      store: store.value,
    },
  }
  
  if (Struct.get(valueConfig, "font") != null) {
    Struct.set(value.label, "font", valueConfig.font)
  }
  
  if (Struct.get(targetConfig, "font") != null) {
    Struct.set(target.label, "font", targetConfig.font)
  }

  if (Struct.get(durationConfig, "font") != null) {
    Struct.set(duration.label, "font", durationConfig.font)
  }

  return {
    name: name,
    template: VEComponents.get("number-transformer"),
    layout: VELayouts.get("number-transformer-increase-checkbox"),
    config: { 
      layout: { type: UILayoutType.VERTICAL },
      value: value,
      target: target,
      duration: duration,
      ease: ease,
    },
  }
}
/** Template
VENumberTransformerComponent("", {
  hidden: null,
  store: {
    value: null,
    use: null,
    change: null,
  },
  enable: {
    value: null,
    target: null,
    use: null,
    change: null,
  },  
  value: {
    text: null,
    font: null,
    factor: null,
    stick: null,
  },
  use: {
    text: null,
    font: null,
  },
  target: {
    text: null,
    font: null,
    factor: null,
    stick: null,
  },
  change: {
    text: null,
    font: null,
  },
  duration: {
    text: null,
    font: null,
    factor: null,
    stick: null,
  },
})
*/
