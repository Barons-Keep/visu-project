///@package io.alkapivo.core.service.particle

#macro GMParticleSystem "GMParticleSystem"
#macro GMParticleEmitter "GMParticleEmitter"


///@enum
function _ParticleEmitterShape(): Enum() constructor {
  RECTANGLE = ps_shape_rectangle
  ELLIPSE = ps_shape_ellipse
  DIAMOND = ps_shape_diamond
  LINE = ps_shape_line

  ///@override
  ///@return {Array<String>}
  keys = function() {
    static filterKeys = function(key) {
      return key != "_keys"
          && key != "keys"
          && key != "get"
          && key != "getKey"
          && key != "findKey"
          && key != "contains"
          && key != "containsKey"
    }

    if (this._keys == null) {
      this._keys = new Array(String, GMArray.sort(GMArray.filter(Struct.keys(this), filterKeys)))
    }

    return this._keys
  }
}
global.__ParticleEmitterShape = new _ParticleEmitterShape()
#macro ParticleEmitterShape global.__ParticleEmitterShape

///@enum
function _ParticleEmitterDistribution(): Enum() constructor {
  LINEAR = ps_distr_linear
  GAUSSIAN = ps_distr_gaussian
  INVERTEDGAUSSIAN = ps_distr_invgaussian

  ///@override
  ///@return {Array<String>}
  keys = function() {
    static filterKeys = function(key) {
      return key != "_keys"
          && key != "keys"
          && key != "get"
          && key != "getKey"
          && key != "findKey"
          && key != "contains"
          && key != "containsKey"
    }

    if (this._keys == null) {
      this._keys = new Array(String, GMArray.sort(GMArray.filter(Struct.keys(this), filterKeys)))
    }

    return this._keys
  }
}
global.__ParticleEmitterDistribution = new _ParticleEmitterDistribution()
#macro ParticleEmitterDistribution global.__ParticleEmitterDistribution


///@param {String} _layerName
function ParticleSystem(_layerName) constructor {

  ///@type {String}
  layerName = Assert.isType(_layerName, String)

  ///@type {GMParticleSystem}
  asset = part_system_create_layer(this.layerName, false)
  part_system_automatic_update(this.asset, false)
  part_system_automatic_draw(this.asset, false)

  ///@type {GMEmitter}
  emitter = part_emitter_create(this.asset)

  ///@private
  ///@type {TaskExecutor}
  executor = new TaskExecutor(this)

  ///@private
  ///@type {Stack<ParticleTemplate>}
  gc = new Stack(ParticleTemplate)

  ///@param {Boolean} [runGC]
  ///@return {ParticleSystem}
  clear = function(runGC = false) {
    this.executor.tasks.forEach(TaskUtil.fullfill).clear()
    if (!Core.isType(this.asset, GMParticleSystem)) {
      Logger.debug("ParticleSystem", $"clear: System '{this.layerName}' must be type of GMParticleSystem. GC size: {this.gc.size()}")
      return this
    }

    part_particles_clear(this.asset)
    if (!runGC) {
      return this
    }

    this.gc.forEach(function(template) {
      Logger.debug("ParticleSystem", $"Clear particle template, name: {template.name}")
      template.free()
    })

    return this
  }

  ///@return {ParticleSystem}
  update = function() {
    if (!Core.isType(this.asset, GMParticleSystem)) {
      this.asset = part_system_create_layer(this.layerName, false)
      this.emitter = part_emitter_create(this.asset)
      part_system_automatic_update(this.asset, false)
      part_system_automatic_draw(this.asset, false)
    }

    if (typeof(this.emitter) != "ref" || !part_emitter_exists(this.asset, this.emitter)) {
      this.emitter = part_emitter_create(this.asset)
    }

    this.executor.update()

    part_system_update(this.asset)
    return this
  }

  render = function() {
    if (!Core.isType(this.asset, GMParticleSystem)) {
      this.asset = part_system_create_layer(this.layerName, false)
      this.emitter = part_emitter_create(this.asset)
      part_system_automatic_update(this.asset, false)
      part_system_automatic_draw(this.asset, false)
    }

    if (typeof(this.emitter) != "ref" || !part_emitter_exists(this.asset, this.emitter)) {
      this.emitter = part_emitter_create(this.asset)
    }
    
    part_system_drawit(this.asset)
  }
   
  ///@return {ParticleService}
  free = function() {
    Logger.debug("ParticleSystem", $"Free '{this.layerName}'")
    part_system_destroy(this.asset)
    this.gc.forEach(function(template) {
      Logger.debug("ParticleType", $"Free '{template.particle.name}'")
      part_type_destroy(template.particle.asset)
    })
    return this
  }
}


