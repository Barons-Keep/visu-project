///@package io.alkapivo.visu

#macro BeanVisuController "VisuController"
///@param {String} layerName
function VisuController(layerName) constructor {

  ///@type {GMLayer}
  layerId = Assert.isType(Scene.getLayer(layerName), GMLayer,
    "VisuController::layerID must be type of GMLayer")

  ///@type {Difficulty}
  difficulty = Difficulty.NORMAL

  ///@type {?VisuTrack}
  track = null
  
  ///@type {?Sound}
  ostSound = null

  ///@type {FSM}
  fsm = VisuStateMachine(this, BeanVisuController)

  ///@type {VisuTrackLoader}
  loader = new VisuTrackLoader(this)

  ///@type {Server}
  server = new Server({
    type: SocketType.WS,
    port: int64(Core.getProperty("visu.server.port", "8082")),
    maxClients: Core.getProperty("visu.server.maxClients", 2),
  })

  ///@type {ShaderPipeline}
  shaderPipeline = new ShaderPipeline({
    getLimit: function() {
      return Visu.settings.getValue("visu.graphics.shaders-limit")
    },
    getTemplate: function(name) {
      var template = this.templates.get(name)
      return template == null
        ? Visu.assets().shaderTemplates.get(name)
        : template
    },
  })

  ///@type {ShaderPipeline}
  shaderBackgroundPipeline = new ShaderPipeline({
    templates: this.shaderPipeline.templates,
    getLimit: function() {
      return Beans.get(BeanVisuController).shaderPipeline.getLimit()
    },
    getTemplate: function(name) {
      return Beans.get(BeanVisuController).shaderPipeline.getTemplate(name)
    },
  })

  ///@type {ShaderPipeline}
  shaderCombinedPipeline = new ShaderPipeline({
    templates: this.shaderPipeline.templates,
    getLimit: function() {
      return Beans.get(BeanVisuController).shaderPipeline.getLimit()
    },
    getTemplate: function(name) {
      return Beans.get(BeanVisuController).shaderPipeline.getTemplate(name)
    },
  })

  ///@type {UIService}
  uiService = new UIService(this)

  ///@type {DisplayService}
  displayService = new DisplayService(this, { 
    minWidth: 800, 
    minHeight: 480,
    windowWidth: Visu.settings.getValue("visu.window.width", 1440),
    windowHeight: Visu.settings.getValue("visu.window.height", 900),
    scale: Visu.settings.getValue("visu.interface.scale"),
  })

  ///@type {ParticleService}
  particleService = new ParticleService({ 
    layerName: layerName,
    getStaticTemplates: function() {
      return Visu.assets().particleTemplates
    },
  })

  ///@type {TrackService}
  trackService = new TrackService(this, {
    handlers: new Map(String, Struct)
      .merge(
        DEFAULT_TRACK_EVENT_HANDLERS,
        new Map(String, Struct, effect_track_event),
        new Map(String, Struct, entity_track_event),
        new Map(String, Struct, grid_track_event),
        new Map(String, Struct, view_track_event)
      )
      .forEach(function(handler) {
        Struct.set(handler, "parse", Struct.getIfType(handler, "parse", Callable, Lambda.passthrough))
        Struct.set(handler, "serialize", Struct.getIfType(handler, "serialize", Callable, Struct.serialize))
        Struct.set(handler, "run", Struct.getIfType(handler, "run", Callable, Lambda.dummy))
      }),
    isTrackLoaded: function() {
      var stateName = this.context.fsm.getStateName()
      return Core.isType(this.track, Track) 
          && (stateName == "play" 
          || stateName == "pause" 
          || stateName == "paused"
          || stateName == "game-over"
          || stateName == "rewind") 
    },
  })

  ///@type {PlayerService}
  playerService = new PlayerService(this)

	///@type {ShroomService}
  shroomService = new ShroomService(this)

	///@type {BulletService}
  bulletService = new BulletService(this)

  ///@type {CoinService}
  coinService = new CoinService()

  ///@type {GridService}
  gridService = new GridService(this)

  ///@type {VideoService}
  videoService = new VideoService()

  ///@type {SFXService}
  sfxService = new SFXService()

  ///@type {SubtitleService}
  subtitleService = new SubtitleService(this)

  ///@type {VEBrushService}
  brushService = new VEBrushService()

  ///@type {VisuRenderer}
  visuRenderer = new VisuRenderer(this)

  ///@type {VisuMenu}
  menu = new VisuMenu()

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "game-over": function(event) {
      this.fsm.dispatcher.send(new Event("transition", { name: "game-over" }))
    },
    "load": function(event) {
      this.fsm.dispatcher.send(new Event("transition", { 
        name: "load", 
        data: event.data
      }))
    },
    "play": function(event) {
      this.fsm.dispatcher.send(new Event("transition", { name: "play" }))
    },
    "pause": function(event) {
      this.fsm.dispatcher.send(new Event("transition", Struct
        .appendUnique({ name: "pause" }, event.data)))
    },
    "rewind": function(event) {
      var fsmEvent = new Event("transition", { 
        name: "rewind", 
        data: {
          resume: Core.isType(Struct.get(event.data, "resume"), Boolean) 
            ? event.data.resume : this.fsm.getStateName() == "play",
          timestamp: Assert.isType(event.data.timestamp, Number),
          videoServiceAttempts: Struct.getDefault(
            event.data, 
            "videoServiceAttempts", 
            Core.getProperty("core.video-service.attempts", 3)
          ),
        }
      })
      
      if (Core.isType(event.promise, Promise)) {
        fsmEvent.setPromise(event.promise)
        event.setPromise(null)
      }
      this.fsm.dispatcher.execute(fsmEvent)
    },
    "quit": function(event) {
      this.fsm.dispatcher.send(new Event("transition", { name: "quit" }))
    },
    "spawn-popup": function(event) {
      var _editor = Beans.get(Visu.modules().editor.controller)
      if (Optional.is(_editor)) {
        _editor.popupQueue.send(new Event("push", event.data))
      }
    },
    "spawn-track-event": function(event) {
      var handler = this.trackService.handlers.get(Struct.get(event.data, "callable"))
      if (Optional.is(handler)) {
        handler.run(handler.parse(Struct.get(event.data, "config")))
      }
    },
    "transform-property": Callable.run(Struct.get(EVENT_DISPATCHERS, "transform-property")),
    "fade-sprite": Callable.run(Struct.get(EVENT_DISPATCHERS, "fade-sprite")),
    "fade-color": Callable.run(Struct.get(EVENT_DISPATCHERS, "fade-color")),
  }), {
    loggerPrefix: BeanVisuController,
    enableLogger: true,
    catchException: false,
  })

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this, {
    loggerPrefix: BeanVisuController,
    enableLogger: true,
    catchException: false,
  })

  ///@private
  ///@type {DebugTimer}
  updateDebugTimer = new DebugTimer("updateDebugTimer")

  ///@private
  ///@type {DebugTimer}
  renderTimer = new DebugTimer("renderTimer")
  
  ///@private
  ///@type {DebugTimer}
  renderGUITimer = new DebugTimer("renderGUITimer")

  ///@private
  ///@type {Boolean}
  renderEnabled = true

  ///@private
  ///@type {Boolean}
  renderGUIEnabled = true

  ///@private
  ///@type {?Promise}
  watchdogPromise = null

  ///@private
  ///@type {Number}
  gcFrameTime = Core.getProperty("core.gc.frame-time", 100)

  ///@private
  ///@type {Array<Struct>}
  services = new Array(Struct, GMArray.map([
    "fsm",
    "loader",
    "displayService",
    "dispatcher",
    "executor",
    "videoService",
    "sfxService",
    "menu",
    "visuRenderer"
  ], function(name, index, controller) {
    Logger.debug(BeanVisuController, $"Load service '{name}'")
    return {
      name: name,
      struct: Assert.isType(Struct.get(controller, name), Struct),
    }
  }, this))

  ///@private
  ///@type {Array<Struct>}
  gameplayServices = new Array(Struct, GMArray.map([
    "shaderPipeline",
    "shaderBackgroundPipeline",
    "shaderCombinedPipeline",
    "particleService",
    "trackService",
    "gridService",
    "subtitleService",
    "coinService",
  ], function(name, index, controller) {
    Logger.debug(BeanVisuController, $"Load gameplay service '{name}'")
    return {
      name: name,
      struct: Assert.isType(Struct.get(controller, name), Struct),
    }
  }, this))

  ///@param {Boolean} value
  ///@return {VisuController}
  setRenderEnabled = function(value) {
    this.renderEnabled = value
    return this
  }

  ///@param {Boolean} value
  ///@return {VisuController}
  setRenderGUIEnabled = function(value) {
    this.renderEnabled = value
    return this
  }

  ///@param {String} name
  ///@return {Boolean}
  shaderTemplateExists = function(name) {
    return this.shaderPipeline.templates.contains(name)
        || Visu.assets().shaderTemplates.contains(name)  
  }

  ///@param {String} name
  ///@return {Boolean}
  particleTemplateExists = function(name) {
    return this.particleService.templates.contains(name) 
        || Visu.assets().particleTemplates.contains(name)  
  }

  ///@param {String} name
  ///@return {Boolean}
  shroomTemplateExists = function(name) {
    return this.shroomService.templates.contains(name) 
        || Visu.assets().shroomTemplates.contains(name)
  }

  ///@param {String} name
  ///@return {Boolean}
  bulletTemplateExists = function(name) {
    return this.bulletService.templates.contains(name) 
        || Visu.assets().bulletTemplates.contains(name)
  }

  ///@param {String} name
  ///@return {Boolean}
  coinTemplateExists = function(name) {
    return this.coinService.templates.contains(name) 
        || Visu.assets().coinTemplates.contains(name)
  }   

  ///@param {String} name
  ///@return {Boolean}
  subtitleTemplateExists = function(name) {
    return this.subtitleService.templates.contains(name) 
        || Visu.assets().subtitleTemplates.contains(name)
  }  
  
  ///@private
  ///@return {VisuController}
  init = function() {
    var width = Visu.settings.getValue("visu.window.width", 1440),
    var height = Visu.settings.getValue("visu.window.height", 900)
    var fullscreen = Visu.settings.getValue("visu.fullscreen", false)
    var borderlessWindow = Visu.settings.getValue("visu.borderless-window", false)
    this.displayService
      .resize(width, height)
      .setBorderlessWindow(borderlessWindow)
      .setFullscreen(fullscreen)
      .setCaption(game_display_name)
      .setCursor(Cursor.DEFAULT)
      .center()
    
    this.sfxService
      .set("player-collect-bomb", new SFX("sound_sfx_player_collect_bomb"))
      .set("player-collect-life", new SFX("sound_sfx_player_collect_life"))
      .set("player-collect-point-or-force", new SFX("sound_sfx_player_collect_point_or_force"))
      .set("player-die", new SFX("sound_sfx_player_die"))
      .set("player-force-level-up", new SFX("sound_sfx_player_force_level_up"))
      .set("player-shoot", new SFX("sound_sfx_player_shoot", 3))
      .set("player-use-bomb", new SFX("sound_sfx_player_use_bomb"))
      .set("shroom-die", new SFX("sound_sfx_shroom_die", 3))
      .set("shroom-damage", new SFX("sound_sfx_shroom_damage", 3))
      .set("shroom-shoot", new SFX("sound_sfx_shroom_shoot", 3))
      .set("menu-move-cursor", new SFX("sound_sfx_menu_move_cursor"), 1)
      .set("menu-select-entry", new SFX("sound_sfx_menu_select_entry"), 1)
      .set("menu-use-entry", new SFX("sound_sfx_menu_use_entry"), 1)
      .set("menu-splashscreen", new SFX("sound_sfx_intro"), 1)
    

    if (Visu.settings.getValue("visu.server.enable", false)) {
      this.server.run()
    }
    
    var httpService = Beans.get(BeanHTTPService)
    if (Core.getProperty("visu.version.check", false)
      && Core.getRuntimeType() != RuntimeType.GXGAMES
      && Optional.is(httpService)) {
      httpService.send(httpService.factoryGetEvent({
        url: Core.getProperty("visu.version.url"),
        onSuccess: function(result) {
          try {
            ///@todo Use JSON.parserTask
            var versionConfig = JSON.parse(result)
            var current = Struct.get(versionConfig.data.current, Core.getRuntimeType())
            Visu._serverVersion = current.version
          } catch (exception) {
            Visu._serverVersion = null
            Logger.error(BeanVisuController, $"serverVersion fatal error: {exception.message}")
            Core.printStackTrace()
          }
        },
      }))
    }
  
    return this
  }

  ///@private
  ///@param {UI}
  resetUITimer = function(ui) {
    ui.surfaceTick.skip()
    ui.finishUpdateTimer()
  }

  ///@private
  ///@return {VisuController}
  updateCursor = function() {
    var cursor = this.displayService.getCursor()
    var size = this.menu.containers.size()
    var editor = Beans.get(Visu.modules().editor.controller)
    if (Optional.is(editor)) {
      if (editor.renderUI && cursor == Cursor.NONE && cursor_sprite == -1) {
        displayService.setCursor(Cursor.DEFAULT)
      } else if (!editor.renderUI && size == 0 && cursor != Cursor.NONE) {
        displayService.setCursor(Cursor.NONE)
      } else if (!editor.renderUI && size > 0 && cursor == Cursor.NONE) {
        displayService.setCursor(Cursor.DEFAULT)
      }

      if (!editor.renderUI && cursor_sprite != -1) {
        cursor_sprite = -1
      }
    } else {
      if (cursor_sprite != -1) {
        cursor_sprite = -1
      }
      
      if (size == 0 && cursor != Cursor.NONE) {
        displayService.setCursor(Cursor.NONE)
      } else if (size > 0 && cursor == Cursor.NONE) {
        displayService.setCursor(Cursor.DEFAULT)
      }
    }

    if (cursor_sprite == -1 && is_debug_overlay_open() && this.displayService.getCursor() == Cursor.NONE) {
      displayService.setCursor(Cursor.DEFAULT)
    }

    if (cursor_sprite != -1 && this.displayService.getCursor() != Cursor.NONE) {
      cursor_sprite = -1
    }

    return this
  }

  ///@private
  ///@return {VisuController}
  updateGCFrameTime = function() {
    if (gc_get_target_frame_time() != this.gcFrameTime) {
      Logger.info(BeanVisuController, $"updateGCFrameTime: {this.gcFrameTime}")
      gc_target_frame_time(this.gcFrameTime)
    }

    return this
  }

  ///@private
  ///@param {Struct} service
  ///@param {Number} iterator
  ///@param {VisuController} controller
  updateService = function(service, iterator, controller) {
    try {
      service.struct.update()
    } catch (exception) {
      controller.exceptionDebugHandler($"'{service.name}::update' fatal error: {exception.message}")
    }
  }

  ///@private
  ///@param {Struct} service
  ///@param {Number} iterator
  ///@param {VisuController} controller
  updateGameplayService = function(service, iterator, controller) {
    try {
      if (service.name == "trackService") {
        service.struct.update()
      } else if (controller.fsm.getStateName() != "rewind") {
        service.struct.update()
      }
    } catch (exception) {
      controller.exceptionDebugHandler($"'{service.name}::update' fatal error: {exception.message}")
    }
  }

  ///@private
  ///@return {VisuController}
  updateUIService = function() {
    try {
      if (this.displayService.state == "resized") { 
        ///@description reset UI timers after resize to avoid ghost effect
        this.uiService.containers.forEach(this.resetUITimer)

        Visu.settings.setValue("visu.fullscreen", this.displayService.getFullscreen()).save()
        if (!this.displayService.getFullscreen()) {
          Visu.settings
            .setValue("visu.window.width", this.displayService.getWidth())
            .setValue("visu.window.height", this.displayService.getHeight())
            .save()
        }
      }
      this.uiService.update()
    } catch (exception) {
      var message = $"'uiService::update' fatal error: {exception.message}"
      Logger.error(BeanVisuController, message)
      Core.printStackTrace()
      this.send(new Event("spawn-popup", { message: message }))
    }

    return this
  }

  ///@private
  ///@return {VisuController}
  updateDebugFPS = function() {
    if (Core.getProperty("visu.enable-debug-fps", false) != true) {
      return this
    }

    if (keyboard_check(ord("B"))) {
      if (irandom(100) > 40) {
        var spd = 15 + irandom(keyboard_check(ord("N")) ? 15 : 45)
        game_set_speed(spd, gamespeed_fps)
        Logger.info(BeanVisuController, $"Set debugFPSSpeed: {spd}, DeltaTime: {DeltaTime.get()}")
        
      }
    } else {
      var spd = game_get_speed(gamespeed_fps)
      if (game_get_speed(gamespeed_fps) < 60) {
        spd = clamp(spd + choose(1, 0, 1, 0, 0, 2, 0, 1, 0, 0, 0, 0, -1, 0, 1, 1, 0, -1, 1), 15, 60)
        game_set_speed(spd, gamespeed_fps)
        Logger.info(BeanVisuController, $"Restore debugFPSSpeed: {spd}, DeltaTime: {DeltaTime.get()}")
      }
    }

    return this
  }

  ///@private
  ///@return {VisuController}
  updateUIServices = function() {
    var state = this.fsm.getStateName()
    if (state != "splashscreen") {
      this.updateUIService()
    }

    return this
  }

  ///@private
  ///@return {VisuController}
  updateServices = function() {
    this.services.forEach(this.updateService, this)

    return this
  }

  ///@private
  ///@return {VisuController}
  updateGameplayServices = function() {
    if (this.isGameplayRunning()) {
      this.gameplayServices.forEach(this.updateGameplayService, this)
    }

    return this
  }

  ///@private
  ///@return {VisuController}
  updateWatchdog = function() {
    try {
      this.difficulty = Visu.settings.getValue("visu.difficulty")
      if (!Core.isEnumKey(this.difficulty, Difficulty)) {
        this.difficulty = Difficulty.NORMAL
        Visu.settings.setValue("visu.difficulty", this.difficulty).save()
      }

      if (this.trackService.isTrackLoaded()) {
        var ost = this.trackService.track.audio
        var ostVolume = Visu.settings.getValue("visu.audio.ost-volume")
        if (ost.isPlaying() && ost.getVolume() != ostVolume) {
          ost.setVolume(ostVolume)
        }

        SHADER_AUDIO_WAVEFORM_VALUE = SHADER_AUDIO_WAVEFORM_DEFAULT_VALUE
        var soundIntent = Beans.get(BeanSoundService).intents.get(ost.name)
        if (soundIntent != null && soundIntent.waveform != null) {
          var step = Struct.getIfType(soundIntent.waveform, "step", Number)
          var data = Struct.getIfType(soundIntent.waveform, "data", GMArray)
          if (step != null && step > 0.0 && data != null) {
            var pointer = floor(ost.getPosition() / step)
            if (pointer < GMArray.size(data)) {
              SHADER_AUDIO_WAVEFORM_VALUE = data[pointer]
            }
          }
        }
      }

      var sfxVolume = Visu.settings.getValue("visu.audio.sfx-volume")
      if (this.sfxService.getVolume() != sfxVolume) {
        this.sfxService.setVolume(sfxVolume)
      }

      if (Optional.is(this.watchdogPromise)) {
        this.watchdogPromise = this.watchdogPromise.status == PromiseStatus.PENDING
          ? this.watchdogPromise
          : null
        return this
      }

      if (!Optional.is(this.watchdogPromise)
        && this.trackService.isTrackLoaded()
        && !this.trackService.track.audio.isLoaded() 
        && 1 > abs(this.trackService.time - this.trackService.duration)
        && this.fsm.getStateName() == "play") {
        
        Logger.info("VisuController", $"Track finished at {this.trackService.time}")
        this.watchdogPromise = this.send(new Event("pause").setPromise(new Promise()))
        this.menu.send(this.menu.factoryOpenMainMenuEvent({ disableResume: true }))
      }

      if (this.fsm.getStateName() != "idle" && Optional.is(this.ostSound)) {
        this.ostSound.stop()
        this.ostSound = null
      }
    } catch (exception) {
      var message = $"'watchdog' fatal error: {exception.message}"
      Logger.error(BeanVisuController, message)
      Core.printStackTrace()
      this.send(new Event("spawn-popup", { message: message }))
    }

    return this
  }

  ///@param {String} message
  exceptionDebugHandler = function(message) {
    Logger.error(BeanVisuController, message)
    Core.printStackTrace()
    this.send(new Event("spawn-popup", { message: message }))

    var stateName = this.trackService.isTrackLoaded() ? "pause" : "idle"
    this.fsm.dispatcher.send(new Event("transition", { name: stateName }))

    var editorIOConstructor = Core.getConstructor(Visu.modules().editor.io)
    if (Optional.is(editorIOConstructor)) {
      if (!Beans.exists(Visu.modules().editor.io)) {
        Beans.add(Beans.factory(Visu.modules().editor.io, GMServiceInstance, layerId,
          new editorIOConstructor()))
      }
    }

    var editorConstructor = Core.getConstructor(Visu.modules().editor.controller)
    if (Optional.is(editorConstructor)) {
      if (!Beans.exists(Visu.modules().editor.controller)) {
        Beans.add(Beans.factory(Visu.modules().editor.controller, GMServiceInstance, layerId,
          new editorConstructor()))
      }
    }
    
    var editor = Beans.get(Visu.modules().editor.controller)
    if (Optional.is(editor)) {
      editor.send(new Event("open"))
      editor.renderUI = true
      editor.store.get("update-services").set(false)
    }
  }

  ///@param {TrackChannel}
  ///@return {Boolean}
  isChannelDifficultyValid = function(channel) {
    var difficulties = Struct.get(Struct.get(channel, "settings"), "difficulty")
    return !Optional.is(difficulties) || Struct.get(difficulties, this.difficulty) != false
  }
  
  ///@return {Boolean}
  isGameplayRunning = function() {
    var state = this.fsm.getStateName()
    var editor = Beans.get(Visu.modules().editor.controller)
    return (this.menu.containers.size() == 0) 
        && (state != "splashscreen")
        && (state != "game-over")
        && (state != "paused" 
        || (Optional.is(editor) && editor.store.getValue("update-services")))
  }

  ///@param {Event}
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {VisuController}
  update = function() {
    this.updateDebugTimer.start()
    this.updateDebugFPS()
    this.updateGCFrameTime()
    this.updateUIServices()
    this.updateServices()
    this.updateCursor()
    this.updateGameplayServices()
    this.updateWatchdog()
    updateDebugTimer.finish()
    return this
  }

  ///@return {VisuController}
  render = function() {
    this.renderTimer.start()
    GPU.set.colorWrite(true, true, true, true)
    if (!this.renderEnabled) {
      this.renderTimer.finish()
      return this
    }

    var deltaTime = DeltaTime.deltaTime
    try {
      DeltaTime.deltaTime = this.isGameplayRunning() ? deltaTime : 0.0
      this.visuRenderer.render()
    } catch (exception) {
      var message = $"'render' fatal error: {exception.message}"
      Logger.error(BeanVisuController, message)
      Core.printStackTrace()
      Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
      GPU.reset.shader()
      GPU.reset.surface()
      GPU.reset.blendMode()
    } finally {
      DeltaTime.deltaTime = deltaTime
    }

    this.renderTimer.finish()
    return this
  }

  ///@return {VisuController}
  renderGUI = function() {
    this.renderGUITimer.start()
    if (!this.renderGUIEnabled) {
      this.renderGUITimer.finish()
      return this
    }

    try {
      this.visuRenderer.renderGUI()
    } catch (exception) {
      var message = $"'renderGUI' fatal error: {exception.message}"
      Logger.error(BeanVisuController, message)
      Core.printStackTrace()
      Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
      GPU.reset.shader()
      GPU.reset.surface()
      GPU.reset.blendMode()
    }

    this.renderGUITimer.finish()
    return this
  }

  ///@return {VisuController}
  onSceneEnter = function() {
    Logger.info(BeanVisuController, "onSceneEnter")
    audio_stop_all()
    VideoUtil.runGC()
    if (Core.getProperty("visu.manifest.load-on-start", false) && !VISU_MANIFEST_LOAD_ON_START_DISPATCHED) {
      var task = new Task("load-manifest")
        .setTimeout(60.0)
        .setState({
          cooldown: new Timer(1.0),
          event: new Event("load", {
            manifest: FileUtil.get(String.concat(
              String.replaceAll(String.replaceAll(working_directory, "\\", "/"), "//", "/"),
              Core.getProperty("visu.manifest.path")
            )),
            autoplay: Core.getProperty("visu.manifest.play-on-start", false),
          }),
        })
        .whenUpdate(function() {
          var controller = Beans.get(BeanVisuController)
          var stateName = controller.fsm.getStateName()
          if (stateName == "splashscreen") {
            return
          }

          if (!this.state.cooldown.update().finished) {
            return
          }

          if (stateName == "idle") {
            controller.send(this.state.event)
          }
          this.fullfill()
        })
      
      this.executor.add(task)
      VISU_MANIFEST_LOAD_ON_START_DISPATCHED = true

    } else if (Core.getProperty("visu.menu.open-on-start", false)) {
      var event = this.menu.factoryOpenMainMenuEvent()
      var task = new Task("load-manifest")
        .setTimeout(60.0)
        .setState({
          cooldown: new Timer(1.0),
          event: event,
        })
        .whenUpdate(function() {
          var controller = Beans.get(BeanVisuController)
          var stateName = controller.fsm.getStateName()
          if (stateName == "splashscreen") {
            return
          }

          if (!this.state.cooldown.update().finished) {
            return
          }

          if (stateName == "idle") {
            controller.menu.send(this.state.event)
          }
          this.fullfill()
        })
      
      this.executor.add(task)
    }
    
    return this
  }

  ///@return {VisuController}
  onSceneLeave = function() {
    Logger.info(BeanVisuController, "onSceneLeave")
    audio_stop_all()
    VideoUtil.runGC()
    return this
  }

  ///@return {VisuController}
  onNetworkEvent = function() {
    Logger.info(BeanVisuController, "onNetworkEvent")
    try {
      var event = JSON.parse(json_encode(async_load))
      Logger.debug(BeanVisuController, $"'onNetworkEvent' incoming event: {event}")
      if (!Optional.is(Struct.getIfType(event, "buffer", GMBuffer))) {
        return this
      }

      var json = JSON.parse(buffer_read(event.buffer, buffer_string))
      Logger.debug(BeanVisuController, $"'onNetworkEvent' parse json: {json}")

      this.send(new Event(json.name, Struct.get(json, "data")))
    } catch (exception) {
      var message = $"'onNetworkEvent' fatal error: {exception.message}"
      Logger.error(BeanVisuController, message)
      Core.printStackTrace()
      this.send(new Event("spawn-popup", { message: message }))
    }

    return this
  }

  onSocialEvent = function(json) {
    var type = Struct.get(json, "type")
    Logger.info(BeanVisuController, $"onSocialEvent | type: {type}")
    if (type == "video_start" && VIDEO_CONTEXT != null) {
      VIDEO_CONTEXT.videoStart = true
    }
  }

  ///@return {VisuController}
  free = function() {
    Struct.toMap(this)
      .filter(function(value) {
        if (!Core.isType(value, Struct)
          || !Struct.contains(value, "free")
          || !Core.isType(Struct.get(value, "free"), Callable)) {
          return false
        }
        return true
      })
      .forEach(function(struct, key, context) {
        try {
          Logger.debug(BeanVisuController, $"'free' (key: '{key}') resolved")
          Callable.run(Struct.get(struct, "free"))
        } catch (exception) {
          Logger.error(BeanVisuController, $"'free' (key: '{key}') fatal error: {exception.message}")
          Core.printStackTrace()
        }
      }, this)
    
    return this
  }

  this.init()
}

/* 
Example game save
```
FileUtil.listDirectory($"{game_save_id}save", "*.visu-save.json").forEach(function(path, index) {
  Core.print(index, "|", path)
})

if (!FileUtil.directoryExists($"{game_save_id}save")) {
  Core.print("create directory:", $"{game_save_id}save")
  FileUtil.createDirectory($"{game_save_id}save")

  FileUtil.writeFileSync(new File({ 
    path: $"{game_save_id}save/1.visu-save.json",
    data: JSON.stringify({
      version:"1",
      model:"io.alkapivo.visu.VisuSave",
      data: {
        name: "player 1",
      },
    }, { pretty: true })
  }))
  
  FileUtil.writeFileSync(new File({ 
    path: $"{game_save_id}save/2.visu-save.json",
    data: JSON.stringify({
      version:"1",
      model:"io.alkapivo.visu.VisuSave",
      data: {
        name: "player 2",
      },
    }, { pretty: true })
  }))
}
FileUtil.listDirectory($"{game_save_id}save", "*.visu-save.json").forEach(function(path, index) {
  Core.print(index, ":", path)
})
```
*/