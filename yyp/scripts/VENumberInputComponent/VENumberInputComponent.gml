///@package io.alkapivo.visu.editor.ui.component

//@param {String} name
//@param {?Struct} [config]
function VENumberInputComponent(name, config = null) {
  var layout = Struct.get(config, "layout")
  var hidden = Struct.get(config, "hidden")
  var enable = Struct.get(config, "enable")
  var store = Struct.get(config, "store")
  var valueConfig = Struct.get(config, "value")
  var slider = Struct.get(valueConfig, "slider")
  var result = {
    name: name,
    template: VEComponents.get(slider != null
      ? "numeric-slider-increase-field"
      : "numeric-input"),
    layout: VELayouts.get(slider != null
      ? "numeric-slider-increase-field"
      : "div"),
    config: { 
      layout: Struct.appendRecursive({
        type: UILayoutType.VERTICAL
      }, layout, false),
      label: { 
        text: Struct.getIfType(valueConfig, "text", String, ""),
        hidden: hidden,
        enable: enable,
      },  
      field: { 
        hidden: hidden,
        enable: enable,
        store: store,
        GMTF_DECIMAL: Struct.getIfType(valueConfig, "GMTF_DECIMAL", Number)
      },
      decrease: {
        hidden: hidden,
        enable: enable,
        store: store,
        factor: -1.0 * abs(Struct.getIfType(valueConfig, "factor", Number, 1.0)),
      },
      increase: {
        hidden: hidden,
        enable: enable,
        store: store,
        factor: 1.0 * abs(Struct.getIfType(valueConfig, "factor", Number, 1.0)),
      },
      stick: slider == null
        ? Struct.appendRecursive({
            hidden: hidden,
            enable: enable,
            store: store,
          }, Struct.get(valueConfig, "stick"), false)
        : null,
      slider: slider != null
        ? Struct.appendRecursive({
            hidden: hidden,
            enable: enable,
            store: store,
          }, slider, false)
        : null,
    },
  }

  var checkboxConfig = slider == null && Struct.get(config, "checkbox")
  if (checkboxConfig != null) {
    var checkbox = { }
    var title = { text: Struct.getIfType(checkboxConfig, "text", String, "") }
    var enableCheckbox = Struct.get(checkboxConfig, "enable"),
    var storeCheckbox = Struct.get(checkboxConfig, "store")

    if (hidden != null) {
      Struct.set(checkbox, "hidden", hidden)
      Struct.set(title, "hidden", hidden)
    }

    if (enableCheckbox != null) {
      Struct.set(checkbox, "enable", enableCheckbox)
      Struct.set(title, "enable", enableCheckbox)
    }

    if (storeCheckbox != null) {
      Struct.set(checkbox, "store", storeCheckbox)
      Struct.set(title, "store", storeCheckbox)
    }

    if (Struct.get(checkboxConfig, "font") != null) {
      Struct.set(title, "font", checkboxConfig.font)
    }

    Struct.set(result.config, "checkbox", checkbox)
    Struct.set(result.config, "title", title)
  }

  return result
}
/** Template
VENumberInputComponent("", {
  hidden: null,
  store: null,
  enable: null,
  layout: null,
  value: {
    text: null,
    font: null,
    factor: null,
    stick: null,
    slider: null,
  },
  checkbox: {
    enable: null,
    store: null,
    text: null,
    font: null,
  }
})
*/
