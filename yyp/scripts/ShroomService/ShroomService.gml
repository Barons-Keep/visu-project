///@package io.alkapivo.visu.service.shroom

///@param {VisuController} _controller
///@param {Struct} [config]
function ShroomService(_controller, config = {}): Service() constructor {

  ///@type {VisuController}
  controller = Assert.isType(_controller, VisuController)

  ///@type {Array<Shroom>} 
  shrooms = new Array(Shroom).enableGC()

  ///@type {GridItemChunkService}
  chunkService = new GridItemChunkService(GRID_ITEM_CHUNK_SERVICE_SIZE)

  ///@type {Map<String, ShroomTemplate>}
  templates = new Map(String, ShroomTemplate)

  ///@type {?Struct}
  spawner = null

  ///@type {?Struct}
  spawnerEvent = null

  ///@type {?Struct}
  particleArea = null

  ///@type {?Struct}
  particleAreaEvent = null

  ///@type {?Struct}
  subtitlesArea = null

  ///@type {?Struct}
  subtitlesAreaEvent = null

  ///@param {?Struct} [json]
  ///@return {Struct}
  factorySpawner = function(json = null) {
    return Struct.appendUnique(json, {
      x: 0.5,
      y: 0.0,
      sprite: SpriteUtil.parse({ name: "texture_baron" }),
      timeout: 5.0,
    })
  }

  ///@param {String} name
  ///@return {?ShroomTemplate}
  getTemplate = function(name) {
    var template = this.templates.get(name)
    return template == null
      ? Visu.assets().shroomTemplates.get(name)
      : template
  }

  ///@param {Boolean}
  optimalizationSortEntitiesByTxGroup = false

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "spawn-shroom": function(event) {
      var view = this.controller.gridService.view
      var locked = this.controller.gridService.targetLocked
      var template = new ShroomTemplate(event.data.template, this
        .getTemplate(event.data.template)
        .serialize())
      
      /*
      var spawnX = Assert.isType(Struct
        .getDefault(event.data, "spawnX", choose(1, -1) * random(3) * (random(100) / 100)), Number)
      var spawnY = Assert.isType(Struct
        .getDefault(event.data, "spawnY", -1 * random(2) * (random(100) / 100)), Number)
      var angle = Assert.isType(Struct
        .getDefault(event.data, "angle", 270), Number
      var spd = Assert.isType(Struct
        .getDefault(event.data, "speed", 5), Number)
      var viewX = Struct.getDefault(event.data, "snapH", true)
        ? floor(view.x / (view.width / 2.0)) * (view.width / 2.0)
        : view.x
      var viewY = Struct.getDefault(event.data, "snapV", true)
        ? floor(view.y / (view.height / 2.0)) * (view.height / 2.0)
        : view.y
      */

      var spawnX = event.data.spawnX
      var spawnY = event.data.spawnY
      var angle = event.data.angle
      var spd = event.data.speed
      var viewX = event.data.snapH ? locked.snapH : view.x
      var viewY = event.data.snapV ? locked.snapV : view.y
      Struct.set(template, "x", viewX + spawnX)
      Struct.set(template, "y", viewY + spawnY)
      Struct.set(template, "speed", spd / GRID_ITEM_SPEED_SCALE)
      Struct.set(template, "angle", angle)
      Struct.set(template, "uid", this.controller.gridService.generateUID())
      if (Optional.is(Struct.get(event.data, "lifespan"))) {
        Struct.set(template, "lifespanMax", event.data.lifespan)
      }

      if (Optional.is(Struct.get(event.data, "hp"))) {
        Struct.set(template, "healthPoints", event.data.hp)
      }
      
      var inherit = Struct.get(event.data, "inherit")
      var inheritSize = inherit != null ? GMArray.size(inherit) : 0
      var templateInheritSize = template.inherit != null ? GMArray.size(template.inherit) : 0
      if (inheritSize + templateInheritSize > 0) {
        var service = this
        var acc = {
          names: { },
          service: service,
          template: template,
        }

        for (var idx = 0; idx < templateInheritSize; idx++) {
          this.parseInherit(template.inherit[idx], idx, acc)
        }

        for (var idx = 0; idx < inheritSize; idx++) {
          this.parseInherit(inherit[idx], idx, acc)
        }
      }


      var shroom = new Shroom(template)

      this.shrooms.add(shroom)
      this.chunkService.add(shroom)

      if (this.optimalizationSortEntitiesByTxGroup) {
        this.controller.gridService.textureGroups.sortItems(this.shrooms)
      }
    },
    "spawn-shroom-emitter": function(event) {

    },
    "clear-shrooms": function(event) {
      this.shrooms.clear()
      this.executor.tasks.forEach(TaskUtil.fullfill).clear()
      this.chunkService.clear()
    },
    "reset-templates": function(event) {
      this.templates.clear()
      this.dispatcher.container.clear()
    },
  }))

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this, { 
    loggerPrefix: "ShroomServiceExecutor",
    enableLogger: true,
    catchException: true,
    exceptionCallback: function(task, exception) {
      Beans.get(BeanVisuController).exceptionDebugHandler(
        $"'ShroomService::executor' (task.name: {task.name}), fatal error: {exception.message}")
    },
  })

  static parseInherit = function(name, i, acc) {
    static add = function(item, index, collection) {
      GMArray.add(collection, item)
    }

    if (Struct.get(acc.names, name) == true) {
      return
    }

    Struct.set(acc.names, name, true)

    var template = acc.service.getTemplate(name)
    if (template == null) {
      return
    }

    GMArray.forEach(template.onDamage, add, acc.template.onDamage)
    GMArray.forEach(template.onDeath, add, acc.template.onDeath)
    GMArray.forEach(template.queue, add, acc.template.queue)
    GMArray.forEach(template.features, add, acc.template.features)
    for (var index = 0; index < GMArray.size(template.inherit); index++) {
      acc.service.parseInherit(template.inherit[index], index, acc)
    }
  }

  static spawnShroom = function(name, spawnX, spawnY, angle, spd, snapH, snapV, lifespan, hp, inherit) {
    var view = this.controller.gridService.view
    var locked = this.controller.gridService.targetLocked
    var viewX = snapH ? locked.snapH : view.x
    var viewY = snapV ? locked.snapV : view.y
    var template = this.getTemplate(name).serializeSpawn(viewX + spawnX, viewY + spawnY, spd / GRID_ITEM_SPEED_SCALE, angle, this.controller.gridService.generateUID(), lifespan, hp)

    var inheritSize = inherit != null ? GMArray.size(inherit) : 0
    var templateInheritSize = template.inherit != null ? GMArray.size(template.inherit) : 0
    if (inheritSize + templateInheritSize > 0) {
      var service = this
      var acc = {
        names: { },
        service: service,
        template: template,
      }

      for (var idx = 0; idx < templateInheritSize; idx++) {
        this.parseInherit(template.inherit[idx], idx, acc)
      }

      for (var idx = 0; idx < inheritSize; idx++) {
        this.parseInherit(inherit[idx], idx, acc)
      }
    }

    var shroom = new Shroom(template)

    this.shrooms.add(shroom)
    this.chunkService.add(shroom)

    if (this.optimalizationSortEntitiesByTxGroup) {
      this.controller.gridService.textureGroups.sortItems(this.shrooms)
    }
  }

  ///@param {Struct} item
  ///@param {Struct} emitter
  static spawnShroomEmitter = function(item, emitter) {
    var task = new Task("shroom-emitter")
      .setTimeout(60.0)
      .setState({
        item: item,
        emitter: new GridItemEmitter(Struct.appendRecursive({
          callback: function(item, controller, emitter, idx, arrIdx, x, y, angle, speed) {
            controller.shroomService.spawnShroom(
              item.name,
              item.spawnX + x,
              item.spawnY + y,
              angle,
              speed,
              item.snapH,
              item.snapV,
              item.lifespan,
              item.hp,
              item.inherit
            )
          }
        }, emitter, false)),
      })
      .whenUpdate(function() {
        if (this.state.emitter.finished()) {
          this.fullfill()
          return
        }

        this.state.emitter.update(this.state.item, Beans.get(BeanVisuController))
      })
    this.executor.add(task)
    return this
  }

  ///@param {Event} event
  ///@return {?Promise}
  static send = function(event) {
    gml_pragma("forceinline")
    return this.dispatcher.send(event)
  }

  static updateShroom = function(shroom, index, context) {
    gml_pragma("forceinline")
    shroom.update(context.controller)
    if (shroom.signals.kill) {
      context.shrooms.addToGC(index)
      context.chunkService.remove(shroom)
    }
  }

  ///@return {ShroomService}
  update = function() {
    //this.optimalizationSortEntitiesByTxGroup = Visu.settings.getValue("visu.optimalization.sort-entities-by-txgroup")
    this.dispatcher.update()
    this.executor.update()
    this.shrooms.forEach(this.updateShroom, this).runGC()
    return this
  }

  this.send(new Event("reset-templates"))
}
