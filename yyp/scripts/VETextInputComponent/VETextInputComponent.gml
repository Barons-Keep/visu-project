///@package io.alkapivo.visu.editor.ui.component

//@param {String} name
//@param {?Struct} [config]
function VETextInputComponent(name, config = null) {
  var layout = Struct.get(config, "layout")
  var hidden = Struct.get(config, "hidden")
  var enable = Struct.get(config, "enable")
  var store = Struct.get(config, "store")
  var valueConfig = Struct.get(config, "value")
  var result = {
    name: name,
    template: VEComponents.get("text-field"),
    layout: VELayouts.get("text-field"),
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
      },
    },
  }

  return result
}
/** Template
VETextInputComponent("", {
  hidden: null,
  store: null,
  enable: null,
  layout: null,
  value: {
    text: null,
    font: null,
  },
})
*/
