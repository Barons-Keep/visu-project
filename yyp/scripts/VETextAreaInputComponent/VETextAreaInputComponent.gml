///@package io.alkapivo.visu.editor.ui.component

//@param {String} name
//@param {?Struct} [config]
function VETextAreaInputComponent(name, config = null) {
  var layout = Struct.get(config, "layout")
  var hidden = Struct.get(config, "hidden")
  var enable = Struct.get(config, "enable")
  var store = Struct.get(config, "store")
  var valueConfig = Struct.get(config, "value")
  var result = {
    name: name,
    template: VEComponents.get("text-area"),
    layout: VELayouts.get("text-area"),
    config: { 
      layout: Struct.appendRecursive({
        type: UILayoutType.VERTICAL
      }, layout, false),
      field: {
        v_grow: Struct.getIfType(valueConfig, "v_grow", Boolean, true),
        w_min: Struct.getIfType(valueConfig, "w_min", Number, 570),
        hidden: hidden,
        enable: enable,
        store: store,
        updateCustom: Struct.get(valueConfig, "updateCustom"),
      },
    },
  }

  return result
}
/** Template
VETextAreaInputComponent("", {
  hidden: null,
  store: null,
  enable: null,
  layout: null,
  value: {
    v_grow: null,
    w_min: null,
    updateCustom: null,
    text: null,
    font: null,
  },
})
*/
