///@package io.alkapivo.visu.editor.ui.controller

function factoryVEContextMenu(root, anchor, json) {
  static factoryComponent = function(config, index, size) {
    var bottom = index == size - 1 ? 2 : 1
    return Struct.appendRecursiveUnique(config, {
      template: VEComponents.get("context-menu-button"),
      layout: VELayouts.get("vertical-item"),
      config: {
        label: { text: "" },
        backgroundMargin: { top: 1, bottom: bottom, left: 1, right: 2 },
      }
    })
  }

  var arr = Struct.getIfType(json, "components", GMArray, [])
  var components = GMArray.map(arr, factoryComponent, GMArray.size(arr))

  return new UI({
    name: Assert.isType(Struct.get(json, "name"), String, "json.name must be type of String"),
    layout: new UILayout(Struct.appendRecursiveUnique(Struct.get(json, "layout"), {
      type: UILayoutType.VERTICAL,
      anchor: anchor,
      x: function() { return this.anchor.x },
      y: function() { return this.anchor.y },
      width: function() { return 320 },
      height: function() { return 28 * this.collection.getSize() },
      collection: { size: GMArray.size(components) },
    })),
    state: new Map(String, any, {
      "background-color": ColorUtil.fromHex(VETheme.color.primaryShadow).toGMColor(),
      "components": new Array(Struct, components),
      "timer": new Timer(0.25),
      "root": root,
    }),
    propagate: false,
    scrollbarY: { align: HAlign.RIGHT },
    updateArea: Callable.run(UIUtil.updateAreaTemplates.get("scrollableY")),
    updateCustom: function() {
      this.enableScrollbarY = this.offsetMax.y > 0 
      var mouseX = MouseUtil.getMouseX()
      var mouseY = MouseUtil.getMouseY()
      var colide = this.area.collide(mouseX, mouseY)
          || this.state.get("root").collide(mouseX, mouseY)
      if (!colide) {
        if (this.state.get("timer").update().finished) {
          var uiService = Beans.get(BeanVisuEditorController).uiService
          uiService.send(new Event("remove", { 
            name: this.name, 
            quiet: true,
          }))
        }
      } else {
        this.state.get("timer").reset()
      }
    },
    renderItem: Callable.run(UIUtil.renderTemplates.get("renderItemDefaultScrollable")),
    renderDefaultScrollable: new BindIntent(Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollableAlpha"))),
    render: function() {
      this.renderDefaultScrollable()
      return this
    },
    onMouseWheelUp: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelUpY")),
    onMouseWheelDown: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelDownY")),
    onInit: function() {
      var container = this
      this.collection = new UICollection(this, { layout: this.layout })
      this.items.forEach(function(item) { item.free() }).clear()
      this.updateArea()
      this.state.get("components").forEach(function(component, index, collection) {
        collection.add(new UIComponent(component))
      }, this.collection)
    },
  })
}

///@param {VisuEditorController} _editor
function VETitleBar(_editor) constructor {

  ///@type {VisuEditorController}
  editor = Assert.isType(_editor, VisuEditorController)

  ///@type {Map<String, Containers>}
  containers = new Map(String, UI)

  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout(
      {
        name: "title-bar",
        nodes: {
          bottomLine: {
            name: "title-bar.bottomLine",
            x: function() { return 0 },
            y: function() { return this.context.height() - this.height() },
            width: function() { return this.context.width() },
            height: function() { return 1 },
          },
          file: {
            name: "title-bar.file",
            x: function() { return this.context.x() + this.__margin.left },
            y: function() { return 0 },
            width: function() { return 48 },
          },
          edit: {
            name: "title-bar.edit",
            x: function() { return this.context.nodes.file.right()
              + this.__margin.left },
            y: function() { return 0 },
            width: function() { return 48 },
          },
          view: {
            name: "title-bar.open",
            x: function() { return this.context.nodes.edit.right()
              + this.__margin.left },
            y: function() { return 0 },
            width: function() { return 48 },
          },
          grid: {
            name: "title-bar.grid",
            x: function() { return this.context.nodes.view.right()
              + this.__margin.left },
            y: function() { return 0 },
            width: function() { return 48 },
          },
          help: {
            name: "title-bar.help",
            x: function() { return this.context.nodes.grid.right()
              + this.__margin.left },
            y: function() { return 0 },
            width: function() { return 48 },
          },
          version: {
            name: "title-bar.version",
            x: function() { return (this.context.width() - this.width()) / 2.0 },
            y: function() { return 0 },
            width: function() { return 480 },
          },
          trackControl: {
            name: "title-bar.trackControl",
            x: function() { return this.context.nodes.event.left() 
              - this.width() - this.__margin.right },
            y: function() { return 0 },
            width: function() { return this.context.height() },
          },
          event: {
            name: "title-bar.event",
            x: function() { return this.context.nodes.timeline.left() 
              - this.width() - this.__margin.right },
            y: function() { return 0 },
            width: function() { return this.context.height() },
          },
          timeline: {
            name: "title-bar.timeline",
            x: function() { return this.context.nodes.brush.left() 
              - this.width() - this.__margin.right },
            y: function() { return 0 },
            width: function() { return this.context.height() },
          },
          brush: {
            name: "title-bar.brush",
            x: function() { return this.context.nodes.sceneConfigPreview.left() 
              - this.width() - this.__margin.right },
            y: function() { return 0 },
            width: function() { return this.context.height() },
          },
          sceneConfigPreview: {
            x: function() { return this.context.nodes.fullscreen.left() 
              - this.width() - this.__margin.right },
            y: function() { return 0 },
            width: function() { return this.context.height() },
          },
          fullscreen: {
            name: "title-bar.fullscreen",
            x: function() { return this.context.x() + this.context.width()
               - this.width() - this.__margin.right },
            y: function() { return 0 },
            width: function() { return this.context.height() },
          }
        }
      }, 
      parent
    )
  }

  ///@private
  ///@param {UIlayout} parent
  ///@return {Map<String, UI>}
  factoryContainers = function(parent) {
    static factoryTextButton = function(json) {
      var button = Struct.appendRecursiveUnique(
        {
          type: UIButton,
          layout: json.layout,
          backgroundMargin: { top: 2, bottom: 2, left: 2, right: 2 },
          label: { text: json.text },
          callback: Struct.getDefault(json, "callback", function() { }),
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          onMouseHoverOver: Optional.is(Struct.getIfType(json, "onMouseHoverOver", Callable))
            ? json.onMouseHoverOver
            : function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
          onMouseHoverOut: function(event) {
            var item = this
            var controller = Beans.get(BeanVisuController)
            controller.executor.tasks.forEach(function(task, iterator, item) {
              if (Struct.get(task.state, "item") == item) {
                task.fullfill()
              }
            }, item)
            
            var task = new Task($"onMouseHoverOut_{item.name}")
              .setTimeout(10.0)
              .setState({
                item: item,
                transformer: new ColorTransformer({
                  value: item.backgroundColorSelected,
                  target: item.backgroundColorOut,
                  duration: 0.66,
                })
              })
              .whenUpdate(function(executor) {
                if (this.state.transformer.update().finished) {
                  this.fullfill()
                }

                this.state.item.backgroundColor = this.state.transformer.get().toGMColor()
              })

            controller.executor.add(task)
          },
        },
        VEStyles.get("ve-title-bar").menu,
        false
      )

      if (Optional.is(Struct.getIfType(json, "postRender", Callable))) {
        Struct.set(button, "postRender", json.postRender)
      }

      return button
    }

    static factoryCheckboxButton = function(json) {
      var _json = {
        type: UICheckbox,
        layout: json.layout,
        spriteOn: json.spriteOn,
        spriteOff: json.spriteOff,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        onMouseHoverOver: function(event) {
          this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
        },
        onMouseHoverOut: function(event) {
          var item = this
          var controller = Beans.get(BeanVisuController)
          controller.executor.tasks.forEach(function(task, iterator, item) {
            if (Struct.get(task.state, "item") == item) {
              task.fullfill()
            }
          }, item)
          
          var task = new Task($"onMouseHoverOut_{item.name}")
            .setTimeout(10.0)
            .setState({
              item: item,
              transformer: new ColorTransformer({
                value: item.backgroundColorSelected,
                target: item.backgroundColorOut,
                duration: 0.66,
              })
            })
            .whenUpdate(function(executor) {
              if (this.state.transformer.update().finished) {
                this.fullfill()
              }

              this.state.item.backgroundColor = this.state.transformer.get().toGMColor()
            })

          controller.executor.add(task)
        },
      }

      if (Optional.is(Struct.get(json, "store"))) {
        Struct.set(_json, "store", json.store)
      }

      if (Optional.is(Struct.get(json, "callback"))) {
        Struct.set(_json, "callback", json.callback)
      }

      return Struct.appendRecursiveUnique(
        _json,
        VEStyles.get("ve-title-bar").checkbox,
        false
      )
    }

    var controller = this
    var layout = this.factoryLayout(parent)
    return new Map(String, UI, {
      "ve-title-bar": new UI({
        name: "ve-title-bar",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.sideDark).toGMColor(),
          "store": Beans.get(BeanVisuEditorController).store,
        }),
        controller: controller,
        layout: layout,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
        items: {
          "button_ve-title-bar_file": factoryTextButton({
            text: "File",
            layout: layout.nodes.file,
            onMouseHoverOver: function() {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              if (Beans.get(BeanVisuEditorController).uiService
                  .find("ve-title-bar_file_context-menu") == null) {
                this.callback()
              }
            },
            callback: function() {
              var root = this.area
              var anchor = {
                x: this.layout.left(),
                y: this.layout.bottom(),
              }

              var contextMenu = factoryVEContextMenu(root, anchor, {
                name: "ve-title-bar_file_context-menu",
                components: [
                  {
                    name: "file_new-level",
                    config: {
                      label: { text: "New level" },
                      shortcut: { text: "CTRL + N" },
                      callback: function() {
                        if (Core.getRuntimeType() == RuntimeType.GXGAMES) {
                          Beans.get(BeanVisuController).send(new Event("spawn-popup", 
                            { message: $"Feature 'visu.title-bar.new' is not available on wasm-yyc target" }))
                          return
                        }

                        var editor = Beans.get(BeanVisuEditorController)
                        if (Core.isType(editor.uiService.find("visu-project-modal"), UI)) {
                          editor.projectModal.send(new Event("close"))
                        }
                  
                        if (Core.isType(editor.uiService.find("visu-modal"), UI)) {
                          editor.exitModal.send(new Event("close"))
                        }

                        editor.newProjectModal
                          .send(new Event("open").setData({
                            layout: new UILayout({
                              name: "display",
                              x: function() { return 0 },
                              y: function() { return 0 },
                              width: function() { return GuiWidth() },
                              height: function() { return GuiHeight() },
                            }),
                          }))
                        
                        editor.uiService.send(new Event("remove", { 
                          name: this.context.name, 
                          quiet: true,
                        }))
                      },
                    },
                  },
                  {
                    name: "file_open-level",
                    config: {
                      label: { text: "Open level" },
                      shortcut: { text: "CTRL + O" },
                      callback: function() {
                        try {
                          if (Core.getRuntimeType() == RuntimeType.GXGAMES) {
                            Beans.get(BeanVisuController).send(new Event("spawn-popup", 
                              { message: $"Feature 'visu.title-bar.open' is not available on wasm-yyc target" }))
                            return
                          }

                          var manifest = FileUtil.getPathToOpenWithDialog({ 
                            description: "Visu track file",
                            filename: "manifest", 
                            extension: "visu"
                          })
            
                          if (!FileUtil.fileExists(manifest)) {
                            return
                          }

                          Beans.get(BeanVisuController).send(new Event("load", {
                            manifest: manifest,
                            autoplay: false
                          }))

                          var uiService = Beans.get(BeanVisuEditorController).uiService
                          uiService.send(new Event("remove", { 
                            name: this.context.name, 
                            quiet: true,
                          }))
                        } catch (exception) {
                          Beans.get(BeanVisuController).send(new Event("spawn-popup", 
                            { message: $"Cannot load the project: {exception.message}" }))
                        }
                      }
                    },
                  },
                  {
                    name: "file_save-level",
                    config: {
                      label: { text: "Save level" },
                      shortcut: { text: "CTRL + S" },
                      callback: function() {
                        var controller = Beans.get(BeanVisuController)
                        var editor = Beans.get(BeanVisuEditorController)
                        try {
                          if (Core.getRuntimeType() == RuntimeType.GXGAMES) {
                            editor.send(new Event("spawn-popup", 
                              { message: $"Feature 'visu.editor.save' is not available on wasm-yyc target" }))
                            return this
                          }

                          if (!controller.trackService.isTrackLoaded()) {
                            return this
                          }

                          var path = $"{controller.track.path}manifest.visu"

                          if (!Core.isType(path, String) || String.isEmpty(path)) {
                            return this
                          }

                          controller.track.saveProject(path)
                          controller.send(new Event("spawn-popup", 
                            { message: $"Project '{controller.trackService.track.name}' saved successfully at: '{path}'" }))

                          editor.uiService.send(new Event("remove", { 
                            name: this.context.name, 
                            quiet: true,
                          }))
                        } catch (exception) {
                          var message = $"Cannot save the project: {exception.message}"
                          controller.send(new Event("spawn-popup", { message: message }))
                          Logger.error("VETitleBar", message)
                        }
                      },
                      preRender: function() {
                        var value = Beans.get(BeanVisuController).trackService.isTrackLoaded()
                        if (this.updateEnable != null && value != this.enable.value) {
                          Struct.set(this.enable, "value", value)
                          this.updateEnable()
                        }
                      },
                    },
                  },
                  {
                    name: "file_save-level-as",
                    config: {
                      label: { text: "Save level as" },
                      shortcut: { text: "CTRL + SHIFT + S" },
                      callback: function() {
                        var controller = Beans.get(BeanVisuController)
                        var editor = Beans.get(BeanVisuEditorController)
                        try {
                          if (Core.getRuntimeType() == RuntimeType.GXGAMES) {
                            editor.send(new Event("spawn-popup", 
                              { message: $"Feature 'visu.editor.save' is not available on wasm-yyc target" }))
                            return this
                          }

                          if (!controller.trackService.isTrackLoaded()) {
                            return this
                          }

                          var path = FileUtil.getPathToSaveWithDialog({ 
                            description: "Visu track file",
                            filename: "manifest", 
                            extension: "visu",
                          })

                          if (!Core.isType(path, String) || String.isEmpty(path)) {
                            return this
                          }

                          controller.track.saveProject(path)
                          controller.send(new Event("spawn-popup", 
                            { message: $"Project '{controller.trackService.track.name}' saved successfully at: '{path}'" }))

                          editor.uiService.send(new Event("remove", { 
                            name: this.context.name, 
                            quiet: true,
                          }))
                        } catch (exception) {
                          var message = $"Cannot save the project: {exception.message}"
                          controller.send(new Event("spawn-popup", { message: message }))
                          Logger.error("VETitleBar", message)
                        }
                      },
                      preRender: function() {
                        var value = Beans.get(BeanVisuController).trackService.isTrackLoaded()
                        if (this.updateEnable != null && value != this.enable.value) {
                          Struct.set(this.enable, "value", value)
                          this.updateEnable()
                        }
                      },
                    },
                  },
                  {
                    name: "file_exit",
                    config: {
                      label: { text: "Exit" },
                      callback: function() {
                        if (Optional.is(Beans.get(Visu.modules().editor.io))) {
                          Beans.kill(Visu.modules().editor.io)
                        }

                        if (Optional.is(Beans.get(Visu.modules().editor.controller))) {
                          Beans.kill(Visu.modules().editor.controller)
                        }
                      }
                    },
                  }
                ],
              })

              var uiService = Beans.get(BeanVisuEditorController).uiService
              var ui = uiService.find("_context-menu", function(container, key, name) {
                return String.contains(container.name, name)
              })

              if (Optional.is(ui)) {
                uiService.send(new Event("remove", {
                  name: ui.name,
                  quiet: true,
                }))
              }

              uiService.send(new Event("add", {
                container: contextMenu,
                replace: true,
              }))
            },
          }),
          "button_ve-title-bar_edit": factoryTextButton({
            text: "Edit",
            layout: layout.nodes.edit,
            onMouseHoverOver: function() {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              if (Beans.get(BeanVisuEditorController).uiService
                  .find("ve-title-bar_edit_context-menu") == null) {
                this.callback()
              }
            },
            callback: function() {
              var root = this.area
              var anchor = {
                x: this.layout.left(),
                y: this.layout.bottom(),
              }

              var contextMenu = factoryVEContextMenu(root, anchor, {
                name: "ve-title-bar_edit_context-menu",
                components: [
                  {
                    name: "edit_undo",
                    config: {
                      label: { text: "Undo" },
                      shortcut: { text: "CTRL + Z" },
                      callback: function() { 
                        if (Struct.get(this.enable, "value") == false) {
                          return
                        }

                        Beans.get(BeanVisuEditorIO).keyboard.keys.controlLeft.on = true ///@hack
                        
                        var editor = Beans.get(BeanVisuEditorController)
                        editor.store.get("selected-event").set(null, true)
                        editor.store.getValue("selected-events").clear()
                        editor.timeline.transactionService.undo()
                      },
                      preRender: function() {
                        var value = Beans.get(BeanVisuEditorController).timeline.transactionService.applied.size() > 0
                        if (this.updateEnable != null && value != this.enable.value) {
                          Struct.set(this.enable, "value", value)
                          this.updateEnable()
                        }
                      }
                    },
                  },
                  {
                    name: "edit_redo",
                    config: {
                      label: { text: "Redo" },
                      shortcut: { text: "CTRL + SHIFT + Z" },
                      callback: function() { 
                        if (Struct.get(this.enable, "value") == false) {
                          return
                        }
                        
                        Beans.get(BeanVisuEditorIO).keyboard.keys.controlLeft.on = true ///@hack

                        var editor = Beans.get(BeanVisuEditorController)
                        editor.store.get("selected-event").set(null, true)
                        editor.store.getValue("selected-events").clear()
                        editor.timeline.transactionService.redo()
                      },
                      preRender: function() {
                        var value = Beans.get(BeanVisuEditorController).timeline.transactionService.reverted.size() > 0
                        if (this.updateEnable != null && value != this.enable.value) {
                          Struct.set(this.enable, "value", value)
                          this.updateEnable()
                        }
                      },
                    },
                  },
                  {
                    name: "edit_level-settings",
                    config: {
                      label: { text: "Level settings" },
                      shortcut: { text: "" },
                      callback: function() {
                        if (Core.getRuntimeType() == RuntimeType.GXGAMES) {
                          Beans.get(BeanVisuController).send(new Event("spawn-popup", 
                            { message: $"Feature 'visu.title-bar.edit' is not available on wasm-yyc target" }))
                          return
                        }

                        var editor = Beans.get(BeanVisuEditorController)
                        if (Core.isType(editor.uiService.find("visu-new-project-modal"), UI)) {
                          editor.newProjectModal.send(new Event("close"))
                        }
                  
                        if (Core.isType(editor.uiService.find("visu-modal"), UI)) {
                          editor.exitModal.send(new Event("close"))
                        }

                        editor.projectModal
                          .send(new Event("open").setData({
                            layout: new UILayout({
                              name: "display",
                              x: function() { return 0 },
                              y: function() { return 0 },
                              width: function() { return GuiWidth() },
                              height: function() { return GuiHeight() },
                            }),
                          }))

                        editor.uiService.send(new Event("remove", { 
                          name: this.context.name, 
                          quiet: true,
                        }))
                      },
                      preRender: function() {
                        var value = Beans.get(BeanVisuController).trackService.isTrackLoaded()
                        if (this.updateEnable != null && value != this.enable.value) {
                          Struct.set(this.enable, "value", value)
                          this.updateEnable()
                        }
                      },
                    },
                  }
                ],
              })

              var uiService = Beans.get(BeanVisuEditorController).uiService
              var ui = uiService.find("_context-menu", function(container, key, name) {
                return String.contains(container.name, name)
              })

              if (Optional.is(ui)) {
                uiService.send(new Event("remove", {
                  name: ui.name,
                  quiet: true,
                }))
              }

              uiService.send(new Event("add", {
                container: contextMenu,
                replace: true,
              }))
            },
          }),
          "button_ve-title-bar_view": factoryTextButton({
            text: "View",
            layout: layout.nodes.view,
            onMouseHoverOver: function() {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              if (Beans.get(BeanVisuEditorController).uiService
                  .find("ve-title-bar_view_context-menu") == null) {
                this.callback()
              }
            },
            callback: function() {
              var root = this.area
              var anchor = {
                x: this.layout.left(),
                y: this.layout.bottom(),
              }

              var contextMenu = factoryVEContextMenu(root, anchor, {
                name: "ve-title-bar_view_context-menu",
                components: [
                  {
                    name: "view_controls",
                    config: {
                      label: { text: "Controls" },
                      shortcut: { text: "F1" },
                      callback: function() {
                        var editor = Beans.get(BeanVisuEditorController)
                        var key = "render-trackControl"
                        editor.store.get(key).set(!editor.store.getValue(key))
                      },
                    },
                  },
                  {
                    name: "view_inspector",
                    config: {
                      label: { text: "Inspectors" },
                      shortcut: { text: "F2" },
                      callback: function() {
                        var editor = Beans.get(BeanVisuEditorController)
                        var key = "render-event"
                        editor.store.get(key).set(!editor.store.getValue(key))
                      },
                    },
                  },
                  {
                    name: "view_timeline",
                    config: {
                      label: { text: "Timeline" },
                      shortcut: { text: "F3" },
                      callback: function() {
                        var editor = Beans.get(BeanVisuEditorController)
                        var key = "render-timeline"
                        editor.store.get(key).set(!editor.store.getValue(key))
                      },
                    },
                  },
                  {
                    name: "view_brushes",
                    config: {
                      label: { text: "Brushes" },
                      shortcut: { text: "F4" },
                      callback: function() {
                        var editor = Beans.get(BeanVisuEditorController)
                        var key = "render-brush"
                        editor.store.get(key).set(!editor.store.getValue(key))
                      },
                    },
                  },
                  {
                    name: "view_hide",
                    config: {
                      label: { text: "Hide" },
                      shortcut: { text: "F5" },
                      callback: function() {
                        var controller = Beans.get(BeanVisuController)
                        var editor = Beans.get(BeanVisuEditorController)
                        var loaderState = controller.loader.fsm.getStateName()
                        if (loaderState == "idle" || loaderState == "loaded") {
                          editor.renderUI = false
                        }
                      },
                    },
                  },
                  {
                    name: "view_move-camera",
                    config: {
                      label: { text: "Move camera" },
                      shortcut: { text: "F8" },
                      callback: function() {
                        var controller = Beans.get(BeanVisuController)
                        var camera = controller.visuRenderer.gridRenderer.camera
                        camera.enableKeyboardLook = !camera.enableKeyboardLook
                      },
                    },
                  },
                  {
                    name: "view_mouse-look",
                    config: {
                      label: { text: "Mouse look" },
                      shortcut: { text: "F9" },
                      callback: function() {
                        var controller = Beans.get(BeanVisuController)
                        var camera = controller.visuRenderer.gridRenderer.camera
                        camera.enableMouseLook = !camera.enableMouseLook
                      },
                    },
                  },
                  {
                    name: "view_fullscreen",
                    config: {
                      label: { text: "Fullscreen" },
                      shortcut: { text: "F11" },
                      callback: function() {
                        var controller = Beans.get(BeanVisuController)
                        var fullscreen = controller.displayService.getFullscreen()
                        Logger.debug("VisuIO", String.join("Set fullscreen to", fullscreen ? "'false'" : "'true'", "."))
                        controller.displayService.setFullscreen(!fullscreen)
                        Visu.settings.setValue("visu.fullscreen", !fullscreen).save()
                      }
                    },
                  },
                  {
                    name: "view_scene-config",
                    config: {
                      label: { text: "Scene config" },
                      shortcut: { text: "F12" },
                      callback: function() {
                        var editor = Beans.get(BeanVisuEditorController)
                        var key = "render-sceneConfigPreview"
                        editor.store.get(key).set(!editor.store.getValue(key))
                      },
                    },
                  },
                ],
              })

              var uiService = Beans.get(BeanVisuEditorController).uiService
              var ui = uiService.find("_context-menu", function(container, key, name) {
                return String.contains(container.name, name)
              })

              if (Optional.is(ui)) {
                uiService.send(new Event("remove", {
                  name: ui.name,
                  quiet: true,
                }))
              }

              uiService.send(new Event("add", {
                container: contextMenu,
                replace: true,
              }))
            },
          }),
          "button_ve-title-bar_grid": factoryTextButton({
            text: "Grid",
            layout: layout.nodes.grid,
            onMouseHoverOver: function() {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              if (Beans.get(BeanVisuEditorController).uiService
                  .find("ve-title-bar_grid_context-menu") == null) {
                this.callback()
              }
            },
            callback: function() {
              var root = this.area
              var anchor = {
                x: this.layout.left(),
                y: this.layout.bottom(),
              }

              var contextMenu = factoryVEContextMenu(root, anchor, {
                name: "ve-title-bar_grid_context-menu",
                components: [
                  {
                    name: "reset_grid",
                    config: {
                      label: { text: "Reset grid" },
                      shortcut: { text: "" },
                      callback: function() {
                        Beans.get(BeanVisuController).gridService.send(new Event("clear-grid"))
                      },
                    },
                  },
                  {
                    name: "clear_gr-shd",
                    config: {
                      label: { text: "Clear grid shaders" },
                      shortcut: { text: "CTRL + 1" },
                      callback: function() { 
                        Beans.get(BeanVisuController).shaderPipeline.send(new Event("clear-shaders"))
                      },
                    },
                  },
                  {
                    name: "clear_bkg-shd",
                    config: {
                      label: { text: "Clear background shaders" },
                      shortcut: { text: "CTRL + 2" },
                      callback: function() { 
                        Beans.get(BeanVisuController).shaderBackgroundPipeline.send(new Event("clear-shaders"))
                      },
                    },
                  },
                  {
                    name: "clear_combined-shd",
                    config: {
                      label: { text: "Clear combined shaders" },
                      shortcut: { text: "CTRL + 3" },
                      callback: function() { 
                        Beans.get(BeanVisuController).shaderCombinedPipeline.send(new Event("clear-shaders"))
                      },
                    },
                  },
                  {
                    name: "clear_bkg-l",
                    config: {
                      label: { text: "Clear background layers" },
                      shortcut: { text: "CTRL + 4" },
                      callback: function() { 
                        Beans.get(BeanVisuController).visuRenderer.gridRenderer.overlayRenderer.backgrounds.clear()
                      },
                    },
                  },
                  {
                    name: "clear_frg-l",
                    config: {
                      label: { text: "Clear foreground layers" },
                      shortcut: { text: "CTRL + 5" },
                      callback: function() { 
                        Beans.get(BeanVisuController).visuRenderer.gridRenderer.overlayRenderer.foregrounds.clear()
                      },
                    },
                  },
                  {
                    name: "clear_shrooms",
                    config: {
                      label: { text: "Clear shrooms" },
                      shortcut: { text: "CTRL + 6" },
                      callback: function() { 
                        Beans.get(BeanVisuController).shroomService.send(new Event("clear-shrooms"))
                      },
                    },
                  },
                  {
                    name: "clear_bullets",
                    config: {
                      label: { text: "Clear bullets" },
                      shortcut: { text: "" },
                      callback: function() { 
                        Beans.get(BeanVisuController).bulletService.send(new Event("clear-bullets"))
                      },
                    },
                  },
                  {
                    name: "clear_player",
                    config: {
                      label: { text: "Clear player" },
                      shortcut: { text: "" },
                      callback: function() { 
                        Beans.get(BeanVisuController).playerService.send(new Event("clear-player"))
                      },
                    },
                  },
                  {
                    name: "clear_coins",
                    config: {
                      label: { text: "Clear coins" },
                      shortcut: { text: "" },
                      callback: function() { 
                        Beans.get(BeanVisuController).coinService.send(new Event("clear-coins"))
                      },
                    },
                  },
                  {
                    name: "clear_subtitles",
                    config: {
                      label: { text: "Clear subtitles" },
                      callback: function() { 
                        Beans.get(BeanVisuController).subtitleService.send(new Event("clear-subtitle"))
                      },
                    },
                  },
                  {
                    name: "clear_particles",
                    config: {
                      label: { text: "Clear particles" },
                      shortcut: { text: "" },
                      callback: function() { 
                        Beans.get(BeanVisuController).particleService.send(new Event("clear-particles"))
                      },
                    },
                  },
                  {
                    name: "clear_grid-gl",
                    config: {
                      label: { text: "Clear grid glitches" },
                      shortcut: { text: "" },
                      callback: function() {
                        Beans.get(BeanVisuController).visuRenderer.gridRenderer.gridGlitchService.dispatcher.send(new Event("clear-glitch"))
                      }
                    },
                  },
                  {
                    name: "clear_bkg-gl",
                    config: {
                      label: { text: "Clear background glitches" },
                      shortcut: { text: "" },
                      callback: function() {
                        Beans.get(BeanVisuController).visuRenderer.gridRenderer.backgroundGlitchService.dispatcher.send(new Event("clear-glitch"))
                      }
                    },
                  },
                  {
                    name: "clear_combined-gl",
                    config: {
                      label: { text: "Clear combined glitches" },
                      shortcut: { text: "" },
                      callback: function() {
                        Beans.get(BeanVisuController).visuRenderer.gridRenderer.combinedGlitchService.dispatcher.send(new Event("clear-glitch"))
                      }
                    },
                  }
                ],
              })

              var uiService = Beans.get(BeanVisuEditorController).uiService
              var ui = uiService.find("_context-menu", function(container, key, name) {
                return String.contains(container.name, name)
              })

              if (Optional.is(ui)) {
                uiService.send(new Event("remove", {
                  name: ui.name,
                  quiet: true,
                }))
              }

              uiService.send(new Event("add", {
                container: contextMenu,
                replace: true,
              }))
            },
          }),
          "button_ve-title-bar_help": factoryTextButton({
            text: "Help",
            layout: layout.nodes.help,
            onMouseHoverOver: function() {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              if (Beans.get(BeanVisuEditorController).uiService
                  .find("ve-title-bar_help_context-menu") == null) {
                this.callback()
              }
            },
            callback: function() {
              var root = this.area
              var anchor = {
                x: this.layout.left(),
                y: this.layout.bottom(),
              }

              var contextMenu = factoryVEContextMenu(root, anchor, {
                name: "ve-title-bar_help_context-menu",
                components: [
                  {
                    name: "help_about",
                    config: {
                      label: { text: "About" },
                      shortcut: { text: "" },
                      callback: function() {
                        try {
                          url_open("https://github.com/Barons-Keep/visu-project")
                          var uiService = Beans.get(BeanVisuEditorController).uiService
                          uiService.send(new Event("remove", { 
                            name: this.context.name, 
                            quiet: true,
                          }))
                        } catch (exception) {
                          var message = $"Cannot open URL: {exception.message}"
                          Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
                          Logger.error("VETitleBar", message)
                        }
                      }
                    },
                  }
                ],
              })

              var uiService = Beans.get(BeanVisuEditorController).uiService
              var ui = uiService.find("_context-menu", function(container, key, name) {
                return String.contains(container.name, name)
              })

              if (Optional.is(ui)) {
                uiService.send(new Event("remove", {
                  name: ui.name,
                  quiet: true,
                }))
              }

              uiService.send(new Event("add", {
                container: contextMenu,
                replace: true,
              }))
            },
          }),
          "text_ve-title-bar_version": Struct.appendRecursiveUnique(
            {
              type: UIText,
              layout: layout.nodes.version,
              text: $"v{Visu.version()} | Build date: {date_time_string(GM_build_date)} | Runtime: {GM_runtime_version}",
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("ve-title-bar").version,
            false
          ),
          "button_ve-title-bar_scene-config-preview": factoryCheckboxButton({
            layout: layout.nodes.sceneConfigPreview,
            spriteOn: { name: "texture_ve_title_bar_icons", frame: 5 },
            spriteOff: { name: "texture_ve_title_bar_icons", frame: 5, alpha: 0.5 },
            store: { key: "render-sceneConfigPreview" },
          }),
          "button_ve-title-bar_track-control": factoryCheckboxButton({
            layout: layout.nodes.trackControl,
            spriteOn: { name: "texture_ve_title_bar_icons", frame: 4 },
            spriteOff: { name: "texture_ve_title_bar_icons", frame: 4, alpha: 0.5 },
            store: { key: "render-trackControl" },
          }),
          "button_ve-title-bar_event": factoryCheckboxButton({
            layout: layout.nodes.event,
            spriteOn: { name: "texture_ve_title_bar_icons", frame: 0 },
            spriteOff: { name: "texture_ve_title_bar_icons", frame: 0, alpha: 0.5 },
            store: { key: "render-event" },
          }),
          "button_ve-title-bar_timeline": factoryCheckboxButton({
            layout: layout.nodes.timeline,
            spriteOn: { name: "texture_ve_title_bar_icons", frame: 1 },
            spriteOff: { name: "texture_ve_title_bar_icons", frame: 1, alpha: 0.5 },
            store: { key: "render-timeline" },
          }),
          "button_ve-title-bar_brush": factoryCheckboxButton({
            layout: layout.nodes.brush,
            spriteOn: { name: "texture_ve_title_bar_icons", frame: 2 },
            spriteOff: { name: "texture_ve_title_bar_icons", frame: 2, alpha: 0.5 },
            store: { key: "render-brush" },
          }),
          "button_ve-title-fullscreen": factoryCheckboxButton({
            layout: layout.nodes.fullscreen,
            spriteOn: { name: "texture_ve_title_bar_icons", frame: 3 },
            spriteOff: { name: "texture_ve_title_bar_icons", frame: 3 },
            callback: function(event) {
              var displayService = Beans.get(BeanVisuController).displayService
              var fullscreen = displayService.getFullscreen()
              displayService.setFullscreen(!fullscreen)
            },
          }),
          "line_ve-title-bottomLine": {
            type: UIImage,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            layout: layout.nodes.bottomLine,
            backgroundColor: VETheme.color.accentShadow,
            backgroundAlpha: 0.85,
          },
        },
      }),
    })
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open": function(event) {
      this.containers = this.factoryContainers(event.data.layout)
      containers.forEach(function(container, key, uiService) {
        uiService.send(new Event("add", {
          container: container,
          replace: true,
        }))
      }, Beans.get(BeanVisuEditorController).uiService)
    },
    "close": function(event) {
      var context = this
      this.containers.forEach(function(container, key, uiService) {
        uiService.dispatcher.execute(new Event("remove", { 
          name: key, 
          quiet: true,
        }))
      }, Beans.get(BeanVisuEditorController).uiService).clear()
    },
  }), { 
    enableLogger: false, 
    catchException: false,
  })

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {VETitleBar}
  update = function() { 
    try {
      this.dispatcher.update()
    } catch (exception) {
      var message = $"VETitleBar dispatcher fatal error: {exception.message}"
      Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
      Logger.error("UI", message)
    }
    return this
  }
}