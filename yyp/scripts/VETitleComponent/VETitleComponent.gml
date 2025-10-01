///@package io.alkapivo.visu.editor.ui.component

//@param {String} name
//@param {?Struct} [config]
function VETitleComponent(name, config = null) {
  var label = Struct.get(config, "label")
  var input = Struct.get(config, "input")
  var checkbox = Struct.get(config, "checkbox")

  var hidden = Struct.get(config, "hidden")
  if (hidden != null) {
    Struct.set(label, "hidden", hidden)
    Struct.set(input, "hidden", hidden)
    Struct.set(checkbox, "hidden", hidden)
  }
  
  var enable = Struct.get(config, "enable")
  if (enable != null) {
    Struct.set(label, "enable", enable)
  }

  var background = Struct.get(config, "background")
  if (background != null) {
    Struct.set(label, "backgroundColor", background)
    Struct.set(input, "backgroundColor", background)
    Struct.set(checkbox, "backgroundColor", background)
  }

  return {
    name: name,
    template: VEComponents.get("property"),
    layout: VELayouts.get("property"),
    config: { 
      layout: { type: UILayoutType.VERTICAL },
      label: label,
      input: input,
      checkbox: checkbox,
    },
  }
}
/** Template
VETitleComponent("", {
  hidden: null,
  enable: null,
  background: null,
  label: {
    text: null,
    font: null,
    updateCustom: null,
    preRender: null,
  },
  input: {
    spriteOn: null,
    spriteOff: null,
    store: null,
  },
  checkbox: {
    spriteOn: null,
    spriteOff: null,
    store: null,
  },
})
*/
