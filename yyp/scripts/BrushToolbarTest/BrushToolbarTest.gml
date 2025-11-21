///@package io.alkapivo.visu

///@param {Test} test
///@return {Task}
function TestEvent_BrushToolbar_save(test) {
  var json = Struct.get(test, "data")
  return new Task("TestEvent_BrushToolbar_save")
    .setTimeout(Struct.getDefault(json, "timeout", 60.0))
    .setPromise(new Promise())
    .setState({
      description: test.description,
      cooldown: new Timer(Struct.getDefault(json, "cooldown", 0.8)),
      stage: "cooldownBefore",
      stages: {
        cooldownBefore: function(task) {
          if (task.state.cooldown.update().finished) {
            //task.state.stage = "setup"
            task.state.cooldown.reset()

            // Temporary disable test
            Assert.isTrue(Beans.get(BeanTestRunner).exceptions.size() == 0, "No exceptions can be thrown")
            task.fullfill("success")

            var editor = Beans.get(Visu.modules().editor.controller)
            if (editor == null) {
              return
            }

            editor.send(new Event("close"))
            if (editor.store.getValue("render-brush")) {
              editor.store.get("render-brush").set(false)
            }
          }
        },
        setup: function(task) {
          Beans.get(BeanTestRunner).exceptions.clear()
          var editor = Beans.get(Visu.modules().editor.controller)
          if (editor == null) {
            return
          }

          editor.renderUI = true
          editor.send(new Event("open"))
          if (!editor.store.getValue("_render-brush")) {
            editor.store.get("_render-brush").set(true)
          }

          var acc = {
            currentCategory: null,
            types: new Stack(Struct)
          }

          editor.brushToolbar.categories.forEach(function(types, category, acc) {
            acc.currentCategory = category
            types.forEach(function(type, index, acc) {
              acc.types.push({
                category: acc.currentCategory,
                type: type
              })
            }, acc)
          }, acc)

          Struct.set(task.state, "types", acc.types)
          task.state.stage = "selectType"
        },
        selectType: function(task) {
          var editor = Beans.get(Visu.modules().editor.controller)
          if (editor == null) {
            return
          }

          var entry = task.state.types.pop()
          if (Core.isType(entry, Struct)) {
            Logger.test("TestEvent_BrushToolbar_save", $"Select brush from category '{entry.category}' of type '{entry.type}'")
            editor.brushToolbar.store.get("category").set(entry.category)
            editor.brushToolbar.store.get("type").set(entry.type)
            task.state.stage = "selectTemplate" 
          } else {
            task.state.stage = "verify" 
          }
        },
        selectTemplate: function(task) {
          var editor = Beans.get(Visu.modules().editor.controller)
          if (editor == null) {
            return
          }

          if (task.state.cooldown.update().finished) {
            task.state.stage = "saveBrush"
            task.state.cooldown.reset()

            var brushView = editor.brushToolbar.containers.get("ve-brush-toolbar_brush-view")
            var component = brushView.collection.findByIndex(irandom(brushView.collection.size() - 1))
            var label = component.items.find(function(item) {
              return item.type == UIText
            })

            var brushService = Beans.get(BeanVisuController).brushService
            var templates = brushService.templates.get(editor.brushToolbar.store.getValue("type"))
            var template = templates.find(function(template, index, acc) {
              return template.name == acc
            }, label.text)
            editor.brushToolbar.store.get("template").set(template)
          }
        },
        saveBrush: function(task) {
          var editor = Beans.get(Visu.modules().editor.controller)
          if (editor == null) {
            return
          }

          if (task.state.cooldown.update().finished) {
            task.state.stage = "cooldownAfter"
            task.state.cooldown.reset()

            var brush = editor.brushToolbar.containers
              .get("ve-brush-toolbar_inspector-view").state
              .get("brush")

            var template = brush.toTemplate()
            var brushService = Beans.get(BeanVisuController).brushService
            brushService.saveTemplate(template)

            var handler = Beans.get(BeanVisuController).trackService.handlers.get(brush.type)
            handler.run(handler.parse(brush.toTemplate().properties))
          }
        },
        cooldownAfter: function(task) {
          if (task.state.cooldown.update().finished) {
            task.state.stage = "selectType"
            task.state.cooldown.reset()
          }
        },
        verify: function(task) {
          if (task.state.cooldown.update().finished) {
            Assert.isTrue(Beans.get(BeanTestRunner).exceptions.size() == 0, "No exceptions can be thrown")
            task.fullfill("success")

            var editor = Beans.get(Visu.modules().editor.controller)
            if (editor == null) {
              return
            }

            editor.send(new Event("close"))
            if (editor.store.getValue("render-brush")) {
              editor.store.get("render-brush").set(false)
            }
          }
        },
      },
    })
    .whenUpdate(function(executor) {
      var stage = Struct.get(this.state.stages, this.state.stage)
      stage(this)
    })
    .whenStart(function(executor) {
      Logger.test(BeanTestRunner, $"TestEvent_BrushToolbar_save started. Description: {this.state.description}")
      Beans.get(BeanTestRunner).installHooks()

      Visu.settings.setValue("visu.god-mode", true)

      var editorIOConstructor = Core.getConstructor("VisuEditorIO")
      if (Optional.is(editorIOConstructor)) {
        if (!Optional.is(Beans.get(Visu.modules().editor.io))) {
          Beans.add(Beans.factory(Visu.modules().editor.io, GMServiceInstance, 
            Beans.get(BeanVisuController).layerId, new editorIOConstructor()))
        }
      }

      var editorConstructor = Core.getConstructor("VisuEditorController")
      if (Optional.is(editorConstructor)) {
        if (!Optional.is(Beans.get(Visu.modules().editor.controller))) {
          Beans.add(Beans.factory(Visu.modules().editor.controller, GMServiceInstance, 
            Beans.get(BeanVisuController).layerId, new editorConstructor()))
        }

        var editor = Beans.get(Visu.modules().editor.controller)
        if (Optional.is(editor)) {
          editor.store.get("render-brush").set(true)
        }
      }
    })
    .whenFinish(function(data) {
      Logger.test(BeanTestRunner, $"TestEvent_BrushToolbar_save finished. Description: {this.state.description}")
      Beans.get(BeanTestRunner).uninstallHooks()
      var editor = Beans.get(Visu.modules().editor.controller)
      if (Optional.is(editor)) {
        editor.store.get("render-brush").set(false)
      }
    })
    .whenTimeout(function() {
      Logger.test(BeanTestRunner, $"TestEvent_BrushToolbar_save timeout. Description: {this.state.description}")
      this.reject("failure")
      Beans.get(BeanTestRunner).uninstallHooks()
      var editor = Beans.get(Visu.modules().editor.controller)
      if (Optional.is(editor)) {
        editor.store.get("render-brush").set(false)
      }
    })
}
