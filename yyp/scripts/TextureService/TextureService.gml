///@package io.alkapivo.core.service.texture

///@type {String}
#macro BeanTextureService "TextureService"

///@param {?Struct} [config]
function TextureService(config = null): Service(config) constructor {

  ///@type {Map<String, any}
  assets = new Map(String, any)

  ///@type {Map<String, TextureTemplate>}
  templates = new Map(String, TextureTemplate)

  ///@return {Map<String, TextureTemplate>}
  getStaticTemplates = method(this, Core.isType(Struct.get(config, "getStaticTemplates"), Callable)
    ? config.getStaticTemplates
    : function() {
      return this.templates
    })

  ///@param {String} name
  ///@return {?TextureTemplate}
  getTemplate = function(name) {
    var template = this.templates.get(name)
    return template == null
      ? this.getStaticTemplates().get(name)
      : template
  }
  
  ///@private
  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "load-texture": function(event) {
      static filterByName = function(task, index, name) {
        return task.state.get("name") == name
      }

      var texture = event.data
      if (!Core.isType(texture, TextureIntent)) {
        event.promise.reject("load-texture event data must be type of TextureIntent")
        return
      }
      
      if (this.assets.contains(texture.name)) {
        event.promise.reject($"load-texture asset '{texture.name}' already exists")
        return
      }

      if (templates.contains(texture.name)) {
        event.promise.reject($"Texture '{texture.name}' already exists")
        return
      }

      if (this.executor.tasks.find(filterByName, texture.name) != null) {
        event.promise.reject($"Task for texture '{texture.name}' already exists")
        return
      }

      var asset = sprite_add_ext(texture.file, texture.frames, texture.originX, texture.originY, texture.prefetch)
      this.assets.add(asset, texture.name)
      var task = new Task("load-texture")
        .setPromise(event.promise)
        .setState(new Map(String, any, {
          texture: texture,
          asset: asset,
        }))
        .whenUpdate(function() { })
      this.executor.add(task)
      event.setPromise() // disable promise in EventPump, the promise will be resolved within TaskExecutor
    },
    "free": function(event) {
      this.free()
    },
  }))

  ///@private
  ///@type {TaskExecutor}
  executor = new TaskExecutor(this)

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@override
  ///@return {TextureService}
  update = function() {
    this.dispatcher.update()
    this.executor.update()
    return this
  }

  ///@override
  ///@return {TextureService}
  free = function() {
    this.templates.forEach(function(template, name, assets) {
      try {
        Logger.debug("TextureService", $"Free texture '{name}'")
        sprite_delete(template.asset)
        delete template
        if (assets.contains(name)) {
          assets.remove(name)
        }
      } catch (exception) {
        Logger.error("TextureService", $"Unable to free texture '{name}'. {exception.message}")
        Core.printStackTrace().printException(exception)
      }
    }, this.assets).clear()

    this.assets.forEach(function(asset, name) {
      try {
        Logger.debug("TextureService", $"Free texture asset '{name}'")
        sprite_delete(asset)
      } catch (exception) {
        Logger.error("TextureService", $"Free texture asset'{name}' exception: {exception.message}")
        Core.printStackTrace().printException(exception)
      }
    }).clear()
    return this
  }

  ///@param {Event}
  ///@return {TextureService}
  onTextureLoadedEvent = function(event) {
    static findTask = function(task, index, asset) {
      return task.state.get("asset") == asset
    }

    var task = this.executor.tasks.find(findTask, event.data.asset)
    if (task == null) {
      throw new Exception($"Task for file '{event.data.file}' does not exists")
    }
    
    try {
      var config = Assert.isType(task.state.get("texture"), TextureIntent,
        "TextureService::onTextureLoadedEvent texture must be type of TextureIntent")
      Assert.isTrue(event.data.status == 0,
        "TextureService::onTextureLoadedEvent event data::status must be equal 0")
      Assert.isTrue(event.data.httpStatus == 200,
        "TextureService::onTextureLoadedEvent event data::httpStatus must be equal 200")

      Struct.set(config, "asset", event.data.asset)
      Struct.set(config, "file", FileUtil.get(event.data.file))

      this.templates.add(new TextureTemplate(config.name, config), config.name)
      task.promise.fullfill(config.name)
    } catch (exception) {
      task.promise.reject(exception.message)
      Core.printStackTrace().printException(exception)
    }

    return this
  }
}
