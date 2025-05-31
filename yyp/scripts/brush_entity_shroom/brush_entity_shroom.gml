///@package io.alkapivo.visu.editor.service.brush.entity

///@param {Struct} json
///@return {Struct}
function brush_entity_shroom(json) {
  return {
    name: "brush_entity_shroom",
    store: new Map(String, Struct, {
      "en-shr_preview": {
        type: Boolean,
        value: Struct.get(json, "en-shr_preview"),
      },
      "en-shr_template": {
        type: String,
        value: Struct.get(json, "en-shr_template"),
        passthrough: UIUtil.passthrough.getCallbackValue(),
        data: {
          callback: Beans.get(BeanVisuController).shroomTemplateExists,
          defaultValue: "shroom-default",
        },
      },
      "en-shr_use-lifespan": {
        type: Boolean,
        value: Struct.get(json, "en-shr_use-lifespan")
      },
      "en-shr_lifespan": {
        type: Number,
        value: Struct.get(json, "en-shr_lifespan"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "en-shr_use-hp": {
        type: Boolean,
        value: Struct.get(json, "en-shr_use-hp"),
      },
      "en-shr_hp": {
        type: Number,
        value: Struct.get(json, "en-shr_hp"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 9999999.9),
      },
      "en-shr_spd": {
        type: Number,
        value: Struct.get(json, "en-shr_spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 99.9),
      },
      "en-shr_spd-grid": {
        type: Boolean,
        value: Struct.get(json, "en-shr_spd-grid"),
      },
      "en-shr_use-spd-rng": {
        type: Boolean,
        value: Struct.get(json, "en-shr_use-spd-rng"),
      },
      "en-shr_spd-rng": {
        type: Number,
        value: Struct.get(json, "en-shr_spd-rng"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 99.9),
      },
      "en-shr_dir": {
        type: Number,
        value: Struct.get(json, "en-shr_dir"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 360.0),
      },
      "en-shr_use-dir-rng": {
        type: Boolean,
        value: Struct.get(json, "en-shr_use-dir-rng"),
      },
      "en-shr_dir-rng": {
        type: Number,
        value: Struct.get(json, "en-shr_dir-rng"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 360.0),
      },
      "en-shr_x": {
        type: Number,
        value: Struct.get(json, "en-shr_x", Number, 0),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(
          -1.0 * (SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0), 
          SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0
        ),
      },
      "en-shr_snap-x": {
        type: Boolean,
        value: Struct.get(json, "en-shr_snap-x"),
      },
      "en-shr_use-rng-x": {
        type: Boolean,
        value: Struct.get(json, "en-shr_use-rng-x"),
      },
      "en-shr_rng-x": {
        type: Number,
        value: Struct.get(json, "en-shr_rng-x", Number, 0),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(
          0.0, 
          SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0
        ),
      },
      "en-shr_y": {
        type: Number,
        value: Struct.get(json, "en-shr_y", Number, 0),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(
          -1.0 * (SHROOM_SPAWN_ROW_AMOUNT / 2.0), 
          SHROOM_SPAWN_ROW_AMOUNT / 2.0
        ),
      },
      "en-shr_snap-y": {
        type: Boolean,
        value: Struct.get(json, "en-shr_snap-y"),
      },
      "en-shr_use-rng-y": {
        type: Boolean,
        value: Struct.get(json, "en-shr_use-rng-y"),
      },
      "en-shr_rng-y": {
        type: Number,
        value: Struct.get(json, "en-shr_rng-y", Number, 0),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(
          0.0, 
          SHROOM_SPAWN_ROW_AMOUNT / 2.0
        ),
      },
      "en-shr_use-inherit": {
        type: Boolean,
        value: Struct.get(json, "en-shr_use-inherit"),
      },
      "en-shr_inherit": {
        type: String,
        value: JSON.stringify(Struct.getIfType(json, "en-shr_inherit", GMArray, []), { pretty: true }),
        serialize: UIUtil.serialize.getStringGMArray(),
        passthrough: UIUtil.passthrough.getStringGMArray(),
      },
      "en-shr_use-texture": {
        type: Boolean,
        value: Struct.get(json, "en-shr_use-texture"),
      },
      "en-shr_texture": {
        type: Sprite,
        value: Struct.get(json, "en-shr_texture"),
      },
      "en-shr_use-mask": {
        type: Boolean,
        value: Struct.get(json, "en-shr_use-mask"),
      },
      "en-shr_mask": {
        type: Rectangle,
        value: Struct.get(json, "en-shr_mask"),
      },
      "en-shr_spawn-map": {
        type: TextureTemplate,
        value: new TextureTemplate("texture_shroom_spawn_map", { asset: texture_shroom_spawn_map, file: "" }),
      },
      "en-shr_hide": {
        type: Boolean,
        value: Struct.get(json, "en-shr_hide"),
      },
      "en-shr_hide-spawn": {
        type: Boolean,
        value: Struct.get(json, "en-shr_hide-spawn"),
      },
      "en-shr_hide-inherit": {
        type: Boolean,
        value: Struct.get(json, "en-shr_hide-inherit"),
      },
    }),
    components: new Array(Struct, [
      {
        name: "en-shr_hide",
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
            store: { key: "en-shr_hide" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "en-shr_template",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            //margin: { top: 2, bottom: 2 },
          },
          label: {
            text: "Template",
            hidden: { key: "en-shr_hide" },
          },
          field: {
            store: { key: "en-shr_template" },
            hidden: { key: "en-shr_hide" },
          },
        },
      },
      {
        name: "en-shr_lifespan",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Lifespan",
            enable: { key: "en-shr_use-lifespan" },
            hidden: { key: "en-shr_hide" },
          },  
          field: { 
            store: { key: "en-shr_lifespan" },
            enable: { key: "en-shr_use-lifespan" },
            hidden: { key: "en-shr_hide" },
          },
          decrease: {
            store: { key: "en-shr_lifespan" },
            enable: { key: "en-shr_use-lifespan" },
            factor: -0.1,
            hidden: { key: "en-shr_hide" },
          },
          increase: {
            store: { key: "en-shr_lifespan" },
            enable: { key: "en-shr_use-lifespan" },
            factor: 0.1,
            hidden: { key: "en-shr_hide" },
          },
          stick: {
            store: { key: "en-shr_lifespan" },
            enable: { key: "en-shr_use-lifespan" },
            factor: 0.1,
            step: 10.0,
            hidden: { key: "en-shr_hide" },
          },
          checkbox: {
            store: { key: "en-shr_use-lifespan" },
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            hidden: { key: "en-shr_hide" },
          },
          title: {
            text: "Override",
            enable: { key: "en-shr_use-lifespan" },
            hidden: { key: "en-shr_hide" },
          }
        },
      },
      {
        name: "en-shr_hp",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Health",
            enable: { key: "en-shr_use-hp" },
            hidden: { key: "en-shr_hide" },
          },  
          field: { 
            store: { key: "en-shr_hp" },
            enable: { key: "en-shr_use-hp" },
            hidden: { key: "en-shr_hide" },
          },
          decrease: {
            store: { key: "en-shr_hp" },
            enable: { key: "en-shr_use-hp" },
            factor: -0.1,
            hidden: { key: "en-shr_hide" },
          },
          increase: {
            store: { key: "en-shr_hp" },
            enable: { key: "en-shr_use-hp" },
            factor: 0.1,
            hidden: { key: "en-shr_hide" },
          },
          stick: {
            store: { key: "en-shr_hp" },
            enable: { key: "en-shr_use-hp" },
            factor: 0.1,
            step: 10.0,
            hidden: { key: "en-shr_hide" },
          },
          checkbox: {
            store: { key: "en-shr_use-hp" },
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            hidden: { key: "en-shr_hide" },
          },
          title: {
            text: "Override",
            enable: { key: "en-shr_use-hp" },
            hidden: { key: "en-shr_hide" },
          }
        },
      },
      {
        name: "en-shr-template-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-shr_hide" } },
        },
      },
      {
        name: "en-shr_hide-spawn",
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
            store: { key: "en-shr_hide-spawn" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "en-shr_preview",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Show spawner",
            enable: { key: "en-shr_preview" },
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

              if (!Optional.is(store) || !store.getValue("en-shr_preview")) {
                return
              }

              var controller = Beans.get(BeanVisuController)
              var locked = controller.gridService.targetLocked
              var view = controller.gridService.view
  
              if (!Struct.contains(this, "spawnerXTimer")) {
                Struct.set(this, "spawnerXTimer", new Timer(pi * 2, { 
                  loop: Infinity,
                  amount: FRAME_MS * 4,
                  shuffle: true
                }))
              }

              var _x = store.getValue("en-shr_x") * (SHROOM_SPAWN_CHANNEL_SIZE / SHROOM_SPAWN_CHANNEL_AMOUNT) + 0.5
              if (store.getValue("en-shr_use-rng-x")) {
                _x += sin(this.spawnerXTimer.update().time) * (store.getValue("en-shr_rng-x") * (SHROOM_SPAWN_CHANNEL_SIZE / SHROOM_SPAWN_CHANNEL_AMOUNT) / 2.0)
              }

              if (store.getValue("en-shr_snap-x")) {
                _x = _x - (view.x - locked.snapH)
              }

              if (!Struct.contains(this, "spawnerYTimer")) {
                Struct.set(this, "spawnerYTimer", new Timer(pi * 2, { 
                  loop: Infinity,
                  amount: FRAME_MS * 4,
                  shuffle: true
                }))
              }

              var _y = store.getValue("en-shr_y") * (SHROOM_SPAWN_ROW_SIZE / SHROOM_SPAWN_ROW_AMOUNT) - 0.5
              if (store.getValue("en-shr_use-rng-y")) {
                _y += sin(this.spawnerYTimer.update().time) * (store.getValue("en-shr_rng-y") * (SHROOM_SPAWN_ROW_SIZE / SHROOM_SPAWN_ROW_AMOUNT) / 2.0)
              }

              if (store.getValue("en-shr_snap-y")) {
                _y = _y - (view.y - locked.snapV)
              }

              if (!Struct.contains(this, "spawnerAngleTimer")) {
                Struct.set(this, "spawnerAngleTimer", new Timer(pi * 2, { 
                  loop: Infinity,
                  amount: FRAME_MS * 4,
                  shuffle: true
                }))
              }

              var angle = store.getValue("en-shr_dir")
              if (store.getValue("en-shr_use-dir-rng")) {
                angle += sin(this.spawnerAngleTimer.update().time) * (store.getValue("en-shr_dir-rng") / 2.0)
              }

              var inspectorType = this.context.state.get("inspectorType")
              switch (inspectorType) {
                case VEEventInspector:
                  var shroomService = Beans.get(BeanVisuController).shroomService
                  shroomService.spawnerEvent = shroomService.factorySpawner({ 
                    x: _x, 
                    y: _y, 
                    sprite: SpriteUtil.parse({ 
                      name: "texture_visu_shroom_spawner", 
                      blend: "#43abfa",
                      angle: angle,
                    })
                  })
                  break
                case VEBrushToolbar:
                  var shroomService = Beans.get(BeanVisuController).shroomService
                  shroomService.spawner = shroomService.factorySpawner({ 
                    x: _x, 
                    y: _y, 
                    sprite: SpriteUtil.parse({
                      name: "texture_visu_shroom_spawner",
                      blend: "#f757ef",
                      angle: angle,
                    })
                  })
                  break
              }
            },
            hidden: { key: "en-shr_hide-spawn" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_preview" },
            backgroundColor: VETheme.color.side,
            hidden: { key: "en-shr_hide-spawn" },
          },
          input: {
            backgroundColor: VETheme.color.side,
            hidden: { key: "en-shr_hide-spawn" },
          }
        },
      },
      {
        name: "en-shr_spawn-map",
        template: VEComponents.get("texture-field-intent"),
        layout: VELayouts.get("texture-field-intent-simple"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
          },
          preview: {
            image: {
              name: "texture_shroom_spawn_map",
              disableTextureService: true,
            },
            store: { key: "en-shr_spawn-map" },
            hidden: { key: "en-shr_hide-spawn" },
            origin: "en-shr_spawn-map",
            onMousePressedLeft: function(event) {
              var editorIO = Beans.get(BeanVisuEditorIO)
              var mouse = editorIO.mouse
              if (Optional.is(mouse.getClipboard())) {
                return
              }

              mouse.setClipboard(this)
            },
            onMouseOnLeft: function(event) {
              var editorIO = Beans.get(BeanVisuEditorIO)
              var mouse = editorIO.mouse
              if (mouse.getClipboard() != this) {
                return
              }

              var _x = event.data.x - this.context.area.getX() - this.area.getX() - this.context.offset.x
              var _y = event.data.y - this.context.area.getY() - this.area.getY() - this.context.offset.y
              var areaWidth = this.area.getWidth()
              var areaHeight = this.area.getHeight()
              var scaleX = this.image.getScaleX()
              var scaleY = this.image.getScaleY()
              this.image.scaleToFit(areaWidth, areaHeight)
  
              var width = this.image.getWidth() * this.image.getScaleX()
              var height = this.image.getHeight() * this.image.getScaleY()
              this.image.setScaleX(scaleX).setScaleY(scaleY)
  
              var marginH = (areaWidth - width) / 2.0
              var marginV = (areaHeight - height) / 2.0
  
              var originX = round(this.image.getWidth() * ((clamp(_x, marginH, areaWidth - marginH) - marginH) / width))
              var originY = round(this.image.getHeight() * ((clamp(_y, marginV, areaHeight - marginV) - marginV) / height))
  
              var textureIntent = this.store.getValue()
              if (textureIntent.originX != originX
                 || textureIntent.originY != originY) {
                textureIntent.originX = originX
                textureIntent.originY = originY
                this.store.get().set(textureIntent)
  
                var store = this.store.getStore()
                if (Optional.is(store)) {
                  var horizontal = round(((originX / this.image.getWidth()) * 50.0) - 25.0)
                  var vertical = round(((originY / this.image.getHeight()) * 50.0) - 25.0)
                  store.get("en-shr_x").set(horizontal)
                  store.get("en-shr_y").set(vertical)
                }
              }
  
              return this
            },
            preRender: function() {
              var store = this.store.getStore()
              if (!Optional.is(store)) {
                return
              }

              var horizontal = (store.getValue("en-shr_x") + 25.0) / 50.0
              var vertical = (store.getValue("en-shr_y") + 25.0) / 50.0
              var originX = round(horizontal * this.image.getWidth())
              var originY = round(vertical * this.image.getHeight())
              var textureIntent = this.store.getValue()
              if (textureIntent.originX != originX
                || textureIntent.originY != originY) {
                textureIntent.originX = originX
                textureIntent.originY = originY
                this.store.get().set(textureIntent)
              }
                      
              if (mouse_check_button(mb_left)) {
                Beans.get(BeanVisuEditorController).uiService.send(new Event("MouseOnLeft", { 
                  x: MouseUtil.getMouseX(), 
                  y: MouseUtil.getMouseY(),
                }))
              }
            },
            postRender: function() {
              var store = this.store.getStore()
              if (!Optional.is(this.origin) || !Optional.is(store)) {
                return
              }

              if (!Struct.contains(this, "spawnerAngleTimer")) {
                Struct.set(this, "spawnerAngleTimer", new Timer(pi * 2, { 
                  loop: Infinity,
                  amount: FRAME_MS * 4,
                  shuffle: true
                }))
              }

              var angle = store.getValue("en-shr_dir")
              if (store.getValue("en-shr_use-dir-rng")) {
                angle += sin(this.spawnerAngleTimer.update().time) * (store.getValue("en-shr_dir-rng") / 2.0)
              }

              var textureTemplate = store.getValue(this.origin)
              var originX = textureTemplate.originX
              var originY = textureTemplate.originY
              var scaleX = this.image.getScaleX()
              var scaleY = this.image.getScaleY()
              this.image.scaleToFit(this.area.getWidth(), this.area.getHeight())
              var _x = this.context.area.getX() 
                + this.area.getX()
                + (this.area.getWidth() / 2.0)
                - ((this.image.getWidth() * this.image.getScaleX()) / 2.0)
                + (originX * this.image.getScaleX())
                + Math.fetchCircleX(8, angle)
              var _y = this.context.area.getY() 
                + this.area.getY()
                + (this.area.getHeight() / 2.0)
                - ((this.image.getHeight() * this.image.getScaleY()) / 2.0)
                + (originY * this.image.getScaleY())
                + Math.fetchCircleY(8, angle)
              this.image.setScaleX(scaleX).setScaleY(scaleY)

              var width = sprite_get_width(visu_texture_ui_angle_arrow)
              var height = sprite_get_height(visu_texture_ui_angle_arrow)
              draw_sprite_ext(visu_texture_ui_angle_arrow, 0, _x, _y, 32.0 / width, 32.0 / height, angle, c_white, 1.0)
            },
          },
          resolution: { 
            store: { 
              key: "en-shr_spawn-map",
              callback: function(value, data) { 
                if (!Core.isType(value, TextureTemplate)) {
                  return
                }
                
                data.label.text = ""//$"width: {sprite_get_width(value.asset)} height: {sprite_get_height(value.asset)}"
              },
            },
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      //{
      //  name: "en-shr-spawn-map-line-h",
      //  template: VEComponents.get("line-h"),
      //  layout: VELayouts.get("line-h"),
      //  config: { 
      //    layout: {
      //      type: UILayoutType.VERTICAL,
      //      margin: { top: 8, bottom: 4 },
      //    },
      //    image: { hidden: { key: "en-shr_hide-spawn" } },
      //  },
      //},
      {
        name: "en-shr_x-slider",  
        template: VEComponents.get("numeric-slider"),
        layout: VELayouts.get("numeric-slider"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            margin: { top: 2 },
          },
          label: { 
            text: "X",
            color: VETheme.color.textShadow,
            font: "font_inter_10_bold",
            offset: { y: 14 },
            hidden: { key: "en-shr_hide-spawn" },
          },
          slider: {
            minValue: -1.0 * (SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0),
            maxValue: SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0,
            snapValue: 1.0 / SHROOM_SPAWN_CHANNEL_AMOUNT,
            store: { key: "en-shr_x" },
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      {
        name: "en-shr_x",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            //margin: { top: 2 },
          },
          label: {
            text: "",
            hidden: { key: "en-shr_hide-spawn" },
          },
          //label: { 
          //  text: "X",
          //  color: VETheme.color.textShadow,
          //  font: "font_inter_10_bold",
          //  hidden: { key: "en-shr_hide-spawn" },
          //},
          field: {
            store: { key: "en-shr_x" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          decrease: {
            store: { key: "en-shr_x" },
            factor: -0.25,
            hidden: { key: "en-shr_hide-spawn" },
          },
          increase: {
            store: { key: "en-shr_x" },
            factor: 0.25,
            hidden: { key: "en-shr_hide-spawn" },
          },
          stick: {
            factor: 0.25,
            step: 10,
            store: { key: "en-shr_x" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_snap-x" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          title: { 
            text: "Snap",
            enable: { key: "en-shr_snap-x" },
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      {
        name: "en-shr_rng-x",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            //margin: { top: 2, bottom: 4 },
          },
          label: { 
            text: "Random",
            enable: { key: "en-shr_use-rng-x" },
            hidden: { key: "en-shr_hide-spawn" },
          },  
          field: { 
            store: { key: "en-shr_rng-x" },
            enable: { key: "en-shr_use-rng-x" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          decrease: {
            store: { key: "en-shr_rng-x" },
            enable: { key: "en-shr_use-rng-x" },
            factor: -0.25,
            hidden: { key: "en-shr_hide-spawn" },
          },
          increase: {
            store: { key: "en-shr_rng-x" },
            enable: { key: "en-shr_use-rng-x" },
            factor: 0.25,
            hidden: { key: "en-shr_hide-spawn" },
          },
          stick: {
            factor: 0.25,
            step: 10.0,
            store: { key: "en-shr_rng-x" },
            enable: { key: "en-shr_use-rng-x" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_use-rng-x" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          title: { 
            text: "Enable",
            enable: { key: "en-shr_use-rng-x" },
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      {
        name: "en-shr-rng-x-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-shr_hide-spawn" } },
        },
      },
      {
        name: "en-shr_y-slider",  
        template: VEComponents.get("numeric-slider"),
        layout: VELayouts.get("numeric-slider"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            //margin: { top: 2 },
          },
          label: { 
            text: "Y",
            color: VETheme.color.textShadow,
            font: "font_inter_10_bold",
            offset: { y: 14 },
            hidden: { key: "en-shr_hide-spawn" },
          },
          slider: {
            minValue: -1.0 * (SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0),
            maxValue: SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0,
            snapValue: 1.0 / SHROOM_SPAWN_CHANNEL_AMOUNT,
            store: { key: "en-shr_y" },
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      {
        name: "en-shr_y",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            //margin: { top: 2 },
          },
          label: {
            text: "",
            hidden: { key: "en-shr_hide-spawn" }
          },
          //label: { 
          //  text: "Y",
          //  color: VETheme.color.textShadow,
          //  font: "font_inter_10_bold",
          //  hidden: { key: "en-shr_hide-spawn" },
          //},
          field: {
            store: { key: "en-shr_y" },
            hidden: { key: "en-shr_hide-spawn" }
          },
          decrease: {
            store: { key: "en-shr_y" },
            factor: -0.25,
            hidden: { key: "en-shr_hide-spawn" },
          },
          increase: {
            store: { key: "en-shr_y" },
            factor: 0.25,
            hidden: { key: "en-shr_hide-spawn" },
          },
          stick: {
            factor: 0.25,
            step: 10.0,
            store: { key: "en-shr_y" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_snap-y" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          title: { 
            text: "Snap",
            enable: { key: "en-shr_snap-y" },
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      {
        name: "en-shr_rng-y",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            //margin: { top: 2, bottom: 4 },
          },
          label: { 
            text: "Random",
            enable: { key: "en-shr_use-rng-y" },
            hidden: { key: "en-shr_hide-spawn" },
          },  
          field: { 
            store: { key: "en-shr_rng-y" },
            enable: { key: "en-shr_use-rng-y" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          decrease: {
            store: { key: "en-shr_rng-y" },
            enable: { key: "en-shr_use-rng-y" },
            factor: -0.25,
            hidden: { key: "en-shr_hide-spawn" },
          },
          increase: {
            store: { key: "en-shr_rng-y" },
            enable: { key: "en-shr_use-rng-y" },
            factor: 0.25,
            hidden: { key: "en-shr_hide-spawn" },
          },
          stick: {
            factor: 0.25,
            step: 10.0,
            store: { key: "en-shr_rng-y" },
            enable: { key: "en-shr_use-rng-y" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_use-rng-y" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          title: { 
            text: "Enable",
            enable: { key: "en-shr_use-rng-y" },
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      {
        name: "en-shr-rng-y-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-shr_hide-spawn" } },
        },
      },
      {
        name: "en-shr_dir-slider",  
        template: VEComponents.get("numeric-slider"),
        layout: VELayouts.get("numeric-slider"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            //margin: { top: 2 },
          },
          label: {
            text: "Angle",
            font: "font_inter_10_bold",
            offset: { y: 14 },
            hidden: { key: "en-shr_hide-spawn" },
          },
          slider: {
            minValue: 0.0,
            maxValue: 360.0,
            snapValue: 1.0 / 360.0,
            store: { key: "en-shr_dir" },
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      {
        name: "en-shr_dir",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            //margin: { top: 2 },
          },
          label: {
            text: "",
            font: "font_inter_10_bold",
            hidden: { key: "en-shr_hide-spawn" },
          },
          field: {
            store: { key: "en-shr_dir" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          decrease: {
            store: { key: "en-shr_dir" },
            hidden: { key: "en-shr_hide-spawn" },
            factor: -0.1,
          },
          increase: {
            store: { key: "en-shr_dir" },
            hidden: { key: "en-shr_hide-spawn" },
            factor: 0.1,
          },
          stick: {
            factor: 0.1,
            //step: 10.0,
            store: { key: "en-shr_dir" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          checkbox: {
            hidden: { key: "en-shr_hide-spawn" },
            store: { 
              key: "en-shr_dir",
              callback: function(value, data) { 
                var sprite = Struct.get(data, "sprite")
                if (!Core.isType(sprite, Sprite)) {
                  sprite = SpriteUtil.parse({ name: "visu_texture_ui_spawn_arrow" })
                  Struct.set(data, "sprite", sprite)
                }
                sprite.setAngle(value)
              },
              set: function(value) { return },
            },
            render: function() {
              if (this.backgroundColor != null) {
                var _x = this.context.area.getX() + this.area.getX()
                var _y = this.context.area.getY() + this.area.getY()
                var color = this.backgroundColor
                draw_rectangle_color(
                  _x, _y, 
                  _x + this.area.getWidth(), _y + this.area.getHeight(),
                  color, color, color, color,
                  false
                )
              }

              var sprite = Struct.get(this, "sprite")
              if (!Core.isType(sprite, Sprite)) {
                sprite = SpriteUtil.parse({ name: "visu_texture_ui_angle_arrow" })
                Struct.set(this, "sprite", sprite)
              }

              if (!Struct.contains(this, "spawnerAngleTimer")) {
                Struct.set(this, "spawnerAngleTimer", new Timer(pi * 2, { 
                  loop: Infinity,
                  amount: FRAME_MS * 4,
                  shuffle: true
                }))
              }

              var angle = sprite.getAngle()
              if (this.store != null && this.store.getStore().getValue("en-shr_use-dir-rng")) {
                sprite.setAngle(angle + sin(this.spawnerAngleTimer.update().time) * (this.store.getStore().getValue("en-shr_dir-rng") / 2.0))
              }
              
              var size = min(this.area.getWidth(), this.area.getHeight()) + 2
              sprite
                .scaleToFit(size, size)              
                .render(
                  this.context.area.getX() + this.area.getX() + sprite.texture.offsetX * sprite.getScaleX(),
                  this.context.area.getY() + this.area.getY() + sprite.texture.offsetY * sprite.getScaleY()
                )
                .setAngle(angle)
              
              return this
            },
          },
          title: {
            text: "",
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      {
        name: "en-shr_dir-rng",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            //margin: { top: 2, bottom: 4 },
          },
          label: { 
            text: "Random",
            enable: { key: "en-shr_use-dir-rng" },
            hidden: { key: "en-shr_hide-spawn" },
          },  
          field: { 
            store: { key: "en-shr_dir-rng" },
            enable: { key: "en-shr_use-dir-rng" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          decrease: {
            store: { key: "en-shr_dir-rng" },
            enable: { key: "en-shr_use-dir-rng" },
            hidden: { key: "en-shr_hide-spawn" },
            factor: -0.1,
          },
          increase: {
            store: { key: "en-shr_dir-rng" },
            enable: { key: "en-shr_use-dir-rng" },
            hidden: { key: "en-shr_hide-spawn" },
            factor: 0.1,
          },
          stick: {
            store: { key: "en-shr_dir-rng" },
            enable: { key: "en-shr_use-dir-rng" },
            hidden: { key: "en-shr_hide-spawn" },
            factor: 0.1,
            //step: 10.0,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_use-dir-rng" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          title: { 
            text: "Enable",
            enable: { key: "en-shr_use-dir-rng" },
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      {
        name: "en-shr_dir-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-shr_hide-spawn" } },
        },
      },
      {
        name: "en-shr_spd-slider",  
        template: VEComponents.get("numeric-slider"),
        layout: VELayouts.get("numeric-slider"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            //margin: { top: 2 },
          },
          label: { 
            text: "Speed",
            font: "font_inter_10_bold",
            offset: { y: 14 },
            hidden: { key: "en-shr_hide-spawn" },
          },
          slider: {
            mminValue: 0.0,
            maxValue: 99.9,
            snapValue: 1.0 / 99.9,
            store: { key: "en-shr_spd" },
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      {
        name: "en-shr_spd",  
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            //margin: { top: 2 },
          },
          label: {
            text: "",
            font: "font_inter_10_bold",
            hidden: { key: "en-shr_hide-spawn" },
          },
          field: {
            store: { key: "en-shr_spd" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          decrease: { 
            store: { key: "en-shr_spd" },
            hidden: { key: "en-shr_hide-spawn" },
            factor: -0.1,
          },
          increase: { 
            store: { key: "en-shr_spd" },
            hidden: { key: "en-shr_hide-spawn" },
            factor: 0.1,
          },
          stick: {
            factor: 0.1,
            //step: 10.0,
            store: { key: "en-shr_spd" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          checkbox: {
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_spd-grid" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          title: {
            text: "Add grid speed",
            enable: { key: "en-shr_spd-grid" },
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      {
        name: "en-shr_spd-rng",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            //margin: { top: 2, bottom: 4 },
          },
          label: { 
            text: "Random",
            enable: { key: "en-shr_use-spd-rng" },
            hidden: { key: "en-shr_hide-spawn" },
          },  
          field: { 
            store: { key: "en-shr_spd-rng" },
            enable: { key: "en-shr_use-spd-rng" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          decrease: {
            store: { key: "en-shr_spd-rng" },
            enable: { key: "en-shr_use-spd-rng" },
            hidden: { key: "en-shr_hide-spawn" },
            factor: -0.1,
          },
          increase: {
            store: { key: "en-shr_spd-rng" },
            enable: { key: "en-shr_use-spd-rng" },
            hidden: { key: "en-shr_hide-spawn" },
            factor: 0.1,
          },
          stick: {
            factor: 0.1,
            //step: 10.0,
            store: { key: "en-shr_spd-rng" },
            enable: { key: "en-shr_use-spd-rng" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_use-spd-rng" },
            hidden: { key: "en-shr_hide-spawn" },
          },
          title: { 
            text: "Enable",
            enable: { key: "en-shr_use-spd-rng" },
            hidden: { key: "en-shr_hide-spawn" },
          },
        },
      },
      {
        name: "en-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-shr_hide-spawn" } },
        },
      },
      {
        name: "en-shr_inherit-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Inherit",
            //backgroundColor: VETheme.color.accentShadow,
            enable: { key: "en-shr_use-inherit"},
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "en-shr_use-inherit" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            store: { key: "en-shr_hide-inherit" },
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
          },
        },
      },
      {
        name: "en-shr_inherit",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "en-shr_inherit" },
            enable: { key: "en-shr_use-inherit"},
            updateCustom: UIItemUtils.textField.getUpdateJSONTextArea(),
            hidden: { key: "en-shr_hide-inherit" },
          },
        },
      },
      {
        name: "en-shr_inherit-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: {
            type: UILayoutType.VERTICAL,
            margin: { top: 0, bottom: 0 },
            height: function() { return 0 },
          },
          image: { 
            hidden: { key: "en-shr_hide-inherit" },
            backgroundAlpha: 0.0,
          },
        },
      },
      /*
      ,{
        name: "en-shr-dir-rng-y-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "en-shr_texture",
        template: VEComponents.get("texture-field-ext"),
        layout: VELayouts.get("texture-field-ext"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: {
              text: "Override texture",
              backgroundColor: VETheme.color.accentShadow,
              enable: { key: "en-shr_use-texture" },
            },
            input: { backgroundColor: VETheme.color.accentShadow },
            checkbox: { 
              backgroundColor: VETheme.color.accentShadow,
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "en-shr_use-texture" },
            },
          },
          texture: {
            label: { 
              text: "Texture",
              enable: { key: "en-shr_use-texture" },
            }, 
            field: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
          },
          preview: {
            image: { name: "texture_empty" },
            store: { key: "en-shr_texture" },
            enable: { key: "en-shr_use-texture" },
          },
          resolution: {
            store: { key: "en-shr_texture" },
            enable: { key: "en-shr_use-texture" },
          },
          alpha: {
            label: { 
              text: "Alpha",
              enable: { key: "en-shr_use-texture" },
            },
            field: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            decrease: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            increase: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            slider: { 
              minValue: 0.0,
              maxValue: 1.0,
              snapValue: 0.01 / 1.0,
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
          },
          frame: {
            label: { 
              text: "Frame",
              enable: { key: "en-shr_use-texture" },
            },
            field: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            decrease: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            increase: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            checkbox: { 
              store: { key: "en-shr_texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              enable: { key: "en-shr_use-texture" },
            },
            title: { 
              text: "Rng",
              enable: { key: "en-shr_use-texture" },
            }, 
            stick: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
          },
          speed: {
            label: { 
              text: "Speed",
              enable: { key: "en-shr_use-texture" },
            },
            field: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            decrease: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            increase: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            checkbox: { 
              store: { key: "en-shr_texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              enable: { key: "en-shr_use-texture" },
            },
            stick: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
          },
          scaleX: {
            label: { 
              text: "Scale X",
              enable: { key: "en-shr_use-texture" },
            },
            field: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            decrease: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            increase: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            stick: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
          },
          scaleY: {
            label: { 
              text: "Scale Y",
              enable: { key: "en-shr_use-texture" },
            },
            field: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            decrease: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            increase: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
            stick: { 
              store: { key: "en-shr_texture" },
              enable: { key: "en-shr_use-texture" },
            },
          },
        },
      },
      {
        name: "en-shr_texture-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "en-shr_mask-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Override collision mask",
            enable: { key: "en-shr_use-mask" },
            backgroundColor: VETheme.color.side,
          },
          input: { backgroundColor: VETheme.color.side },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_use-mask" },
            backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "en-shr_mask-preview",
        template: VEComponents.get("preview-image-mask"),
        layout: VELayouts.get("preview-image-mask"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          preview: {
            enable: { key: "en-shr_use-mask" },
            image: { name: "texture_empty" },
            store: { key: "en-shr_texture" },
            mask: "en-shr_mask",
          },
          resolution: {
            enable: { key: "en-shr_use-mask" },
            store: { key: "en-shr_texture" },
          },
        },
      },
      {
        name: "en-shr_mask",
        template: VEComponents.get("vec4-stick-increase"),
        layout: VELayouts.get("vec4"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          x: {
            label: {
              text: "X",
              enable: { key: "en-shr_use-mask" },
            },
            field: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              factor: 1.0,
            },
            slider: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              factor: 0.1,
            },
          },
          y: {
            label: {
              text: "Y",
              enable: { key: "en-shr_use-mask" },
            },
            field: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              factor: 1.0,
            },
            slider: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              factor: 0.1,
            },
          },
          z: {
            label: {
              text: "Width",
              enable: { key: "en-shr_use-mask" },
            },
            field: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              factor: 1.0,
            },
            slider: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              factor: 0.1,
            },
          },
          a: {
            label: {
              text: "Height",
              enable: { key: "en-shr_use-mask" },
            },
            field: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              factor: 1.0,
            },
            slider: {
              store: { key: "en-shr_mask" },
              enable: { key: "en-shr_use-mask" },
              factor: 0.1,
            },
          },
        },
      },
      */
    ]),
  }
}