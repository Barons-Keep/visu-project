///@package io.alkapivo.visu.editor.ui.component

//@param {String} name
//@param {?Struct} [config]
function VELineHComponent(name, config = null) {
  var image = { }

  var hidden = Struct.get(config, "hidden")
  if (hidden != null) {
    Struct.set(image, "hidden", hidden)
  }

  var backgroundAlpha = Struct.get(config, "backgroundAlpha")
  if (backgroundAlpha != null) {
    Struct.set(image, "backgroundAlpha", backgroundAlpha)
  }

  return {
    name: name,
    template: VEComponents.get("line-h"),
    layout: VELayouts.get("line-h"),
    config: { 
      layout: Struct.appendRecursive({
        type: UILayoutType.VERTICAL
      }, Struct.get(config, "layout"), false),
      image: image,
    },
  }
}
/** Template
VELineHComponent("", {
  hidden: null,
  layout: null,
  backgroundAlpha: null,
})
*/
