///@package io.alkapivo.visu.editor.ui.controller

///@todo move to VEBrushToolbar
///@static
///@type {Map<String, Callable>}
global.__VisuTemplateContainers = new Map(String, Callable, {
  "bar": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor(),
      }),
      updateTimer: new Timer(FRAME_MS * 2, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      items: {
        "label_bar-title": {
          type: UIText,
          text: "Template toolbar",
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyMargin")),
          font: "font_inter_8_bold",
          color: VETheme.color.textShadow,
          align: { v: VAlign.CENTER, h: HAlign.LEFT },
          offset: { x: 4 },
          backgroundColor: VETheme.color.accentDark,
        }, 
      }
    }
  },
  "type": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.sideShadow).toGMColor(),
        "types": new Array(Struct, [
          {
            name: "button_type-shader",
            template: VEComponents.get("type-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundMargin: { top: 1, bottom: 1, right: 1, left: 1 },
              callback: function() { 
                this.context.templateToolbar.store
                  .get("type")
                  .set(this.templateType)
                
                this.context.templateToolbar.store
                  .get("template")
                  .set(null)

                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
              updateCustom: function() {
                this.backgroundColor = this.templateType == this.context.templateToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: "Shader" },
              templateType: VETemplateType.SHADER,
            },
          },
          {
            name: "button_type-shroom",
            template: VEComponents.get("type-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundMargin: { top: 1, bottom: 1, right: 1, left: 1 },
              callback: function() { 
                this.context.templateToolbar.store
                  .get("type")
                  .set(this.templateType)
                
                this.context.templateToolbar.store
                  .get("template")
                  .set(null)

                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
              updateCustom: function() {
                this.backgroundColor = this.templateType == this.context.templateToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: "Shroom" },
              templateType: VETemplateType.SHROOM,
            },
          },
          {
            name: "button_type-bullet",
            template: VEComponents.get("type-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundMargin: { top: 1, bottom: 1, right: 1, left: 1 },
              callback: function() { 
                this.context.templateToolbar.store
                  .get("type")
                  .set(this.templateType)
                
                this.context.templateToolbar.store
                  .get("template")
                  .set(null)

                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
              updateCustom: function() {
                this.backgroundColor = this.templateType == this.context.templateToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: "Bullet" },
              templateType: VETemplateType.BULLET,
            },
          },
          {
            name: "button_type-coin",
            template: VEComponents.get("type-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundMargin: { top: 1, bottom: 1, right: 1, left: 1 },
              callback: function() { 
                this.context.templateToolbar.store
                  .get("type")
                  .set(this.templateType)
                
                this.context.templateToolbar.store
                  .get("template")
                  .set(null)

                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
              updateCustom: function() {
                this.backgroundColor = this.templateType == this.context.templateToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: "Coin" },
              templateType: VETemplateType.COIN,
            },
          },
          {
            name: "button_type-lyrics",
            template: VEComponents.get("type-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundMargin: { top: 1, bottom: 1, right: 1, left: 1 },
              callback: function() { 
                this.context.templateToolbar.store
                  .get("type")
                  .set(this.templateType)
                
                this.context.templateToolbar.store
                  .get("template")
                  .set(null)

                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
              updateCustom: function() {
                this.backgroundColor = this.templateType == this.context.templateToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: "Sub" },
              templateType: VETemplateType.SUBTITLE,
            },
          },
          {
            name: "button_type-particle",
            template: VEComponents.get("type-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundMargin: { top: 1, bottom: 1, right: 1, left: 1 },
              callback: function() { 
                this.context.templateToolbar.store
                  .get("type")
                  .set(this.templateType)
                
                this.context.templateToolbar.store
                  .get("template")
                  .set(null)

                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
              updateCustom: function() {
                this.backgroundColor = this.templateType == this.context.templateToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: "Particle" },
              templateType: VETemplateType.PARTICLE,
            },
          },
          {
            name: "button_type-texture",
            template: VEComponents.get("type-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundMargin: { top: 1, bottom: 1, right: 1, left: 1 },
              callback: function() { 
                this.context.templateToolbar.store
                  .get("type")
                  .set(this.templateType)
                
                this.context.templateToolbar.store
                  .get("template")
                  .set(null)

                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
              updateCustom: function() {
                this.backgroundColor = this.templateType == this.context.templateToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: "Texture" },
              templateType: VETemplateType.TEXTURE,
            },
          },
        ])
      }),
      updateTimer: new Timer(FRAME_MS * 2, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      onInit: function() {
        var container = this
        this.collection = new UICollection(this, { layout: this.layout })
        this.state
          .set("store", this.templateToolbar.store)
          .get("types")
          .forEach(function(component, index, collection) {
            collection.add(new UIComponent(component))
          }, this.collection)
      },
    }
  },
  "add": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.side).toGMColor(),
        "template_shader": new Array(Struct, [
          {
            name: "button_new-shader-template-title",
            template: VEComponents.get("bar-title"),
            layout: VELayouts.get("bar-title"),
            config: {
              label: { 
                text: "New shader template",
                postRender: function() {
                  var _x = this.context.area.getX() + this.area.getX()
                  var _y = this.context.area.getY() + this.area.getY() - 1
                  var color = ColorUtil.parse(VETheme.color.accentShadow).toGMColor()
                  draw_line_color(_x, _y, _x + this.area.getWidth(), _y, color, color)
                },
              },
              layout: { type: UILayoutType.VERTICAL },
            },
          },
          {
            name: "text-field_new-shader-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { 
                type: UILayoutType.VERTICAL,
                margin: { top: 4, bottom: 4 },
              },
              label: { text: "Name" },
              field: { store: { key: "template_shader_name" } },
            },
          },
          {
            name: "text-field_new-shader-template_shader",
            template: VEComponents.get("spin-select"),
            layout: VELayouts.get("spin-select"),
            config: { 
              layout: { type: UILayoutType.VERTICAL },
              label: { text: "Shader" },
              previous: { store: { key: "shader" } },
              preview: Struct.appendRecursive({ 
                store: { key: "shader" },
                preRender: function() { 
                  Struct.set(this, "_text", this.label.text)
                  this.label.text = String.toUpperCase(String.replaceAll(String.replace(this.label.text, "shader_", ""), "_", " "))
                  if (Struct.get(DEPRECATED_SHADERS, this._text) == true) {
                    this.label.color = ColorUtil.parse("#ffff00").toGMColor()
                    this.label.text = $"{this.label.text}\nDEPRECATED"
                  } else {
                    this.label.color = ColorUtil.parse(VETheme.color.textFocus).toGMColor()
                  }
                },
                postRender: function() { 
                  this.label.text = this._text
                },
              }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
              next: { store: { key: "shader" } },
            },
          },
          {
            name: "button_new-shader-template_add",
            template: VEComponents.get("template-add-button"),
            layout: VELayouts.get("template-add-button"),
            config: {
              label: { text: "Create shader" },
              layout: { type: UILayoutType.VERTICAL },
              callback: function(event) {
                if (Core.isType(GMTFContext.get(), GMTF)) {
                  if (Core.isType(GMTFContext.get().uiItem, UIItem)) {
                    GMTFContext.get().uiItem.update()
                  }
                  GMTFContext.get().unfocus()
                }

                this.context.templateToolbar.send(new Event("add-template"))

                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
            },
          }
        ]),
        "template_shroom": new Array(Struct, [
          {
            name: "button_new-shroom-template-title",
            template: VEComponents.get("bar-title"),
            layout: VELayouts.get("bar-title"),
            config: {
              label: {
                text: "New shroom template",
                postRender: function() {
                  var _x = this.context.area.getX() + this.area.getX()
                  var _y = this.context.area.getY() + this.area.getY() - 1
                  var color = ColorUtil.parse(VETheme.color.accentShadow).toGMColor()
                  draw_line_color(_x, _y, _x + this.area.getWidth(), _y, color, color)
                },
              },
              layout: { type: UILayoutType.VERTICAL },
            },
          },
          {
            name: "text-field_new-shroom-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { 
                type: UILayoutType.VERTICAL,
                margin: { top: 4, bottom: 4 },
              },
              label: { text: "Name" },
              field: { store: { key: "template_shroom_name" } },
            },
          },
          {
            name: "button_new-shroom-template_add",
            template: VEComponents.get("template-add-button"),
            layout: VELayouts.get("template-add-button"),
            config: {
              label: { text: "Create shroom" },
              layout: { type: UILayoutType.VERTICAL },
              callback: function(event) {
                if (Core.isType(GMTFContext.get(), GMTF)) {
                  if (Core.isType(GMTFContext.get().uiItem, UIItem)) {
                    GMTFContext.get().uiItem.update()
                  }
                  GMTFContext.get().unfocus()
                }

                this.context.templateToolbar.send(new Event("add-template"))

                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
            },
          },
        ]),
        "template_bullet": new Array(Struct, [
          {
            name: "button_new-bullet-template-title",
            template: VEComponents.get("bar-title"),
            layout: VELayouts.get("bar-title"),
            config: {
              label: {
                text: "New bullet template",
                postRender: function() {
                  var _x = this.context.area.getX() + this.area.getX()
                  var _y = this.context.area.getY() + this.area.getY() - 1
                  var color = ColorUtil.parse(VETheme.color.accentShadow).toGMColor()
                  draw_line_color(_x, _y, _x + this.area.getWidth(), _y, color, color)
                },
              },
              layout: { type: UILayoutType.VERTICAL },
            },
          },
          {
            name: "text-field_new-bullet-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { 
                type: UILayoutType.VERTICAL,
                margin: { top: 4, bottom: 4 },
              },
              label: { text: "Name" },
              field: { store: { key: "template_bullet_name" } },
            },
          },
          {
            name: "button_new-bullet-template_add",
            template: VEComponents.get("template-add-button"),
            layout: VELayouts.get("template-add-button"),
            config: {
              label: { text: "Create bullet" },
              layout: { type: UILayoutType.VERTICAL },
              callback: function(event) {
                if (Core.isType(GMTFContext.get(), GMTF)) {
                  if (Core.isType(GMTFContext.get().uiItem, UIItem)) {
                    GMTFContext.get().uiItem.update()
                  }
                  GMTFContext.get().unfocus()
                }

                this.context.templateToolbar.send(new Event("add-template"))
                
                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
            },
          },
        ]),
        "template_coin": new Array(Struct, [
          {
            name: "button_new-coin-template-title",
            template: VEComponents.get("bar-title"),
            layout: VELayouts.get("bar-title"),
            config: {
              label: {
                text: "New coin template",
                postRender: function() {
                  var _x = this.context.area.getX() + this.area.getX()
                  var _y = this.context.area.getY() + this.area.getY() - 1
                  var color = ColorUtil.parse(VETheme.color.accentShadow).toGMColor()
                  draw_line_color(_x, _y, _x + this.area.getWidth(), _y, color, color)
                },
              },
              layout: { type: UILayoutType.VERTICAL },
            },
          },
          {
            name: "text-field_new-coin-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { 
                type: UILayoutType.VERTICAL,
                margin: { top: 4, bottom: 4 },
              },
              label: { text: "Name" },
              field: { store: { key: "template_coin_name" } },
            },
          },
          {
            name: "button_new-coin-template_add",
            template: VEComponents.get("template-add-button"),
            layout: VELayouts.get("template-add-button"),
            config: {
              label: { text: "Create coin" },
              layout: { type: UILayoutType.VERTICAL },
              callback: function(event) {
                if (Core.isType(GMTFContext.get(), GMTF)) {
                  if (Core.isType(GMTFContext.get().uiItem, UIItem)) {
                    GMTFContext.get().uiItem.update()
                  }
                  GMTFContext.get().unfocus()
                }

                this.context.templateToolbar.send(new Event("add-template"))
                
                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
            },
          },
        ]),
        "template_subtitle": new Array(Struct, [
          {
            name: "button_new-subtitle-title",
            template: VEComponents.get("bar-title"),
            layout: VELayouts.get("bar-title"),
            config: {
              label: {
                text: "New subtitle asset",
                postRender: function() {
                  var _x = this.context.area.getX() + this.area.getX()
                  var _y = this.context.area.getY() + this.area.getY() - 1
                  var color = ColorUtil.parse(VETheme.color.accentShadow).toGMColor()
                  draw_line_color(_x, _y, _x + this.area.getWidth(), _y, color, color)
                },
              },
              layout: { type: UILayoutType.VERTICAL },
            },
          },
          {
            name: "text-field_new-lyrics-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { 
                type: UILayoutType.VERTICAL,
                margin: { top: 4, bottom: 4 },
              },
              label: { text: "Name" },
              field: { store: { key: "template_subtitle_name" } },
            },
          },
          {
            name: "button_new-lyrics-template_add",
            template: VEComponents.get("template-add-button"),
            layout: VELayouts.get("template-add-button"),
            config: {
              label: { text: "Create subtitle" },
              callback: function(event) {
                if (Core.isType(GMTFContext.get(), GMTF)) {
                  if (Core.isType(GMTFContext.get().uiItem, UIItem)) {
                    GMTFContext.get().uiItem.update()
                  }
                  GMTFContext.get().unfocus()
                }

                this.context.templateToolbar.send(new Event("add-template"))

                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
              layout: { type: UILayoutType.VERTICAL },
              
            },
          },
        ]),
        "template_particle": new Array(Struct, [
          {
            name: "button_new-particle-template-title",
            template: VEComponents.get("bar-title"),
            layout: VELayouts.get("bar-title"),
            config: {
              label: {
                text: "New particle template",
                postRender: function() {
                  var _x = this.context.area.getX() + this.area.getX()
                  var _y = this.context.area.getY() + this.area.getY() - 1
                  var color = ColorUtil.parse(VETheme.color.accentShadow).toGMColor()
                  draw_line_color(_x, _y, _x + this.area.getWidth(), _y, color, color)
                },
              },
              layout: { type: UILayoutType.VERTICAL },
            },
          },
          {
            name: "text-field_new-particle-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { 
                type: UILayoutType.VERTICAL,
                margin: { top: 4, bottom: 4 },
              },
              label: { text: "Name" },
              field: { store: { key: "template_particle_name" } },
            },
          },
          {
            name: "button_new-particle-template_add",
            template: VEComponents.get("template-add-button"),
            layout: VELayouts.get("template-add-button"),
            config: {
              label: { text: "Create particle" },
              layout: { type: UILayoutType.VERTICAL },
              callback: function(event) {
                if (Core.isType(GMTFContext.get(), GMTF)) {
                  if (Core.isType(GMTFContext.get().uiItem, UIItem)) {
                    GMTFContext.get().uiItem.update()
                  }
                  GMTFContext.get().unfocus()
                }

                this.context.templateToolbar.send(new Event("add-template"))
                
                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
            },
          },
        ]),
        "template_texture": new Array(Struct, [
          {
            name: "button_new-texture-title",
            template: VEComponents.get("bar-title"),
            layout: VELayouts.get("bar-title"),
            config: {
              label: {
                text: "New texture asset",
                postRender: function() {
                  var _x = this.context.area.getX() + this.area.getX()
                  var _y = this.context.area.getY() + this.area.getY() - 1
                  var color = ColorUtil.parse(VETheme.color.accentShadow).toGMColor()
                  draw_line_color(_x, _y, _x + this.area.getWidth(), _y, color, color)
                },
              },
              layout: { type: UILayoutType.VERTICAL },
            },
          },
          {
            name: "text-field_new-texture-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { 
                type: UILayoutType.VERTICAL,
                margin: { top: 4, bottom: 0 },
              },
              label: { text: "Name" },
              field: { store: { key: "template_texture_name" } },
            },
          },
          {
            name: "text-field_new-texture-template_file",  
            template: VEComponents.get("text-field-button"),
            layout: VELayouts.get("text-field-button"),
            config: { 
              layout: { type: UILayoutType.VERTICAL },
              label: { text: "Texture" },
              field: { 
                read_only: true,
                updateCustom: function() {
                  var intent = this.context.state.get("store").getValue("texture-intent")
                  if (intent.file != "" && Core.isType(intent.file, String)) {
                    this.textField.setText(FileUtil.getFilenameFromPath(intent.file))
                  } else {
                    this.textField.setText("")
                  }
                },
              },
              button: { 
                label: { text: "Open" },
                callback: function() {
                  var path = FileUtil.getPathToOpenWithDialog({
                    description: "PNG, JPG, BMP file",
                    extension: "png;*.jpg;*.jpeg;*.bmp",
                  })
                  if (!FileUtil.fileExists(path)) {
                    return
                  }
      
                  var intent = this.context.state.get("store").getValue("texture-intent")
                  intent.file = path
                },
                onMouseHoverOver: function(event) {
                  this.backgroundColor = ColorUtil.fromHex(this.colorHoverOver).toGMColor()
                },
                onMouseHoverOut: function(event) {
                  this.backgroundColor = ColorUtil.fromHex(this.colorHoverOut).toGMColor()
                },
              },
            },
          },
          {
            name: "text-field_new-texture-template_frames",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { 
                type: UILayoutType.VERTICAL,
                margin: { bottom: 2 },
              },
              label: { text: "Frames" },
              field: { 
                store: { 
                  key: "texture-intent",
                  set: function(value) { 
                    var parsed = NumberUtil.parse(value)
                    if (!Core.isType(parsed, Number)) {
                      return
                    }
                    
                    var intent = this.context.context.state.get("store")
                      .getValue("texture-intent")
                    if (!Core.isType(intent, TextureIntent)) {
                      return
                    }

                    intent.frames = parsed
                  },
                  callback: function(value, data) { 
                    if (!Core.isType(value, TextureIntent)) {
                      return
                    }
                    
                    data.textField.setText(value.frames)
                  },
                }
              },
            },
          },
          {
            name: "button_new-texture-template_add",
            template: VEComponents.get("template-add-button"),
            layout: VELayouts.get("template-add-button"),
            config: {
              label: { text: "Create texture" },
              layout: { type: UILayoutType.VERTICAL },
              callback: function(event) {
                if (Core.isType(GMTFContext.get(), GMTF)) {
                  if (Core.isType(GMTFContext.get().uiItem, UIItem)) {
                    GMTFContext.get().uiItem.update()
                  }
                  GMTFContext.get().unfocus()
                }

                this.context.templateToolbar.send(new Event("add-template"))

                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
            },
          },
        ]),
      }),      
      updateTimer: new Timer(FRAME_MS * 4, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      notify: true,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      updateCustom: function() {
        ///@hack
        this.layout.context.nodes.add.__height = this.fetchViewHeight()
      },
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      onInit: function() {
        var container = this
        this.collection = new UICollection(this, { layout: this.layout })
        this.templateToolbar.store.get("type").addSubscriber({ 
          name: container.name,
          overrideSubscriber: true,
          callback: function(type, data) {
            data.items.forEach(function(item) { item.free() }).clear() ///@todo replace with remove lambda
            data.collection.components.clear() ///@todo replace with remove lambda
            data.state.set("store", data.templateToolbar.store)
            data.addUIComponents(data.state.get(type)
              .map(function(component) {
                return new UIComponent(component)
              }),
              new UILayout({
                area: data.area,
                width: function() { return this.area.getWidth() },
              })
            )
          },
          data: container
        })
        
      },
      onDestroy: function() {
        this.templateToolbar.store
          .get("type")
          .removeSubscriber(this.name)
      },
    }
  },
  "title": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor(),
      }),
      //updateTimer: new Timer(FRAME_MS * 2, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: function() {
        var color = this.state.get("background-color")
        if (Core.isType(color, GMColor)) {
          GPU.render.rectangle(
            this.area.x, this.area.y, 
            this.area.x + this.area.getWidth(), this.area.y + this.area.getHeight(), 
            false,
            color, color, color, color, 
            this.state.getIfType("background-alpha", Number, 1.0)
          )
        }
        
        this.items.forEach(this.renderItem, this.area)
      },
      items: {
        "label_template-title": {
          type: UIText,
          text: "Templates",
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyMargin")),
          backgroundColor: VETheme.color.sideDark,
          font: "font_inter_8_bold",
          color: VETheme.color.textShadow,
          align: { v: VAlign.CENTER, h: HAlign.LEFT },
          offset: { x: 4 },
          margin: { right: 40 * 4, top: 1 },
          onMousePressedRight: function(event) {
            var editor = Beans.get(BeanVisuEditorController)
            var accordion = editor.accordion
            var node = Struct.get(this.context.layout.context.nodes, "inspector-view")
            var containers = this.context.templateToolbar.containers

            Struct.set(node, "percentageHeight", Struct.get(this, "__expandPercentageHeight") == true ? 0.0 : 1.0)
            Struct.set(accordion.layout.store, "events-percentage", Struct.get(this, "__expandPercentageHeight") == true ? 0.0 : 1.0)
            Struct.set(this, "__percentage", null)
            Struct.set(this, "__expandPercentageHeight", !(Struct.get(this, "__expandPercentageHeight") == true))
            accordion.containers.forEach(accordion.resetUpdateTimer)
            accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
            accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
          },
        },
        "button_template-save": Struct.appendRecursiveUnique(
          {
            type: UIButton,
            label: { 
              font: "font_inter_8_regular",
              text: "Export",
            },
            margin: { top: 1 },
            onMouseHoverOver: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.colorHoverOver).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.colorHoverOut).toGMColor()
            },
            group: { index: 2, size: 4, width: 40 },
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("groupByXWidth")),
            callback: function(event) {
              var view = this.context.templateToolbar.containers
                .get("ve-template-toolbar_template-view")
              if (!Optional.is(view)) {
                return
              }

              var keys = new Map(String, Boolean)
              view.collection.components.filter(function(component, iterator, keys) {
                if (component.getSelected()) {
                  keys.add(true, component.name)
                }
              }, keys)

              if (keys.size() == 0) {
                return
              }

              var type = this.context.templateToolbar.store.getValue("type")

              var templates = null
              var model = null
              var filename = null
              var controller = Beans.get(BeanVisuController)
              switch (type) {
                case VETemplateType.SHADER:
                  templates = controller.shaderPipeline.templates
                  model = "Collection<io.alkapivo.core.service.shader.ShaderTemplate>"
                  filename = "shader"
                  break
                case VETemplateType.SHROOM:
                  templates = controller.shroomService.templates
                  model = "Collection<io.alkapivo.visu.service.shroom.ShroomTemplate>"
                  filename = "shroom"
                  break
                case VETemplateType.BULLET:
                  templates = controller.bulletService.templates
                  model = "Collection<io.alkapivo.visu.service.bullet.BulletTemplate>"
                  filename = "bullet"
                  break
                case VETemplateType.COIN:
                  templates = controller.coinService.templates
                  model = "Collection<io.alkapivo.visu.service.coin.CoinTemplate>"
                  filename = "coin"
                  break
                case VETemplateType.SUBTITLE:
                  templates = controller.subtitleService.templates
                  model = "Collection<io.alkapivo.visu.service.subtitle.SubtitleTemplate>"
                  filename = "subtitle"
                  break
                case VETemplateType.PARTICLE:
                  templates = controller.particleService.templates
                  model = "Collection<io.alkapivo.core.service.particle.ParticleTemplate>"
                  filename = "particle"
                  break
                case VETemplateType.TEXTURE:
                  templates = Beans.get(BeanTextureService).templates
                  model = "Collection<io.alkapivo.core.service.texture.TextureTemplate>"
                  filename = "texture"
                  break
                default:
                  throw new Exception($"Save dispatcher for type '{template.type}' wasn't found")
                  break
              }

              var path = FileUtil.getPathToSaveWithDialog({ 
                description: "JSON file",
                filename: filename, 
                extension: "json",
              })
              
              if (!Core.isType(path, String)) {
                return
              }

              if (!Core.isType(templates, Collection)) {
                return
              }

              templates = templates.filter(function(template, iterator, keys) {
                return keys.get(template.name) == true
              }, keys)

              if (templates.size() == 0) {
                return
              }

              var struct = {}
              templates.forEach(function(template, iterator, struct) {
                Struct.set(struct, template.name, template.serialize())
              }, struct)

              var data = JSON.stringify({
                "model": model,
                "data": struct,
              }, { pretty: true })

              Beans.get(BeanFileService).send(new Event("save-file")
                .setData(new File({
                  path: path,
                  data: data
                })))
            }
          },
          VEStyles.get("bar-button"),
          false
        ),
        "button_template-remove": Struct.appendRecursiveUnique(
          {
            type: UIButton,
            group: { index: 1, size: 4, width: 40 },
            label: { 
              font: "font_inter_8_regular",
              text: "Remove",
            },
            margin: { top: 1 },
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("groupByXWidth")),
            callback: function(event) {
              var view = this.context.templateToolbar.containers
                .get("ve-template-toolbar_template-view")
              if (!Optional.is(view)) {
                return
              }

              var type = this.context.templateToolbar.store.getValue("type")

              var templates = null
              var controller = Beans.get(BeanVisuController)
              switch (type) {
                case VETemplateType.SHADER:
                  templates = controller.shaderPipeline.templates
                  break
                case VETemplateType.SHROOM:
                  templates = controller.shroomService.templates
                  break
                case VETemplateType.BULLET:
                  templates = controller.bulletService.templates
                  break
                case VETemplateType.COIN:
                  templates = controller.coinService.templates
                  break
                case VETemplateType.SUBTITLE:
                  templates = controller.subtitleService.templates
                  break
                case VETemplateType.PARTICLE:
                  templates = controller.particleService.templates
                  break
                case VETemplateType.TEXTURE:
                  templates = Beans.get(BeanTextureService).templates
                  break
                default:
                  throw new Exception($"Remove dispatcher for type '{template.type}' wasn't found")
                  break
              }

              if (!Core.isType(templates, Collection)) {
                return
              }

              var acc = {
                templates: templates,
                gc: new Array(Number),
              }

              view.collection.components.forEach(function(component, key, acc) {
                if (component.getSelected() && !component.isAsset()) {
                  acc.templates.remove(component.getTemplateName())
                  acc.gc.add(component.index)
                }
              }, acc)

              acc.gc
                .sort(function(a, b) { return a > b } )
                .forEach(function(index, gcIndex, collection) {
                  collection.remove(index)
                }, view.collection)
            },
            onMouseHoverOver: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.colorHoverOver).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.colorHoverOut).toGMColor()
            },
          },
          VEStyles.get("bar-button"),
          false
        ),
        "button_template-all": Struct.appendRecursiveUnique(
          {
            type: UIButton,
            group: { index: 0, size: 4, width: 40 },
            label: { 
              font: "font_inter_8_regular",
              text: "Select",
            },
            margin: { top: 1 },
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("groupByXWidth")),
            callback: function(event) {
              var view = this.context.templateToolbar.containers
                .get("ve-template-toolbar_template-view")
              if (!Optional.is(view)) {
                return
              }

              var sum = { value: 0 }
              view.collection.components.forEach(function(component, iterator, sum) {
                if (component.getSelected()) {
                  sum.value++
                }
              }, sum)

              view.collection.components.forEach(function(component, iterator, selected) {
                component.setSelected(selected)
              }, view.collection.size() != sum.value)
            },
            onMouseHoverOver: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.colorHoverOver).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.colorHoverOut).toGMColor()
            },
          },
          VEStyles.get("bar-button"),
          false
        ),
        "button_template-load": Struct.appendRecursiveUnique(
          {
            type: UIButton,
            label: { 
              font: "font_inter_8_regular",
              text: "Import",
            },
            align: { v: VAlign.CENTER, h: HAlign.RIGHT },
            group: { index: 3, size: 4, width: 40 },
            margin: { top: 1 },
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("groupByXWidth")),
            onMouseHoverOver: function(event) {
              var type = this.context.templateToolbar.store.getValue("type")
              if (type == this.enable.key) {
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.colorHoverOver).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.colorHoverOut).toGMColor()
            },
            enable: { 
              key: VETemplateType.TEXTURE,
              value: false,
            },
            updateEnable: function() {
              var type = this.context.templateToolbar.store.getValue("type")
              this.enable.value = type != this.enable.key
            },
            render: function() {
              if (Optional.is(this.preRender)) {
                this.preRender()
              }
              this.renderBackgroundColor()

              var type = this.context.templateToolbar.store.getValue("type")
              if (type == this.enable.key) {
                return
              }

              if (this.sprite != null) {
                var alpha = this.sprite.getAlpha()
                this.sprite
                  .setAlpha(alpha * (Struct.get(this.enable, "value") == false ? 0.5 : 1.0))
                  .scaleToFillStretched(this.area.getWidth(), this.area.getHeight())
                  .render(
                    this.context.area.getX() + this.area.getX(),
                    this.context.area.getY() + this.area.getY())
                  .setAlpha(alpha)
              }
        
              if (this.label != null) {
                this.label.render(
                  // todo VALIGN HALIGN
                  this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                  this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2),
                  this.area.getWidth(),
                  this.area.getHeight()
                )
              }
              return this
            },
            callback: function(_event) {
              var store = this.context.templateToolbar.store
              var type = store.getValue("type")
              var event = new Event("open-file-dialog")
                .setData({
                  description: "JSON file",
                  filename: "template", 
                  extension: "json",
                })
                .setPromise(new Promise())
              
              var controller = Beans.get(BeanVisuController)
              switch (type) {
                case VETemplateType.SHADER:
                  event.data.filename = "shader"
                  event.promise
                    .setState({
                      callback: function(prototype, json, key, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load shader '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.shaderPipeline.templates,
                      steps: MAGIC_NUMBER_TASK,
                      store: store,
                      model: "Collection<io.alkapivo.core.service.shader.ShaderTemplate>",
                    })
                    .whenSuccess(function(result) {
                      if (result == null) {
                        return TaskUtil.factory.dummy()
                      }

                      var task = JSON.parserTask(result.data, this.state)
                      if (task == null) {
                        return TaskUtil.factory.dummy()
                      }

                      task.state.set("store", this.state.store)
                      task.whenFinish(function() {
                        var type = this.state.get("store").get("type")
                        type.set(type.get())
                      })
                      Beans.get(BeanVisuController).executor.add(task)
                      return task
                    })
                  break
                case VETemplateType.SHROOM:
                  event.data.filename = "shroom"
                  event.promise
                    .setState({
                      callback: function(prototype, json, key, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load shroom template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.shroomService.templates,
                      steps: MAGIC_NUMBER_TASK,
                      store: store,
                      model: "Collection<io.alkapivo.visu.service.shroom.ShroomTemplate>",
                    })
                    .whenSuccess(function(result) {
                      if (result == null) {
                        return TaskUtil.factory.dummy()
                      }

                      var task = JSON.parserTask(result.data, this.state)
                      if (task == null) {
                        return TaskUtil.factory.dummy()
                      }

                      task.state.set("store", this.state.store)
                      task.whenFinish(function() {
                        var type = this.state.get("store").get("type")
                        type.set(type.get())
                      })
                      Beans.get(BeanVisuController).executor.add(task)
                      return task
                    })
                  break
                case VETemplateType.BULLET:
                  event.data.filename = "bullet"
                  event.promise
                    .setState({
                      callback: function(prototype, json, key, acc) {
                        Logger.debug("VisuTrackLoader", $"load bullet template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.bulletService.templates,
                      steps: MAGIC_NUMBER_TASK,
                      store: store,
                      model: "Collection<io.alkapivo.visu.service.bullet.BulletTemplate>",
                    })
                    .whenSuccess(function(result) {
                      if (result == null) {
                        return TaskUtil.factory.dummy()
                      }

                      var task = JSON.parserTask(result.data, this.state)
                      if (task == null) {
                        return TaskUtil.factory.dummy()
                      }

                      task.state.set("store", this.state.store)
                      task.whenFinish(function() {
                        var type = this.state.get("store").get("type")
                        type.set(type.get())
                      })
                      Beans.get(BeanVisuController).executor.add(task)
                      return task
                    })
                  break
                case VETemplateType.COIN:
                  event.data.filename = "coin"
                  event.promise
                    .setState({
                      callback: function(prototype, json, key, acc) {
                        Logger.debug("VisuTrackLoader", $"load coin template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.coinService.templates,
                      steps: MAGIC_NUMBER_TASK,
                      store: store,
                      model: "Collection<io.alkapivo.visu.service.coin.CoinTemplate>",
                    })
                    .whenSuccess(function(result) {
                      if (result == null) {
                        return TaskUtil.factory.dummy()
                      }

                      var task = JSON.parserTask(result.data, this.state)
                      if (task == null) {
                        return TaskUtil.factory.dummy()
                      }

                      task.state.set("store", this.state.store)
                      task.whenFinish(function() {
                        var type = this.state.get("store").get("type")
                        type.set(type.get())
                      })
                      Beans.get(BeanVisuController).executor.add(task)
                      return task
                    })
                  break
                case VETemplateType.SUBTITLE:
                  event.data.filename = "subtitle"
                  event.promise
                    .setState({
                      callback: function(prototype, json, key, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load subtitle template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.subtitleService.templates,
                      steps: MAGIC_NUMBER_TASK,
                      store: store,
                      model: "Collection<io.alkapivo.visu.service.subtitle.SubtitleTemplate>",
                    })
                    .whenSuccess(function(result) {
                      if (result == null) {
                        return TaskUtil.factory.dummy()
                      }

                      var task = JSON.parserTask(result.data, this.state)
                      if (task == null) {
                        return TaskUtil.factory.dummy()
                      }

                      task.state.set("store", this.state.store)
                      task.whenFinish(function() {
                        var type = this.state.get("store").get("type")
                        type.set(type.get())
                      })
                      Beans.get(BeanVisuController).executor.add(task)
                      return task
                    })
                  break
                case VETemplateType.PARTICLE:
                  event.data.filename = "particle"
                  event.promise
                    .setState({
                      callback: function(prototype, json, key, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load particle template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.particleService.templates,
                      steps: MAGIC_NUMBER_TASK,
                      store: store,
                      model: "Collection<io.alkapivo.core.service.particle.ParticleTemplate>",
                    })
                    .whenSuccess(function(result) {
                      if (result == null) {
                        return TaskUtil.factory.dummy()
                      }

                      var task = JSON.parserTask(result.data, this.state)
                      if (task == null) {
                        return TaskUtil.factory.dummy()
                      }

                      task.state.set("store", this.state.store)
                      task.whenFinish(function() {
                        var type = this.state.get("store").get("type")
                        type.set(type.get())
                      })
                      Beans.get(BeanVisuController).executor.add(task)
                      return task
                    })
                  break
                case VETemplateType.TEXTURE:
                  Logger.warn("VETemplate", $"Load type '{VETemplateType.TEXTURE}' is not supported")
                  return
                default:
                  var message = $"Load dispatcher for type '{type}' wasn't found"
                  Logger.error("VETemplate", message)
                  throw new Exception(message)
                  break
              }

              var promise = Beans.get(BeanFileService).send(event)
            }
          },
          VEStyles.get("bar-button"),
          false
        ),
      }
    }
  },
  "template-view": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.side).toGMColor(),
      }),
      updateTimer: new Timer(FRAME_MS * Core.getProperty("visu.editor.ui.template-toolbar.template-view.updateTimer", 30), { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      executor: null,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("scrollableY")),
      yOffset: null,
      updateCustom: function() {
        if (this.yOffset == null) {
          this.yOffset = this.offset.y
        }

        this.yOffset = this.offset.y
      },
      updateVerticalSelectedIndex: new BindIntent(Callable.run(UIUtil.templates.get("updateVerticalSelectedIndex"))),
      renderItem: Callable.run(UIUtil.renderTemplates.get("renderItemDefaultScrollable")),
      __render: new BindIntent(Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollable"))),
      render: function() {
        if (this.executor != null) {
          this.executor.update()
        }

        this.updateVerticalSelectedIndex(32.0)
        this.__render()
      },
      scrollbarY: { align: HAlign.LEFT },
      notify: true,
      fetchViewHeight: function() {
        return 32 * this.collection.size()
      },
      onMousePressedLeft: Callable.run(UIUtil.mouseEventTemplates.get("onMouseScrollbarY")),
      onMouseWheelUp: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelUpY")),
      onMouseWheelDown: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelDownY")),
      onInit: function() {
        this.executor = new TaskExecutor(this, {
          enableLogger: true,
          catchException: false,
        })

        var container = this
        this.collection = new UICollection(this, { layout: this.layout })
        this.templateToolbar.store.get("type").addSubscriber({ 
          name: container.name,
          overrideSubscriber: true,
          callback: function(type, data) {
            data.items.forEach(function(item) { item.free() }).clear() ///@todo replace with remove lambda
            data.collection.components.clear() ///@todo replace with remove lambda

            var task = null
            switch (type) {
              case VETemplateType.SHADER:
                task = new Task("load-shader-templates")
                  .setState({
                    inspector: data.templateToolbar.containers.get("ve-template-toolbar_inspector-view"),
                    collection: data.collection,
                    templates: Beans.get(BeanVisuController).shaderPipeline.templates,
                    templateNames: new Queue(String, GMArray.sort(Beans.get(BeanVisuController).shaderPipeline.templates
                      .keys().getContainer())),
                    assets: Visu.assets().shaderTemplates,
                    assetNames: new Queue(String, GMArray.sort(Visu.assets().shaderTemplates
                      .keys().getContainer())),
                    stage: "parseTemplate",
                    context: data,
                    parseTemplate: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.templateNames.size() == 0) {
                          task.state.stage = "parseAsset"
                          return
                        }
  
                        var template = task.state.templates.get(task.state.templateNames.pop())
                        if (!Optional.is(template)) {
                          continue
                        }

                        task.state.collection.add(new UIComponent({
                          name: template.name,
                          template: VEComponents.get("template-entry"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: { 
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: false,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var shader = Beans.get(BeanVisuController).shaderPipeline.templates
                                  .get(this.templateName)
                                if (!Core.isType(shader, ShaderTemplate)) {
                                  return
                                }
                
                                Struct.set(shader, "type", VETemplateType.SHADER)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(shader))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    parseAsset: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.assetNames.size() == 0) {
                          task.state.stage = "finish"
                          return
                        }

                        var template = task.state.assets.get(task.state.assetNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: $"z@{template.name}",
                          template: VEComponents.get("template-entry-lock"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: {
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: true,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var shader = Visu.assets().shaderTemplates.get(this.templateName)
                                if (!Core.isType(shader, ShaderTemplate)) {
                                  return
                                }
                  
                                Struct.set(shader, "type", VETemplateType.SHADER)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(shader))
                              },
                              templateName: template.name,
                            }, 
                          },
                        }))
                      }
                    },
                    finish: function(task) {
                      task.fullfill()
                      task.state.inspector.finishUpdateTimer()
                    },
                  })
                  .whenUpdate(function(executor) {
                    var handler = Struct.get(this.state, this.state.stage)
                    handler(this)
                  })
                break
              case VETemplateType.SHROOM:
                task = new Task("load-shroom-templates")
                  .setState({
                    inspector: data.templateToolbar.containers.get("ve-template-toolbar_inspector-view"),
                    collection: data.collection,
                    templates: Beans.get(BeanVisuController).shroomService.templates,
                    templateNames: new Queue(String, GMArray.sort(Beans.get(BeanVisuController).shroomService.templates
                      .keys().getContainer())),
                    assets: Visu.assets().shroomTemplates,
                    assetNames: new Queue(String, GMArray.sort(Visu.assets().shroomTemplates
                      .keys().getContainer())),
                    stage: "parseTemplate",
                    context: data,
                    parseTemplate: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.templateNames.size() == 0) {
                          task.state.stage = "parseAsset"
                          return
                        }
  
                        var template = task.state.templates.get(task.state.templateNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: template.name,
                          template: VEComponents.get("template-entry"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                              settings: { 
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: false,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var shroom = Beans.get(BeanVisuController).shroomService
                                  .getTemplate(this.templateName)
                                if (!Core.isType(shroom, ShroomTemplate)) {
                                  return
                                }
                
                                Struct.set(shroom, "type", VETemplateType.SHROOM)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(shroom))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    parseAsset: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.assetNames.size() == 0) {
                          task.state.stage = "finish"
                          return
                        }

                        var template = task.state.assets.get(task.state.assetNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: $"z@{template.name}",
                          template: VEComponents.get("template-entry-lock"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: {
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: true,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var shroom = Visu.assets().shroomTemplates.get(this.templateName)
                                if (!Core.isType(shroom, ShroomTemplate)) {
                                  return
                                }
                  
                                Struct.set(shroom, "type", VETemplateType.SHROOM)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(shroom))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    finish: function(task) {
                      task.fullfill()
                      task.state.inspector.finishUpdateTimer()
                    },
                  })
                  .whenUpdate(function(executor) {
                    var handler = Struct.get(this.state, this.state.stage)
                    handler(this)
                  })
                break
              case VETemplateType.BULLET:
                task = new Task("load-bullet-templates")
                  .setState({
                    inspector: data.templateToolbar.containers.get("ve-template-toolbar_inspector-view"),
                    collection: data.collection,
                    templates: Beans.get(BeanVisuController).bulletService.templates,
                    templateNames: new Queue(String, GMArray.sort(Beans.get(BeanVisuController).bulletService.templates
                      .keys().getContainer())),
                    assets: Visu.assets().bulletTemplates,
                    assetNames: new Queue(String, GMArray.sort(Visu.assets().bulletTemplates
                      .keys().getContainer())),
                    stage: "parseTemplate",
                    context: data,
                    parseTemplate: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.templateNames.size() == 0) {
                          task.state.stage = "parseAsset"
                          return
                        }
  
                        var template = task.state.templates.get(task.state.templateNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: template.name,
                          template: VEComponents.get("template-entry"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: { 
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: false,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var bullet = Beans.get(BeanVisuController).bulletService
                                  .getTemplate(this.templateName)
                                if (!Core.isType(bullet, BulletTemplate)) {
                                  return
                                }
                
                                Struct.set(bullet, "type", VETemplateType.BULLET)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(bullet))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    parseAsset: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.assetNames.size() == 0) {
                          task.state.stage = "finish"
                          return
                        }

                        var template = task.state.assets.get(task.state.assetNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: $"z@{template.name}",
                          template: VEComponents.get("template-entry-lock"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: {
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: true,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var bullet = Visu.assets().bulletTemplates.get(this.templateName)
                                if (!Core.isType(bullet, BulletTemplate)) {
                                  return
                                }
                  
                                Struct.set(bullet, "type", VETemplateType.BULLET)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(bullet))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    finish: function(task) {
                      task.fullfill()
                      task.state.inspector.finishUpdateTimer()
                    },
                  })
                  .whenUpdate(function(executor) {
                    var handler = Struct.get(this.state, this.state.stage)
                    handler(this)
                  })
                break
              case VETemplateType.COIN:
                task = new Task("load-coin-templates")
                  .setState({
                    inspector: data.templateToolbar.containers.get("ve-template-toolbar_inspector-view"),
                    collection: data.collection,
                    templates: Beans.get(BeanVisuController).coinService.templates,
                    templateNames: new Queue(String, GMArray.sort(Beans.get(BeanVisuController).coinService.templates
                      .keys().getContainer())),
                    assets: Visu.assets().coinTemplates,
                    assetNames: new Queue(String, GMArray.sort(Visu.assets().coinTemplates
                      .keys().getContainer())),
                    stage: "parseTemplate",
                    context: data,
                    parseTemplate: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.templateNames.size() == 0) {
                          task.state.stage = "parseAsset"
                          return
                        }
  
                        var template = task.state.templates.get(task.state.templateNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: template.name,
                          template: VEComponents.get("template-entry"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: { 
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: false,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            remove: { 
                              callback: function() {
                                this.removeUIItemfromUICollection()
                                Beans.get(BeanVisuController).coinService.templates
                                  .remove(this.templateName)
                              },
                              templateName: template.name,
                              removeUIItemfromUICollection: new BindIntent(Callable
                                .run(UIUtil.templates.get("removeUIItemfromUICollection"))),
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var coin = Beans.get(BeanVisuController).coinService
                                  .getTemplate(this.templateName)
                                if (!Core.isType(coin, CoinTemplate)) {
                                  return
                                }
    
                                Struct.set(coin, "type", VETemplateType.COIN)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(coin))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    parseAsset: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.assetNames.size() == 0) {
                          task.state.stage = "finish"
                          return
                        }

                        var template = task.state.assets.get(task.state.assetNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: $"z@{template.name}",
                          template: VEComponents.get("template-entry-lock"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: {
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: true,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var coin = Visu.assets().coinTemplates.get(this.templateName)
                                if (!Core.isType(coin, CoinTemplate)) {
                                  return
                                }
      
                                Struct.set(coin, "type", VETemplateType.COIN)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(coin))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    finish: function(task) {
                      task.fullfill()
                      task.state.inspector.finishUpdateTimer()
                    },
                  })
                  .whenUpdate(function(executor) {
                    var handler = Struct.get(this.state, this.state.stage)
                    handler(this)
                  })
                break
              case VETemplateType.SUBTITLE:
                task = new Task("load-subtitle-templates")
                  .setState({
                    inspector: data.templateToolbar.containers.get("ve-template-toolbar_inspector-view"),
                    collection: data.collection,
                    templates: Beans.get(BeanVisuController).subtitleService.templates,
                    templateNames: new Queue(String, GMArray.sort(Beans.get(BeanVisuController).subtitleService.templates
                      .keys().getContainer())),
                    assets: Visu.assets().subtitleTemplates,
                    assetNames: new Queue(String, GMArray.sort(Visu.assets().subtitleTemplates
                      .keys().getContainer())),
                    stage: "parseTemplate",
                    context: data,
                    parseTemplate: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.templateNames.size() == 0) {
                          task.state.stage = "parseAsset"
                          return
                        }
  
                        var template = task.state.templates.get(task.state.templateNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: template.name,
                          template: VEComponents.get("template-entry"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: { 
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: false,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var subtitle = Beans.get(BeanVisuController).subtitleService
                                  .getTemplate(this.templateName)
                                if (!Core.isType(subtitle, SubtitleTemplate)) {
                                  return
                                }
                
                                Struct.set(subtitle, "type", VETemplateType.SUBTITLE)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(subtitle))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    parseAsset: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.assetNames.size() == 0) {
                          task.state.stage = "finish"
                          return
                        }

                        var template = task.state.assets.get(task.state.assetNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: $"z@{template.name}",
                          template: VEComponents.get("template-entry-lock"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: {
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: true,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var subtitle = Visu.assets().subtitleTemplates.get(this.templateName)
                                if (!Core.isType(subtitle, SubtitleTemplate)) {
                                  return
                                }
                  
                                Struct.set(subtitle, "type", VETemplateType.SUBTITLE)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(subtitle))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    finish: function(task) {
                      task.fullfill()
                      task.state.inspector.finishUpdateTimer()
                    },
                  })
                  .whenUpdate(function(executor) {
                    var handler = Struct.get(this.state, this.state.stage)
                    handler(this)
                  })
                break
              case VETemplateType.PARTICLE:
                task = new Task("load-particle-templates")
                  .setState({
                    inspector: data.templateToolbar.containers.get("ve-template-toolbar_inspector-view"),
                    collection: data.collection,
                    templates: Beans.get(BeanVisuController).particleService.templates,
                    templateNames: new Queue(String, GMArray.sort(Beans.get(BeanVisuController).particleService.templates
                      .keys().getContainer())),
                    assets: Visu.assets().particleTemplates,
                    assetNames: new Queue(String, GMArray.sort(Visu.assets().particleTemplates
                      .keys().getContainer())),
                    stage: "parseTemplate",
                    context: data,
                    parseTemplate: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.templateNames.size() == 0) {
                          task.state.stage = "parseAsset"
                          return
                        }
  
                        var template = task.state.templates.get(task.state.templateNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: template.name,
                          template: VEComponents.get("template-entry"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: { 
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: false,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var particle = Beans.get(BeanVisuController).particleService
                                  .getTemplate(this.templateName)
                                if (!Core.isType(particle, ParticleTemplate)) {
                                  return
                                }
                
                                Struct.set(particle, "type", VETemplateType.PARTICLE)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(particle))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    parseAsset: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.assetNames.size() == 0) {
                          task.state.stage = "finish"
                          return
                        }

                        var template = task.state.assets.get(task.state.assetNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: $"z@{template.name}",
                          template: VEComponents.get("template-entry-lock"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: {
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: true,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var particle = Visu.assets().particleTemplates.get(this.templateName)
                                if (!Core.isType(particle, ParticleTemplate)) {
                                  return
                                }
                  
                                Struct.set(particle, "type", VETemplateType.PARTICLE)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(particle))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    finish: function(task) {
                      task.fullfill()
                      task.state.inspector.finishUpdateTimer()
                    },
                  })
                  .whenUpdate(function(executor) {
                    var handler = Struct.get(this.state, this.state.stage)
                    handler(this)
                  })
                break
              case VETemplateType.TEXTURE:
                task = new Task("load-textures")
                  .setState({
                    inspector: data.templateToolbar.containers.get("ve-template-toolbar_inspector-view"),
                    collection: data.collection,
                    templates: Beans.get(BeanTextureService).templates,
                    templateNames: new Queue(String, GMArray.sort(Beans.get(BeanTextureService).templates
                      .keys().getContainer())),
                    assets: Visu.assets().textures,
                    assetNames: new Queue(String, GMArray.sort(Visu.assets().textures
                      .keys().getContainer())),
                    stage: "parseTemplate",
                    parseTemplate: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.templateNames.size() == 0) {
                          task.state.stage = "parseAsset"
                          return
                        }
  
                        var template = task.state.templates.get(task.state.templateNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: template.name,
                          template: VEComponents.get("template-entry"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: { 
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: false,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var texture = Beans.get(BeanTextureService)
                                  .getTemplate(this.templateName)
                                if (!Core.isType(texture, TextureTemplate)) {
                                  return
                                }
                
                                Struct.set(texture, "type", VETemplateType.TEXTURE)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(texture))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    parseAsset: function(task) {
                      repeat (TEMPLATE_ENTRY_STEP) {
                        if (task.state.assetNames.size() == 0) {
                          task.state.stage = "finish"
                          return
                        }

                        var template = task.state.assets.get(task.state.assetNames.pop())
                        task.state.collection.add(new UIComponent({
                          name: $"z@{template.name}",
                          template: VEComponents.get("template-entry-lock"),
                          layout: VELayouts.get("template-entry"),
                          config: {
                            settings: {
                              sprite: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              spriteOn: {
                                name: "visu_texture_checkbox_on",
                                blend: VETheme.color.textFocus,
                              },
                              spriteOff: {
                                name: "visu_texture_checkbox_off",
                                blend: VETheme.color.textShadow,
                              },
                              selected: false,
                              isAsset: true,
                              templateName: template.name,
                              callback: function() {
                                this.component.setSelected(!this.component.getSelected())
                              },
                              onComponentInit: function(component) {
                                var setSelected = method(this, function(selected) {
                                  this.selected = selected
                                  this.sprite = SpriteUtil.parse(selected ? this.spriteOn : this.spriteOff)
                                })

                                var getSelected = method(this, function() {
                                  return this.selected
                                })

                                var isAsset = method(this, function() {
                                  return this.isAsset
                                })

                                var getTemplateName = method(this, function() {
                                  return this.templateName
                                })

                                Struct.set(component, "setSelected", setSelected)
                                Struct.set(component, "getSelected", getSelected)
                                Struct.set(component, "isAsset", isAsset)
                                Struct.set(component, "getTemplateName", getTemplateName)
                              },
                            },
                            label: { 
                              text: template.name,
                              onMouseReleasedLeft: function() {
                                var texture = Visu.assets().textures.get(this.templateName)
                                if (!Core.isType(texture, TextureTemplate)) {
                                  return
                                }
                  
                                Struct.set(texture, "type", VETemplateType.TEXTURE)
                                this.context.templateToolbar.store
                                  .get("template")
                                  .set(new VETemplate(texture))
                              },
                              templateName: template.name,
                            },
                          },
                        }))
                      }
                    },
                    finish: function(task) {
                      task.fullfill()
                      task.state.inspector.finishUpdateTimer()
                    },
                  })
                  .whenUpdate(function(executor) {
                    var handler = Struct.get(this.state, this.state.stage)
                    handler(this)
                  })
                break
              default:
                Logger.warn(
                  "VETemplateToolbar", 
                  $"template-view dispatcher for type '{type}' wasn't found"
                )
                break
            }

            if (Core.isType(task, Task)) {
              data.executor.tasks.clear()
              data.executor.add(task)
            }
          },
          data: container
        })
      },
      onDestroy: function() {
        this.templateToolbar.store
          .get("type")
          .removeSubscriber(this.name)
      },
    }
  },
  "inspector-bar": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor(),
      }),
      updateTimer: new Timer(FRAME_MS * 2, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      items: {
        "label_inspector-bar-title": Struct.appendRecursiveUnique(
          {
            type: UIText,
            text: "Template inspector",
            clipboard: {
              name: "resize_template_inspector",
              drag: function() {
                Beans.get(BeanVisuController).displayService.setCursor(Cursor.RESIZE_VERTICAL)
              },
              drop: function() {
                Beans.get(BeanVisuController).displayService.setCursor(Cursor.DEFAULT)
              }
            },
            margin: { top: 1 },
            __percentage: null,
            __update: new BindIntent(Callable.run(UIUtil.updateAreaTemplates.get("applyMargin"))),
            updateCustom: function() {
              this.__update()
              if (Beans.get(BeanVisuEditorIO).mouse.getClipboard() == this.clipboard) {
                this.updateLayout(MouseUtil.getMouseY())
                this.context.templateToolbar.containers.forEach(function(container) {
                  if (!Optional.is(container.updateTimer)) {
                    return
                  }
                  
                  container.surfaceTick.skip()
                  container.updateTimer.time = container.updateTimer.duration + random(container.updateTimer.duration / 2.0)
                })

                if (!mouse_check_button(mb_left)) {
                  Beans.get(BeanVisuEditorIO).mouse.clearClipboard()
                  Beans.get(BeanVisuController).displayService.setCursor(Cursor.DEFAULT)
                }
              } else {
                var editor = Beans.get(BeanVisuEditorController)
                var percentage = Struct.get(editor.accordion.layout.store, "events-percentage")
                if (this.__percentage != percentage) {
                  this.__percentage = percentage

                  var uiService = Beans.get(BeanVisuEditorController).uiService
                  var titleBar = uiService.find("ve-title-bar")
                  var statusBar = uiService.find("ve-status-bar")

                  var barNode = Struct.get(this.context.layout.context.nodes, "bar")
                  var typeNode = Struct.get(this.context.layout.context.nodes, "type")
                  var addNode = Struct.get(this.context.layout.context.nodes, "add")
                  var titleNode = Struct.get(this.context.layout.context.nodes, "title")
                  var templateViewNode = Struct.get(this.context.layout.context.nodes, "template-view")
                  var controlNode = Struct.get(this.context.layout.context.nodes, "control")
                  var inspectorNode = Struct.get(this.context.layout.context.nodes, "inspector-view")
                  var nodes = editor.accordion.layout.nodes
                  var viewEventInspectorNode = Struct.get(nodes, "view_event-inspector")
                  var timelineNode = editor.layout.nodes.timeline
                  
                  var top = titleBar.layout.height() + titleBar.margin.top + titleBar.margin.bottom
                    + barNode.height() + barNode.__margin.top + barNode.__margin.bottom
                    + typeNode.height() + typeNode.__margin.top + typeNode.__margin.bottom
                    + addNode.height() + addNode.__margin.top + addNode.__margin.bottom
                    + titleNode.height() + titleNode.__margin.top + titleNode.__margin.bottom
                  var bottom = GuiHeight()
                    - statusBar.layout.height() 
                    - (timelineNode.height() + timelineNode.__margin.top + timelineNode.__margin.bottom)
                    - (controlNode.height() + controlNode.__margin.top + controlNode.__margin.bottom)
                    - viewEventInspectorNode.height() - viewEventInspectorNode.__margin.top - viewEventInspectorNode.__margin.bottom
                  var length = bottom - top

                  inspectorNode.percentageHeight = clamp(inspectorNode.percentageHeight, (8.0 / length), 1.0 - (8.0 / length))
                  templateViewNode.percentageHeight = 1.0 - inspectorNode.percentageHeight
                  this.context.surfaceTick.skip()
                }
              }
            },
            updateLayout: new BindIntent(function(mouseY) {
              var uiService = Beans.get(BeanVisuEditorController).uiService
              var titleBar = uiService.find("ve-title-bar")
              var statusBar = uiService.find("ve-status-bar")

              var barNode = Struct.get(this.context.layout.context.nodes, "bar")
              var typeNode = Struct.get(this.context.layout.context.nodes, "type")
              var addNode = Struct.get(this.context.layout.context.nodes, "add")
              var titleNode = Struct.get(this.context.layout.context.nodes, "title")
              var templateViewNode = Struct.get(this.context.layout.context.nodes, "template-view")
              var controlNode = Struct.get(this.context.layout.context.nodes, "control")
              var inspectorNode = Struct.get(this.context.layout.context.nodes, "inspector-view")
              var editor = Beans.get(BeanVisuEditorController)
              var nodes = editor.accordion.layout.nodes
              var viewEventInspectorNode = Struct.get(nodes, "view_event-inspector")
              var timelineNode = editor.layout.nodes.timeline
              
              var top = titleBar.layout.height() + titleBar.margin.top + titleBar.margin.bottom
                + barNode.height() + barNode.__margin.top + barNode.__margin.bottom
                + typeNode.height() + typeNode.__margin.top + typeNode.__margin.bottom
                + addNode.height() + addNode.__margin.top + addNode.__margin.bottom
                + titleNode.height() + titleNode.__margin.top + titleNode.__margin.bottom
              var bottom = GuiHeight()
                - statusBar.layout.height() 
                - (timelineNode.height() + timelineNode.__margin.top + timelineNode.__margin.bottom)
                - (controlNode.height() + controlNode.__margin.top + controlNode.__margin.bottom)
                - viewEventInspectorNode.height() - viewEventInspectorNode.__margin.top - viewEventInspectorNode.__margin.bottom
              var length = bottom - top
              var position = clamp(mouseY - top, 4.0, length - 4.0)

              inspectorNode.percentageHeight = clamp((length - position) / length, ((8.0) / length), 1.0 - ((8.0) / length))
              templateViewNode.percentageHeight = 1.0 - inspectorNode.percentageHeight
              this.context.surfaceTick.skip()
            }),
            onMousePressedLeft: function(event) {
              Beans.get(BeanVisuEditorIO).mouse.setClipboard(this.clipboard)
            },
            onMousePressedRight: function(event) {
              var editor = Beans.get(BeanVisuEditorController)
              var accordion = editor.accordion
              var node = Struct.get(this.context.layout.context.nodes, "inspector-view")
              var containers = this.context.templateToolbar.containers

              Struct.set(node, "percentageHeight", Struct.get(this, "__expandPercentageHeight") == true ? 0.0 : 1.0)
              Struct.set(this, "__percentage", null)
              Struct.set(this, "__expandPercentageHeight", !(Struct.get(this, "__expandPercentageHeight") == true))
              this.updateCustom()
              accordion.containers.forEach(accordion.resetUpdateTimer)
              accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
              accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
            },
            onMouseHoverOver: function(event) {
              if (!mouse_check_button(mb_left)) {
                this.clipboard.drag()
              }
            },
            onMouseHoverOut: function(event) {
              if (!mouse_check_button(mb_left)) {
                this.clipboard.drop()
              }
            },
          },
          VEStyles.get("bar-title"),
          false
        ),
      }
    }
  },
  "inspector-view": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.side).toGMColor(),
        "surface-alpha": 1.0,
      }),
      updateTimer: new Timer(FRAME_MS * Core.getProperty("visu.editor.ui.template-toolbar.inspector-view.updateTimer", 30), { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      executor: null,
      instantSubscribe: false,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("scrollableY")),
      updateCustom: function() {
        var previousOffset = this.state.get("previousOffset");
        if (previousOffset != null) {
          this.offset.x = previousOffset.x
          this.offset.y = previousOffset.y
          this.offsetMax.x = previousOffset.xMax
          this.offsetMax.y = previousOffset.yMax
          this.state.remove("previousOffset")
        }
      },
      renderItem: Callable.run(UIUtil.renderTemplates.get("renderItemDefaultScrollable")),
      renderDefaultScrollable: new BindIntent(Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollableAlpha"))),
      render: function() {
        if (this.executor != null) {
          this.executor.update()
        }

        var surfaceAlpha = this.state.getIfType("surface-alpha", Number, 1.0)
        //if (this.executor.tasks.size() > 0) {
        //  //this.state.set("surface-alpha", clamp(surfaceAlpha - DeltaTime.apply(0.066), 0.5, 1.0))
        //} else 
        if (surfaceAlpha < 1.0) {
          this.state.set("surface-alpha", clamp(surfaceAlpha + DeltaTime.apply(0.066), 0.0, 1.0))
        }

        this.renderDefaultScrollable()
        return this
      },
      scrollbarY: { align: HAlign.LEFT },
      notify: true,
      onMouseOnLeft: Callable.run(UIUtil.mouseEventTemplates.get("onMouseScrollbarY")),
      onMousePressedLeft: Callable.run(UIUtil.mouseEventTemplates.get("onMouseScrollbarY")),
      onMouseWheelUp: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelUpY")),
      onMouseWheelDown: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelDownY")),
      onInit: function() {
        var container = this
        this.executor = new TaskExecutor(this, {
          enableLogger: true,
          catchException: false,
        })

        this.collection = new UICollection(this, { layout: container.layout })
        this.templateToolbar.store.get("template").addSubscriber({ 
          name: container.name,
          overrideSubscriber: true,
          callback: function(template, data) {
            if (!Core.isType(template, VETemplate)) {
              data.items.forEach(function(item) { item.free() }).clear() 
              data.collection.components.clear()
              data.state
                .set("template", null)
                .set("store", null)
              return
            }
            
            var oldTemplate = data.state.get("template")
            data.state
              .set("template", template)
              .set("store", template.store)

            var shaderResult = true
            if (template.type == VETemplateType.SHADER && oldTemplate != null) {
              var oldShader = oldTemplate.store.getValue("template-shader-asset") 
              var newShader = template.store.getValue("template-shader-asset")
              shaderResult = oldShader == newShader
            }
            
            if (1 == 2 && Struct.get(oldTemplate, "type") == template.type && shaderResult) {
              data.executor.tasks
                .forEach(TaskUtil.fullfillByName, "sync-ui-store")
                .forEach(TaskUtil.fullfillByName, "init-ui-components")

              var task = new Task("sync-ui-store")
                .setTimeout(60.0)
                .setState({
                  context: data,
                  template: template,
                  itemKeys: new Queue(String, data.items.keys().getContainer()),
                  templateKeys: new Queue(String, template.store.container.keys().getContainer()),
                  subscribersConfig: {
                    name: data.name,
                    overrideSubscriber: true,
                    callback: Lambda.passthrough,
                  },
                  stage: "update-store",
                  stages: {
                    "update-store": function(task) {
                      if (task.state.itemKeys.size() == 0) {
                        task.state.stage = "add-subscriber"
                        return
                      }

                      var key = task.state.itemKeys.pop()
                      var item = task.state.context.items.get(key)
                      if (item != null) {
                        item.updateStore()
                      }
                    },
                    "add-subscriber": function(task) {
                      if (task.state.templateKeys.size() == 0) {
                        task.fullfill()
                        return
                      }

                      var key = task.state.templateKeys.pop()
                      var item = task.state.template.store.get(key)
                      if (item != null) {
                        item.addSubscriber(task.state.subscribersConfig)
                      }
                    },
                  }
                })
                .whenUpdate(function() {
                  repeat (SYNC_UI_STORE_STEP) {
                    var stage = Struct.get(this.state.stages, this.state.stage)
                    stage(this)

                    if (this.status == TaskStatus.FULLFILLED) {
                      break
                    }
                  }
                  return this
                })
                
              data.executor.add(task)
            } else {
              data.items.forEach(function(item) { item.free() }).clear()
              data.collection.components.clear()

              data.executor.tasks
                .forEach(TaskUtil.fullfillByName, "sync-ui-store")
                .forEach(TaskUtil.fullfillByName, "init-ui-components")
              
              var task = new Task("init-ui-components")
                .setTimeout(60)
                .setState({
                  context: data,
                  stage: "intro-cooldown",//"load-components",
                  flip: FLIP_VALUE,
                  components: template.components,
                  componentsQueue: new Queue(String, GMArray
                    .map(template.components.getContainer(), function(component, index) { 
                      return index 
                    })),
                  componentsConfig: {
                    context: data,
                    layout: new UILayout({
                      area: data.area,
                      width: function() { return this.area.getWidth() },
                    }),
                    textField: null,
                    updateArea: Core.getProperty("visu.editor.ui.template-toolbar.inspector-view.init-ui-contanier.updateArea", true),
                  },
                  previousOffset: {
                    x: data.offset.x,
                    y: data.offset.y,
                    xMax: data.offsetMax.x,
                    yMax: data.offsetMax.y,
                  },
                  cooldown: new Timer(FRAME_MS * Core.getProperty("visu.editor.ui.template-toolbar.inspector-view.init-ui-contanier.cooldown", 4)),
                  "intro-cooldown": function(task) {
                    if (task.state.cooldown.update().finished) {
                      task.state.stage = "load-components"
                    }
                  },
                  "load-components": function(task) {
                    repeat (TEMPLATE_TOOLBAR_ENTRY_STEP) {
                      if (task.state.flip > 0) {
                        task.state.flip -= 1
                        break
                      } else {
                        task.state.flip = FLIP_VALUE
                      }

                      var index = task.state.componentsQueue.pop()
                      if (!Optional.is(index)) {
                        task.fullfill()
                        task.state.context.state.set("previousOffset", task.state.previousOffset)
                        task.state.context.finishUpdateTimer()
                        task.state.context.areaWatchdog.signal()
                        break
                      }
    
                      var component = new UIComponent(task.state.components.get(index))
                      task.state.context.addUIComponent(component, index, task.state.componentsConfig)
                    }
                  },
                })
                .whenUpdate(function() {
                  var stage = Struct.get(this.state, this.state.stage)
                  stage(this)
                  return this
                })
              
              data.state.set("previousOffset", task.state.previousOffset)
              data.executor.add(task)
            }
          },
          data: container
        })
      },
      onDestroy: function() {
        this.templateToolbar.store
          .get("template")
          .removeSubscriber(this.name)
      },
    }
  },
  "control": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.sideDark).toGMColor(),
        "components": new Array(Struct, [
          {
            name: "button_control-save",
            template: VEComponents.get("collection-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              label: { text: "Save" },
              layout: { 
                height: function() { return 40 },
              },
              backgroundMargin: { top: 1, bottom: 1, right: 1, left: 0 },
              callback: function() { 
                if (Core.isType(GMTFContext.get(), GMTF)) {
                  if (Core.isType(GMTFContext.get().uiItem, UIItem)) {
                    GMTFContext.get().uiItem.update()
                  }
                  GMTFContext.get().unfocus()
                }

                var template = this.context.templateToolbar.store.getValue("template")
                if (!Core.isType(template, VETemplate)) {
                  return
                }
                
                this.context.templateToolbar.send(new Event("save-template"))

                var accordion = Beans.get(BeanVisuEditorController).accordion
                accordion.containers.forEach(accordion.resetUpdateTimer)
                accordion.templateToolbar.containers.forEach(accordion.resetUpdateTimer)
                accordion.eventInspector.containers.forEach(accordion.resetUpdateTimer)
              },
              onMouseHoverOut: function(event) {
                var item = this
                var controller = Beans.get(BeanVisuEditorController)
                controller.executor.tasks.forEach(function(task, iterator, item) {
                  if (Struct.get(task.state, "item") == item) {
                    task.fullfill()
                  }
                }, item)

                this.backgroundColor = ColorUtil.fromHex(this.colorHoverOut).toGMColor()
              },
              onMouseHoverOver: function(event) {
                var item = this
                var controller = Beans.get(BeanVisuEditorController)
                controller.executor.tasks.forEach(function(task, iterator, item) {
                  if (Struct.get(task.state, "item") == item) {
                    task.fullfill()
                  }
                }, item)

                this.backgroundColor = ColorUtil.fromHex(this.colorHoverOver).toGMColor()
              },
              postRender: function() {
                var keyLabel = Struct.get(this, "keyLabel")
                if (!Optional.is(keyLabel)) {
                  keyLabel = Struct.set(this, "keyLabel", new UILabel({
                    font: "font_inter_8_regular",
                    text: "[CTRL + SHIFT + A]",
                    alpha: 1.0,
                    useScale: false,
                    color: VETheme.color.textShadow,
                    align: {
                      v: VAlign.BOTTOM,
                      h: HAlign.CENTER,
                    },
                  }))
                }

                keyLabel.render(
                  this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2.0),
                  this.context.area.getY() + this.area.getY() + this.area.getHeight(),
                  this.area.getWidth(),
                  this.area.getHeight(),
                  0.9
                )
              },
            },
          }
        ]),
      }),
      updateTimer: new Timer(FRAME_MS * 2, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      particleTimer: new Timer(1.0, { loop: Infinity }),
      updateCustom: function() {
        var store = this.templateToolbar.store
        var type = store.getValue("type")
        var template = store.getValue("template")
        if (type != VETemplateType.PARTICLE || template == null) {
          return
        }
        
        var interval = template.store.getValue("particle_interval-preview")
        if (this.particleTimer.duration != interval) {
          this.particleTimer.setDuration(interval)
        }

        var preview = template.store.getValue("particle_use-preview")
        if (this.particleTimer.update().finished && preview) {
          var particleName = template.store.getValue("template-name")
          var amount = template.store.getValue("particle_amount-preview")
          var area = template.store.getValue("particle_area-preview")
          var shape = ParticleEmitterShape.get(template.store.getValue("particle_shape-preview"))
          var distribution = ParticleEmitterDistribution.get(template.store.getValue("particle_distribution-preview"))
          var particleService = Beans.get(BeanVisuController).particleService
          particleService.spawnParticleEmitter(
            "main",
            particleName,
            area.getX() * GRID_SERVICE_PIXEL_WIDTH,
            area.getY() * GRID_SERVICE_PIXEL_HEIGHT,
            (area.getX() + area.getWidth()) * GRID_SERVICE_PIXEL_WIDTH,
            (area.getY() + area.getHeight()) * GRID_SERVICE_PIXEL_HEIGHT,
            interval,
            amount,
            interval,
            shape,
            distribution
          )

          /*
          var event = particleService.factoryEventSpawnParticleEmitter({
            particleName: particleName,
            beginX: (GuiWidth() / 2) - 32,
            beginY: (GuiHeight() / 2) - 32,
            endX: (GuiWidth() / 2) + 32,
            endY: (GuiHeight() / 2) + 32,
            amount: 10,
          })
          particleService.send(event)
          */
        }
      },
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      onInit: function() {
        this.collection = new UICollection(this, { layout: this.layout })
        this.state.get("components")
          .forEach(function(component, index, collection) {
            collection.add(new UIComponent(component))
          }, this.collection)
      },
    }
  },
})
#macro VisuTemplateContainers global.__VisuTemplateContainers


