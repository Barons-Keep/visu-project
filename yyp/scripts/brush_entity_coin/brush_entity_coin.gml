///@package io.alkapivo.visu.editor.service.brush.entity

///@param {Struct} json
///@return {Struct}
function brush_entity_coin(json) {
  return {
    name: "brush_entity_coin",
    store: new Map(String, Struct, {
      "en-coin_preview": {
        type: Boolean,
        value: Struct.get(json, "en-coin_preview"),
      },
      "en-coin_template": {
        type: String,
        value: Struct.get(json, "en-coin_template"),
        passthrough: UIUtil.passthrough.getCallbackValue(),
        data: {
          callback: Beans.get(BeanVisuController).coinTemplateExists,
          defaultValue: "coin-default",
        },
      },
      "en-coin_x": {
        type: Number,
        value: Struct.get(json, "en-coin_x"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(
          -1.0 * (SHROOM_SPAWN_AMOUNT / 2.0),
          SHROOM_SPAWN_AMOUNT / 2.0
        ),
      },
      "en-coin_snap-x": {
        type: Boolean,
        value: Struct.get(json, "en-coin_snap-x"),
      },
      "en-coin_use-rng-x": {
        type: Boolean,
        value: Struct.get(json, "en-coin_use-rng-x"),
      },
      "en-coin_rng-x": {
        type: Number,
        value: Struct.get(json, "en-coin_rng-x"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, SHROOM_SPAWN_AMOUNT),
      },
      "en-coin_y": {
        type: Number,
        value: Struct.get(json, "en-coin_y"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(
          -1.0 * (SHROOM_SPAWN_AMOUNT / 2.0),
          SHROOM_SPAWN_AMOUNT / 2.0
        ),
      },
      "en-coin_snap-y": {
        type: Boolean,
        value: Struct.get(json, "en-coin_snap-y"),
      },
      "en-coin_use-rng-y": {
        type: Boolean,
        value: Struct.get(json, "en-coin_use-rng-y"),
      },
      "en-coin_rng-y": {
        type: Number,
        value: Struct.get(json, "en-coin_rng-y"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, SHROOM_SPAWN_AMOUNT),
      },
      "en-coin_hide": {
        type: Boolean,
        value: Struct.get(json, "en-coin_hide"),
      },
      "en-coin_hide-spawn": {
        type: Boolean,
        value: Struct.get(json, "en-coin_hide-spawn"),
      },
    }),
    components: new Array(Struct, [
      {
        name: "en-coin_hide",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Properties",
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "en-coin_hide" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "en-coin_template",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Template",
            hidden: { key: "en-coin_hide" },
          },
          field: {
            store: { key: "en-coin_template" },
            hidden: { key: "en-coin_hide" },
          },
        },
      },
      {
        name: "en-coin_template-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-coin_hide" } },
        },
      },
      {
        name: "en-coin_hide-spawn",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Spawner",
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "en-coin_hide-spawn" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "en-coin_preview",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Show spawner",
            enable: { key: "en-coin_preview" },
            hidden: { key: "en-coin_hide-spawn" },
            backgroundColor: VETheme.color.side,
            updateCustom: function() {
              this.preRender()
              if (Core.isType(this.context.updateTimer, Timer)) {
                var inspectorType = this.context.state.get("inspectorType")
                switch (inspectorType) {
                  case VEEventInspector:
                    var shroomService = Beans.get(BeanVisuController).shroomService
                    if (shroomService.spawnerEvent != null) {
                      shroomService.spawnerEvent.timeout = ceil(this.context.updateTimer.duration * 60)
                    }
                    break
                  case VEBrushToolbar:
                    var shroomService = Beans.get(BeanVisuController).shroomService
                    if (shroomService.spawner != null) {
                      shroomService.spawner.timeout = ceil(this.context.updateTimer.duration * 60)
                    }
                    break
                }
              }
            },
            preRender: function() {
              var store = null
              if (Core.isType(this.context.state.get("brush"), VEBrush)) {
                store = this.context.state.get("brush").store
              }
              
              if (Core.isType(this.context.state.get("event"), VEEvent)) {
                store = this.context.state.get("event").store
              }

              if (!Optional.is(store) || !store.getValue("en-coin_preview")) {
                return
              }

              var view = Beans.get(BeanVisuController).gridService.view
  
              if (!Struct.contains(this, "spawnerXTimer")) {
                Struct.set(this, "spawnerXTimer", new Timer(pi * 2, { 
                  loop: Infinity,
                  amount: FRAME_MS * 4,
                  shuffle: true
                }))
              }

              var _x = store.getValue("en-coin_x") * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT) + 0.5
              if (store.getValue("en-coin_use-rng-x")) {
                _x += sin(this.spawnerXTimer.update().time) * (store.getValue("en-coin_rng-x") * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT) / 2.0)
              }

              if (store.getValue("en-coin_snap-x")) {
                _x = _x - (view.x - floor(view.x / view.width) * view.width)
              }

              if (!Struct.contains(this, "spawnerYTimer")) {
                Struct.set(this, "spawnerYTimer", new Timer(pi * 2, { 
                  loop: Infinity,
                  amount: FRAME_MS * 4,
                  shuffle: true
                }))
              }

              var _y = store.getValue("en-coin_y") * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT) - 0.5
              if (store.getValue("en-coin_use-rng-y")) {
                _y += sin(this.spawnerYTimer.update().time) * (store.getValue("en-coin_rng-y") * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT) / 2.0)
              }

              if (store.getValue("en-coin_snap-y")) {
                _y = _y - (view.y - floor(view.y / view.height) * view.height)
              }

              var inspectorType = this.context.state.get("inspectorType")
              switch (inspectorType) {
                case VEEventInspector:
                  var shroomService = Beans.get(BeanVisuController).shroomService
                  shroomService.spawnerEvent = shroomService.factorySpawner({ 
                    x: _x, 
                    y: _y, 
                    sprite: SpriteUtil.parse({ name: "texture_bazyl" })
                  })
                  break
                case VEBrushToolbar:
                  var shroomService = Beans.get(BeanVisuController).shroomService
                  shroomService.spawner = shroomService.factorySpawner({ 
                    x: _x, 
                    y: _y, 
                    sprite: SpriteUtil.parse({ name: "texture_baron" })
                  })
                  break
              }
            },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-coin_preview" },
            hidden: { key: "en-coin_hide-spawn" },
            backgroundColor: VETheme.color.side,
          },
          input: {
            hidden: { key: "en-coin_hide-spawn" },
            backgroundColor: VETheme.color.side,
          }
        },
      },
      {
        name: "en-coin_x-slider",  
        template: VEComponents.get("numeric-slider"),
        layout: VELayouts.get("numeric-slider"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            margin: { top: 2 },
          },
          label: { 
            text: "X",
            font: "font_inter_10_bold",
            offset: { y: 14 },
            hidden: { key: "en-coin_hide-spawn" },
          }, 
          slider: {
            minValue: -1.0 * (SHROOM_SPAWN_AMOUNT / 2),
            maxValue: SHROOM_SPAWN_AMOUNT / 2,
            snapValue: 0.1,
            store: { key: "en-coin_x" },
            hidden: { key: "en-coin_hide-spawn" },
          },
        },
      },
      {
        name: "en-coin_x",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "",
            font: "font_inter_10_bold",
            hidden: { key: "en-coin_hide-spawn" },
          },  
          field: {
            store: { key: "en-coin_x" },
            hidden: { key: "en-coin_hide-spawn" },
          },
          decrease: {
            store: { key: "en-coin_x" },
            hidden: { key: "en-coin_hide-spawn" },
            factor: -0.25,
          },
          increase: {
            store: { key: "en-coin_x" },
            hidden: { key: "en-coin_hide-spawn" },
            factor: 0.25,
          },
          stick: {
            store: { key: "en-coin_x" },
            hidden: { key: "en-coin_hide-spawn" },
            factor: 0.001,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-coin_snap-x" },
            hidden: { key: "en-coin_hide-spawn" },
          },
          title: { 
            text: "Snap",
            enable: { key: "en-coin_snap-x" },
            hidden: { key: "en-coin_hide-spawn" },
          },
        },
      },
      {
        name: "en-coin_rng-x",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Random",
            enable: { key: "en-coin_use-rng-x" },
            hidden: { key: "en-coin_hide-spawn" },
          },  
          field: { 
            store: { key: "en-coin_rng-x" },
            enable: { key: "en-coin_use-rng-x" },
            hidden: { key: "en-coin_hide-spawn" },
          },
          decrease: {
            store: { key: "en-coin_rng-x" },
            enable: { key: "en-coin_use-rng-x" },
            hidden: { key: "en-coin_hide-spawn" },
            factor: -0.25,
          },
          increase: {
            store: { key: "en-coin_rng-x" },
            enable: { key: "en-coin_use-rng-x" },
            hidden: { key: "en-coin_hide-spawn" },
            factor: 0.25,
          },
          stick: {
            store: { key: "en-coin_rng-x" },
            enable: { key: "en-coin_use-rng-x" },
            hidden: { key: "en-coin_hide-spawn" },
            factor: 0.001,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            hidden: { key: "en-coin_hide-spawn" },
            store: { key: "en-coin_use-rng-x" },
          },
          title: { 
            text: "Enable",
            enable: { key: "en-coin_use-rng-x" },
            hidden: { key: "en-coin_hide-spawn" },
          },
        },
      },
      {
        name: "en-coin_rng-x-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-coin_hide-spawn" } }
        },
      },
      {
        name: "en-coin_y-slider",  
        template: VEComponents.get("numeric-slider"),
        layout: VELayouts.get("numeric-slider"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Y",
            color: VETheme.color.textShadow,
            font: "font_inter_10_bold",
            offset: { y: 14 },
            hidden: { key: "en-coin_hide-spawn" },
          },  
          slider: {
            minValue: -1.0 * (SHROOM_SPAWN_AMOUNT / 2),
            maxValue: SHROOM_SPAWN_AMOUNT / 2,
            snapValue: 0.1,
            store: { key: "en-coin_y" },
            hidden: { key: "en-coin_hide-spawn" },
          },
        },
      },
      {
        name: "en-coin_y",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "",
            font: "font_inter_10_bold",
            hidden: { key: "en-coin_hide-spawn" },
          },  
          field: {
            store: { key: "en-coin_y" },
            hidden: { key: "en-coin_hide-spawn" },
          },
          decrease: {
            store: { key: "en-coin_y" },
            hidden: { key: "en-coin_hide-spawn" },
            factor: -0.25,
          },
          increase: {
            store: { key: "en-coin_y" },
            hidden: { key: "en-coin_hide-spawn" },
            factor: 0.25,
          },
          stick: {
            store: { key: "en-coin_y" },
            hidden: { key: "en-coin_hide-spawn" },
            factor: 0.001,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-coin_snap-y" },
            hidden: { key: "en-coin_hide-spawn" },
          },
          title: { 
            text: "Snap",
            enable: { key: "en-coin_snap-y" },
            hidden: { key: "en-coin_hide-spawn" },
          },
        },
      },
      {
        name: "en-coin_rng-y",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Random",
            enable: { key: "en-coin_use-rng-y" },
            hidden: { key: "en-coin_hide-spawn" },
          },  
          field: { 
            store: { key: "en-coin_rng-y" },
            enable: { key: "en-coin_use-rng-y" },
            hidden: { key: "en-coin_hide-spawn" },
          },
          decrease: {
            store: { key: "en-coin_rng-y" },
            enable: { key: "en-coin_use-rng-y" },
            hidden: { key: "en-coin_hide-spawn" },
            factor: -0.25,
          },
          increase: {
            store: { key: "en-coin_rng-y" },
            enable: { key: "en-coin_use-rng-y" },
            hidden: { key: "en-coin_hide-spawn" },
            factor: 0.25,
          },
          stick: {
            store: { key: "en-coin_rng-y" },
            enable: { key: "en-coin_use-rng-y" },
            hidden: { key: "en-coin_hide-spawn" },
            factor: 0.001,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-coin_use-rng-y" },
            hidden: { key: "en-coin_hide-spawn" },
          },
          title: { 
            text: "Enable",
            enable: { key: "en-coin_use-rng-y" },
            hidden: { key: "en-coin_hide-spawn" },
          },
        },
      },
    ]),
  }
}