///@param {?Struct} [config]
function ParticleService(config = null): Service() constructor {

  ///@type {Map<String, ParticleTemplate>}
  templates = new Map(String, ParticleTemplate)

  ///@type {Map<String, ParticleSystem}
  systems = Struct.getDefault(config, "systems", new Map(String, ParticleSystem, {
    main: new ParticleSystem(Struct.get(config, "layerName")),
  }))

  ///@return {Map<String, ParticleTemplate>}
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

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "spawn-particle-emitter": function(event) {
      var task = new Task("emmit-particle")
        .setTimeout(Struct.getDefault(event.data, "duration", FRAME_MS))
        .setTick(Struct.getDefault(event.data, "interval", FRAME_MS))
        .setState(event.data)
        .whenTimeout(function() {
          this.fullfill()
        })
        .whenUpdate(function(executor) {
          var particle = this.state.template.particle
          if (particle == null) {
            Logger.debug("ParticleService", $"Found nullable particle in emmit-particle task, name: {this.state.template.name}")
            this.fullfill()
            return
          }
          
          var system = this.state.system
          part_emitter_region(
            system.asset,
            system.emitter,
            this.state.beginX,
            this.state.beginY,
            this.state.endX,
            this.state.endY,
            this.state.shape,
            this.state.distribution
          )

          part_emitter_burst(
            system.asset,
            system.emitter,
            particle.asset,
            this.state.amount
          )
        })
      event.data.system.executor.add(task)
    },
    "clear-particles": function(event) {
      this.systems.forEach(function(system) { system.clear(false) })
    },
    "reset-templates": function(event) {
      this.systems.forEach(function(system) { system.clear(true) })
      this.templates.clear()
      this.dispatcher.container.clear()
    },
  }))

  ///@param {ParticleSystem} system
  ///@param {String} name
  ///@return {?ParticleTemplate}
  factoryParticle = function(system, name) {
    var template = this.getTemplate(name)
    if (template != null) {
      if (template.particle == null) {
        Logger.debug("ParticleService", $"Add new Particle Type, name: {name}")
        template.particle = new Particle(template)
        system.gc.push(template)
      }

      return template
    }

    return null
  }

  ///@param {Struct} config
  ///@return {Event}
  factoryEventSpawnParticleEmitter = function(config) {
    var systemName = Struct.getDefault(config, "systemName", "main")
    var system = this.systems.get(systemName)
    if (system == null) {
      Logger.warn("ParticleService", $"Found null system for name: {systemName}")
      return
    }

    var particleName = Struct.getDefault(config, "particleName", "particle-default")
    var template = this.factoryParticle(system, particleName)
    if (template == null) {
      Logger.warn("ParticleService", $"Found null particle-template for name: {particleName}, system: {systemName}")
      return
    }

    return new Event("spawn-particle-emitter", {
      system: system,
      template: template,
      beginX: Struct.get(config, "beginX"),
      endX: Struct.get(config, "endX"),
      beginY: Struct.get(config, "beginY"),
      endY: Struct.get(config, "endY"),
      duration: Struct.getDefault(config, "duration", 0.0),
      amount: Struct.getDefault(config, "amount", 1.0),
      interval: Struct.getDefault(config, "interval", FRAME_MS),
      shape: Struct.getDefault(config, "shape", ParticleEmitterShape.ELLIPSE),
      distribution: Struct.getDefault(config, "distribution", ParticleEmitterDistribution.LINEAR),
    })
  }

  ///@param {String} systemName
  ///@param {String} particleName
  ///@param {Number} beginX
  ///@param {Number} beginY
  ///@param {Number} endX
  ///@param {Number} endY
  ///@param {Number} [duration]
  ///@param {Number} [amount]
  ///@param {Number} [interval]
  ///@param {ParticleEmitterShape} [shape]
  ///@param {ParticleEmitterDistribution} [distribution]
  spawnParticleEmitter = function(systemName, particleName, beginX, beginY, endX, endY, duration = 0, amount = 1, interval = FRAME_MS, shape = ParticleEmitterShape.ELLIPSE, distribution = ParticleEmitterDistribution.LINEAR) {
    var system = this.systems.get(systemName)
    if (system == null) {
      Logger.warn("ParticleService", $"Found null system for name: {systemName}")
      return
    }

    var template = this.factoryParticle(system, particleName)
    if (template == null) {
      Logger.warn("ParticleService", $"Found null particle-template for name: {particleName}, system: {systemName}")
      return
    }

    var task = new Task("emmit-particle")
      .setTimeout(duration)
      .setTick(interval)
      .setState({
        template: template,
        system: system,
        beginX: beginX,
        beginY: beginY,
        endX: endX,
        endY: endY,
        duration: duration,
        amount: amount,
        interval: interval,
        shape: shape,
        distribution: distribution,
      })
      .whenTimeout(function() {
        this.fullfill()
      })
      .whenUpdate(function(executor) {
        var particle = this.state.template.particle
        if (particle == null) {
          Logger.debug("ParticleService", $"Found nullable particle in emmit-particle task, name: {this.state.template.name}")
          this.fullfill()
          return
        }

        var system = this.state.system
        part_emitter_region(
          system.asset, 
          system.emitter,
          this.state.beginX,
          this.state.endX,
          this.state.beginY,
          this.state.endY,
          this.state.shape,
          this.state.distribution
        )

        part_emitter_burst(
          system.asset,
          system.emitter,
          particle.asset,
          this.state.amount
        )
      })
    system.executor.add(task)
  }

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {ParticleService}
  update = function() {
    this.dispatcher.update()
    this.systems.forEach(function(system) {
      system.update()
    })

    return this
  }

  free = function() {
    this.systems.forEach(function(system) {
      system.free()
    })
  }

  this.send(new Event("reset-templates"))
}