///@param {VisuEditorController}
function VETemplateToolbar(_editor) constructor {

  ///@type {VisuEditorController}
  editor = Assert.isType(_editor, VisuEditorController)

  ///@type {?UILayout}
  layout = null

  ///@type {Map<String, UIContainers>}
  containers = new Map(String, UI)

  ///@type {Store}
  store = new Store({
    "type": {
      type: String,
      value: VETemplateType.SHADER
    },
    "template_shader_name": {
      type: String,
      value: "shader",
    },
    "template_shroom_name": {
      type: String,
      value: "shroom",
    },
    "template_bullet_name": {
      type: String,
      value: "bullet",
    },
    "template_coin_name": {
      type: String,
      value: "coin",
    },
    "template_subtitle_name": {
      type: String,
      value: "subtitle",
    },
    "template_particle_name": {
      type: String,
      value: "particle",
    },
    "template_texture_name": {
      type: String,
      value: "texture",
    },
    "template": {
      //type: Optional.of(VETemplate),
      type: Optional.of(Struct),
      value: null,
    },
    "shader": {
      type: String,
      value: "shader_arc_runner",
      validate: function(value) {
        Assert.isType(ShaderUtil.fetch(value), Shader)
        Assert.isTrue(this.data.contains(value))
      },
      data: new Array(String, GMArray.sort(Struct.keys(SHADERS))),
    },
    "texture-intent": {
      type: TextureIntent,
      value: new TextureIntent({ name: "", file: "" }),
    },
  })

  ///@type {Boolean}
  enable = true

  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout(
      {
        name: "template-toolbar",
        staticHeight: new BindIntent(function() {
          var bar = Struct.get(this.nodes, "bar")
          var type = Struct.get(this.nodes, "type")
          var add = Struct.get(this.nodes, "add")
          var title = Struct.get(this.nodes, "title")
          var inspectorBar = Struct.get(this.nodes, "inspector-bar")
          var control = Struct.get(this.nodes, "control")
          var templateView = Struct.get(this.nodes, "template-view")
          var inspectorView = Struct.get(this.nodes, "inspector-view")
          return bar.height() + bar.__margin.top + bar.__margin.bottom
              + type.height() + type.__margin.top + type.__margin.bottom
              + add.height() + add.__margin.top + add.__margin.bottom
              + title.height() + title.__margin.top + title.__margin.bottom
              + inspectorBar.height() + inspectorBar.__margin.top + inspectorBar.__margin.bottom
              + control.height() + control.__margin.top + control.__margin.bottom
              + templateView.__margin.top + templateView.__margin.bottom
              + inspectorView.__margin.top + inspectorView.__margin.bottom
        }),
        nodes: {
          "bar": {
            name: "template-toolbar.bar",
            y: function() { return this.context.y() + this.__margin.top },
            height: function() { return 16 },
            margin: { left: 1, right: 1, top: 0 },
          },
          "type": {
            name: "template-toolbar.type",
            y: function() { return this.context.nodes.bar.bottom() + this.__margin.top },
            height: function() { return 40 },
            margin: { left: 1, right: 1 },
          },
          "add": {
            name: "template-toolbar.add",
            y: function() { return this.context.nodes.type.bottom() + this.__margin.top },
            __height: 62,
            height: function() { return this.__height - this.__margin.top },
            margin: { left: 1, right: 1, top: 1 },
          },
          "title": {
            name: "template-toolbar.title",
            y: function() { return this.context.nodes.add.bottom() + this.__margin.top },
            height: function() { return 16 },
            margin: { left: 1, right: 1, top: 1 },
          },
          "template-view": {
            name: "template-toolbar.template-view",
            percentageHeight: 0.25,
            margin: { top: 1, bottom: 0, left: 10, right: 1 },
            x: function() { return this.context.x() + this.__margin.left },
            y: function() { return this.__margin.top + this.context.nodes.title.bottom() },
            height: function() { return ceil((this.context.height() 
              - this.context.staticHeight()) * this.percentageHeight)
              },//- this.__margin.top - this.__margin.bottom },
          },
          "inspector-bar": {
            name: "template-toolbar.inspector-bar",
            y: function() { return Struct.get(this.context.nodes, "template-view").bottom() + this.__margin.top },
            height: function() { return 16 },
            margin: { left: 1, right: 1, top: 1 },
          },
          "inspector-view": {
            name: "template-toolbar.inspector-view",
            percentageHeight: 0.75,
            margin: { top: 1, bottom: 0, left: 10, right: 1 },
            x: function() { return this.context.x() + this.__margin.left },
            y: function() { return this.__margin.top + Struct.get(this.context.nodes, "inspector-bar").bottom() },
            height: function() { return ceil((this.context.height() 
              - this.context.staticHeight()) * this.percentageHeight) 
              - this.__margin.top - this.__margin.bottom },
          },
          "control": {
            name: "template-toolbar.control",
            y: function() {
              return Struct.get(this.context.nodes, "inspector-view").bottom()
            },
            height: function() { return 40 },
            margin: { left: 1, right: 1 },
          }
        }
      },
      parent
    )
  }

  ///@private
  ///@param {UIlayout} parent
  ///@return {Task}
  factoryOpenTask = function(parent) {
    var templateToolbar = this
    var layout = this.factoryLayout(parent)
    this.layout = layout
    
    var containerIntents = new Map(String, Struct)
    VisuTemplateContainers.forEach(function(template, name, acc) {
      var layout = Assert.isType(Struct.get(acc.templateToolbar.layout.nodes, name), UILayout)
      var ui = template($"ve-template-toolbar_{name}", acc.templateToolbar, layout)
      acc.containers.set($"ve-template-toolbar_{name}", ui)
    }, { containers: containerIntents, templateToolbar: templateToolbar })
    
    return new Task("init-container")
      .setState({
        context: templateToolbar,
        containers: containerIntents,
        queue: new Queue(String, GMArray.sort(containerIntents.keys().getContainer())),
      })
      .whenUpdate(function() {
        var key = this.state.queue.pop()
        if (key == null) {
          this.fullfill()
          return
        }
        this.state.context.containers.set(key, new UI(this.state.containers.get(key)))
      })
      .whenFinish(function() {
        var containers = this.state.context.containers
        IntStream.forEach(0, containers.size(), function(iterator, index, acc) {
          Beans.get(BeanVisuEditorController).uiService.send(new Event("add", {
            container: acc.containers.get(acc.keys[iterator]),
            replace: true,
          }))
        }, {
          keys: GMArray.sort(containers.keys().getContainer()),
          containers: containers,
        })
      })
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open": function(event) {
      this.dispatcher.execute(new Event("close"))
      Beans.get(BeanVisuEditorController).executor
        .add(this.factoryOpenTask(event.data.layout))
    },
    "close": function(event) {
      var context = this
      this.containers.forEach(function (container, key, uiService) {
        uiService.dispatcher.execute(new Event("remove", { 
          name: key, 
          quiet: true,
        }))
      }, Beans.get(BeanVisuEditorController).uiService).clear()

      this.store.get("template").set(null)
    },
    "add-template": function(event) {
      var type = this.store.getValue("type")
      var name = this.store.getValue($"{type}_name")
      if (!Core.isType(name, String) || name == "") {
        return
      }

      var controller = Beans.get(BeanVisuController)
      var sizeBefore = 0
      var sizeAfter = 0
      switch (type) {
        case VETemplateType.SHADER:
          var shaderTemplate = new ShaderTemplate(name, {
            name: name,
            shader: this.store.getValue("shader"),
          })
          sizeBefore = controller.shaderPipeline.templates.size()
          sizeAfter = controller.shaderPipeline.templates
            .set(name, shaderTemplate)
            .size()

          Struct.set(shaderTemplate, "type", VETemplateType.SHADER)
          this.store
            .get("template")
            .set(new VETemplate(shaderTemplate))
          this.send(new Event("save-template"))
          break
        case VETemplateType.SHROOM:
          sizeBefore = controller.shroomService.templates.size()
          sizeAfter = controller.shroomService.templates
            .set(name, new ShroomTemplate(name, {
              name: name,
              sprite: { name: "texture_baron" },
            }))
            .size()
          break
        case VETemplateType.BULLET:
          sizeBefore = controller.bulletService.templates.size()
          sizeAfter = controller.bulletService.templates
            .set(name, new BulletTemplate(name, {
              name: name,
              sprite: { name: "texture_baron" },
            }))
            .size()
          break
        case VETemplateType.COIN:
          sizeBefore = controller.coinService.templates.size()
          sizeAfter = controller.coinService.templates
            .set(name, new CoinTemplate(name, {
              name: name,
              category: CoinCategory.POINT,
              sprite: { name: "texture_coin_point" },
            }))
            .size()
          break
        case VETemplateType.SUBTITLE:
          sizeBefore = controller.subtitleService.templates.size()
          sizeAfter = controller.subtitleService.templates
            .set(name, new SubtitleTemplate(name, { todo: "json" })) ///@todo
            .size()
          break
        case VETemplateType.PARTICLE:
          sizeBefore = controller.particleService.templates.size()
          sizeAfter = controller.particleService.templates
            .set(name, new ParticleTemplate(name, { todo: "json" })) ///@todo
            .size()
          break
        case VETemplateType.TEXTURE:
          var intent = this.store.getValue("texture-intent")
          if (!Core.isType(intent, TextureIntent) && intent.file == "") {
            return
          }
          intent.name = name
          intent = new TextureIntent(intent)

          Beans.get(BeanTextureService)
            .send(new Event("load-texture")
              .setData(intent)
              .setPromise(new Promise()
                .setState(Assert.isType(this.store.get("type"), StoreItem))
                .whenSuccess(function() {
                  this.state.set(VETemplateType.TEXTURE)
                })))
          break
        default:
          throw new Exception($"Dispatcher for type '{type}' wasn't found")
      }

      var storeItem = this.store.get("template")
      storeItem.set(storeItem.get())

      ///@description send update event to subscribers
      if (sizeBefore != sizeAfter) {
        this.store.get("type").set(type)
      }
    },      
    "save-template": function(event) {
      var template = this.store.getValue("template")
      if (!Core.isType(template, VETemplate)) {
        return
      }

      var name = template.store.getValue("template-name")
      var serialized = template.serialize()
      var controller = Beans.get(BeanVisuController)
      var sizeBefore = 0
      var sizeAfter = 0
      switch (template.type) {
        case VETemplateType.SHADER:
          sizeBefore = controller.shaderPipeline.templates.size()
          sizeAfter = controller.shaderPipeline.templates.set(name, serialized).size()
          break
        case VETemplateType.SHROOM:
          sizeBefore = controller.shroomService.templates.size()
          sizeAfter = controller.shroomService.templates.set(name, serialized).size()
          break
        case VETemplateType.BULLET:
          sizeBefore = controller.bulletService.templates.size()
          sizeAfter = controller.bulletService.templates.set(name, serialized).size()
          break
        case VETemplateType.COIN:
          sizeBefore = controller.coinService.templates.size()
          sizeAfter = controller.coinService.templates.set(name, serialized).size()
          break
        case VETemplateType.SUBTITLE:
          sizeBefore = controller.subtitleService.templates.size()
          sizeAfter = controller.subtitleService.templates.set(name, serialized).size()
          break
        case VETemplateType.PARTICLE:
          sizeBefore = controller.particleService.templates.size()
          sizeAfter = controller.particleService.templates.set(name, serialized).size()
          break
        case VETemplateType.TEXTURE:
          if (serialized.file != "") {
            var textureService = Beans.get(BeanTextureService)
            sizeBefore = textureService.templates.size()
            sizeAfter = textureService.templates.set(name, serialized).size()
          }
          this.store.get("template").set(template)
          break
        default:
          throw new Exception($"Dispatcher for type '{template.type}' wasn't found")
      }

      ///@description send update event to subscribers
      if (sizeBefore != sizeAfter) {
        this.store.get("type").set(template.type)
      }

      var inspectorView = this.containers.get("ve-template-toolbar_inspector-view")
      if (Optional.is(inspectorView)) {
        inspectorView.state.set("surface-alpha", 0.5)
      }
      //this.store.get("template").set(template)

      var control = this.containers.get("ve-template-toolbar_control")
      if (control == null) {
        return
      }

      var button = control.items.get("button_control-save_type-button")
      if (button == null) {
        return
      }

      controller = Beans.get(BeanVisuEditorController)
      var item = button
      controller.executor.tasks.forEach(function(task, iterator, item) {
        if (Struct.get(task.state, "item") == item) {
          task.fullfill()
        }
      }, item)
      
      var task = new Task($"onMouseReleasedLeft_{item.name}")
        .setTimeout(10.0)
        .setState({
          item: item,
          transformer: new ColorTransformer({
            value: VETheme.color.accept,
            target: item.isHoverOver ? item.colorHoverOver : item.colorHoverOut,
            duration: 1.0,
          })
        })
        .whenUpdate(function(executor) {
          if (this.state.transformer.update().finished) {
            this.fullfill()
          }

          this.state.item.backgroundColor = this.state.transformer.get().toGMColor()
        })

      item.backgroundColor = ColorUtil.parse(VETheme.color.accept).toGMColor()
      controller.executor.add(task)
    },
  }), { 
    enableLogger: false, 
    catchException: false,
  })

  ///@param {Event} event
  ///@return {?Promise}
  send = method(this, EventPumpUtil.send())

  ///@return {VEBrushToolbar}
  update = function() {
    try {
      this.dispatcher.update()
    } catch (exception) {
      var message = $"VETemplateToolbar dispatcher fatal error: {exception.message}"
      Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
      Logger.error("UI", message)
    }
    
    this.containers.forEach(function (container, key, enable) {
      container.enable = enable
    }, this.enable)
    return this
  }
}