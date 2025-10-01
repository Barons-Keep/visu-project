///@package io.alkapivo.visu.editor.ui.component

//@param {String} name
//@param {?Struct} [config]
function VESpinSelectComponent(name, config = null) {
  var label = { text: "" }
  var previous = { }
  var preview = { }
  var next = { }
  var layout = Struct.get(config, "layout")

  var hidden = Struct.get(config, "hidden")
  if (hidden != null) {
    Struct.set(label, "hidden", hidden)
    Struct.set(previous, "hidden", hidden)
    Struct.set(preview, "hidden", hidden)
    Struct.set(next, "hidden", hidden)
  }
  
  var enable = Struct.get(config, "enable")
  if (enable != null) {
    Struct.set(label, "enable", enable)
    Struct.set(previous, "enable", enable)
    Struct.set(preview, "enable", enable)
    Struct.set(next, "enable", enable)
  }

  var store = Struct.get(config, "store")
  if (store != null) {
    Struct.set(previous, "store", JSON.clone(store))
    Struct.set(preview, "store", JSON.clone(store))
    Struct.set(next, "store", JSON.clone(store))
  }

  preview = Struct.appendRecursive(preview, Struct.get(VEStyles.get("spin-select-label"), "preview"), false)

  return {
    name: name,
    template: VEComponents.get("spin-select"),
    layout: VELayouts.get("spin-select"),
    config: { 
      layout: Struct.appendRecursive({
        type: UILayoutType.VERTICAL
      }, layout, false),
      label: Struct.appendRecursive(label, Struct.get(config, "label"), false),
      previous: Struct.appendRecursive(previous, Struct.get(config, "previous"), false),
      preview: Struct.appendRecursive(preview, Struct.get(config, "preview"), false),
      next: Struct.appendRecursive(next, Struct.get(config, "next"), false),
    },
  }
}
/** Template
VESpinSelectComponent("", {
  hidden: null,
  enable: null,
  store: null,
  layout: null,
  label: {
    text: null,
    font: null,
  }
  previous: null,
  preview: null,
  next: null,
})
*/

