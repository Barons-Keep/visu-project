///@package io.alkapivo.visu.editor.api.template

///@param {Struct} json
///@return {Struct}
function template_subtitle(json = null) {
  var template = {
    name: Assert.isType(json.name, String),
    store: new Map(String, Struct, {
      "lines": {
        type: String,
        value: Struct.getDefault(json, "lines", new Array(String)).join("\n"),
      },
    }),
    components: new Array(Struct, [
      {
        name: "subtitle_lines",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Text",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "subtitle_lines_text-area",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "lines" },
          },
        },
      },
      {
        name: "subtitle_lines_text-area-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: {
            type: UILayoutType.VERTICAL,
            margin: { top: 0, bottom: 0 },
            height: function() { return 0 },
          },
          image: { 
            //hidden: { key: "en-shr_hide-inherit" },
            backgroundAlpha: 0.0,
          },
        },
      },
    ]),
  }

  return template
}
