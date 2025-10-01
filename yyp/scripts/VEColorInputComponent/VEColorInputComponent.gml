///@package io.alkapivo.visu.editor.ui.component

//@param {String} name
//@param {?Struct} [config]
function VEColorInputComponent(name, config = null) {
  var layout = Struct.get(config, "layout")
  var hidden = Struct.get(config, "hidden")
  var enable = Struct.get(config, "enable")
  var store = Struct.get(config, "store")
  return {
    name: name,
    template: VEComponents.get("color-picker"),
    layout: VELayouts.get("color-picker"),
    config: { 
      layout: Struct.appendRecursive({
        type: UILayoutType.VERTICAL
      }, layout, false),
      red: {
        label: {
          text: "Red",
          enable: enable,
          hidden: hidden,
        },
        field: {
          hidden: hidden,
          enable: enable,
          store: store,
        },
        slider: {
          hidden: hidden,
          enable: enable,
          store: store,
        },
      },
      green: {
        label: {
          text: "Green",
          enable: enable,
          hidden: hidden,
        },
        field: {
          hidden: hidden,
          enable: enable,
          store: store,
        },
        slider: {
          hidden: hidden,
          enable: enable,
          store: store,
        },
      },
      blue: {
        label: {
          text: "Blue",
          enable: enable,
          hidden: hidden,
        },
        field: {
          hidden: hidden,
          enable: enable,
          store: store,
        },
        slider: {
          hidden: hidden,
          enable: enable,
          store: store,
        },
      },
      hex: { 
        label: {
          text: "Hex",
          hidden: hidden,
          enable: enable,
        },
        field: {
          hidden: hidden,
          enable: enable,
          store: store,
        },
      },
    },
  }
}
/** Template
VEColorInputComponent("", {
  hidden: null,
  store: null,
  enable: null,
  layout: null,
})
*/