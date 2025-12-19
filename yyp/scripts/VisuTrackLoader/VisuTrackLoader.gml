///@package io.alkapivo.visu

///@param {VisuController} _controller
function VisuTrackLoader(_controller): Service() constructor {

  ///@type {VisuController}
  controller = Assert.isType(_controller, VisuController)
  
  ///@todo extract to generic 
  ///@type {Struct}
  utils = {
    addTask: function(task, executor) {
      executor.add(task)
      return Assert.isType(task.promise, Promise)
    },
    filterPromise: function(promise, name) {
      if (!promise.isReady()) {
        return false
      }

      if (promise.status != PromiseStatus.FULLFILLED) { 
        throw new Exception($"Found rejected promise: {name}")
      }
      return true
    },
    mapPromiseToTask: function(promise, iterator, acc) {
      return Assert.isType(promise.response, Task,
        $"{iterator} promise.response must be type of Task")
    },
  }

  ///@type {FSM}
  fsm = new FSM(this, {
    initialState: { name: "idle" },
    displayName: "VisuTrackLoader",
    states: {
      "idle": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            var editor = Beans.get(Visu.modules().editor.controller)
            if (Optional.is(editor)) {
              editor.send(new Event("open"))
            }
            
            if (Core.isType(data, String)) {
              Logger.info("VisuTrackLoader", $"FSM::onStart(idle): '{data}'")
            }
          },
        },
        transitions: { 
          "idle": null,
          "clear-state": null,
        },
      },
      "clear-state": {
        actions: {
          onStart: function(fsm, fsmState, path) {
            Beans.get(BeanVisuController).visuRenderer.gridRenderer.pathTrack = null
            fsmState.state.set("path", path)
            fsmState.state.set("clearQueue", new Queue(Callable, [
              function() { Beans.get(BeanVisuController).displayService.setCaption(game_display_name) },
              function() { Beans.get(BeanVisuController).brushService.clearTemplates() },
              function() { Beans.get(BeanVisuController).visuRenderer.executor.tasks.forEach(TaskUtil.fullfill).clear() },
              function() { Beans.get(BeanVisuController).visuRenderer.gridRenderer.clear() },
              function() { Beans.get(BeanVisuController).trackService.dispatcher.execute(new Event("close-track")) },
              function() { Beans.get(BeanVisuController).videoService.dispatcher.execute(new Event("close-video")) },              
              function() { Beans.get(BeanVisuController).gridService.executor.tasks.forEach(TaskUtil.fullfill).clear() },
              function() { Beans.get(BeanVisuController).gridService.dispatcher.execute(new Event("clear-grid")) },
              function() { Beans.get(BeanVisuController).gridService.loadingScreen() },
              function() { Beans.get(BeanVisuController).playerService.dispatcher.execute(new Event("clear-player")) },
              function() { Beans.get(BeanVisuController).shroomService.dispatcher.execute(new Event("clear-shrooms")).execute(new Event("reset-templates")) },
              function() { Beans.get(BeanVisuController).bulletService.dispatcher.execute(new Event("clear-bullets")).execute(new Event("reset-templates")) },
              function() { Beans.get(BeanVisuController).coinService.dispatcher.execute(new Event("clear-coins")).execute(new Event("reset-templates")) },
              function() { Beans.get(BeanVisuController).subtitleService.dispatcher.execute(new Event("clear-subtitle")).execute(new Event("reset-templates")) },
              function() { Beans.get(BeanVisuController).particleService.dispatcher.execute(new Event("clear-particles")).execute(new Event("reset-templates")) },
              function() { Beans.get(BeanVisuController).shaderPipeline.dispatcher.execute(new Event("clear-shaders")).execute(new Event("reset-templates")) },
              function() { Beans.get(BeanVisuController).shaderBackgroundPipeline.dispatcher.execute(new Event("clear-shaders")).execute(new Event("reset-templates")) },
              function() { Beans.get(BeanVisuController).shaderCombinedPipeline.dispatcher.execute(new Event("clear-shaders")).execute(new Event("reset-templates")) },
              function() { Beans.get(BeanTextureService).dispatcher.execute(new Event("free")) },
              function() {
                var editor = Beans.get(Visu.modules().editor.controller)
                if (Optional.is(editor)) {
                  editor.popupQueue.dispatcher.execute(new Event("clear"))
                  editor.dispatcher.execute(new Event("close"))
                }
              },
            ]))
          }
        },
        update: function(fsm) {
          try {
            var clearQueue = this.state.get("clearQueue")
            if (clearQueue.size() == 0.0) {
              fsm.dispatcher.send(new Event("transition", {
                name: "parse-manifest",
                data: this.state.get("path"),
              }))  
            } else {
              clearQueue.forEach(Callable.run)
            }
          } catch (exception) {
            var message = $"'clear-state' fatal error: {exception.message}"
            Logger.error("VisuTrackLoader", message)
            Core.printStackTrace().printException(exception)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
          }
        },
        transitions: {
          "idle": null,
          "parse-manifest": null,
        },
      },
      "parse-manifest": {
        actions: {
          onStart: function(fsm, fsmState, path) {
            var controller = Beans.get(BeanVisuController)
            var editor = Beans.get(Visu.modules().editor.controller)
            fsmState.state.set("promise", Beans.get(BeanFileService).send(
              new Event("open-file")
                .setData({ path: path })
                .setPromise(new Promise()
                  .whenSuccess(function(result) {
                    var callback = this.setResponse
                    JSON.parserTask(result.data, { 
                      callback: function(prototype, json, key, acc) {
                        acc.callback(new prototype(acc.path, json))
                      }, 
                      acc: {
                        callback: callback,
                        path: result.path,
                      },
                    }).update()
                    
                    var editor = Beans.get(Visu.modules().editor.controller)
                    if (Optional.is(editor)) {
                      var item = editor.store.get("bpm")
                      item.set(this.response.bpm)
  
                      item = editor.store.get("bpm-count")
                      item.set(this.response.bpmCount)

                      item = editor.store.get("bpm-sub")
                      item.set(this.response.bpmSub)
                    }
                    
                    return {
                      path: Assert.isType(FileUtil.getDirectoryFromPath(result.path), String),
                      manifest: Assert.isType(this.response, VisuTrack),
                    }
                  })
                )
            ))
          },
        },
        update: function(fsm) {
          try {
            var promise = this.state.get("promise")
            if (!promise.isReady()) {
              return
            }
            
            fsm.dispatcher.send(new Event("transition", {
              name: "create-parser-tasks",
              data: {
                path: Assert.isType(promise.response.path, String),
                manifest: Assert.isType(promise.response.manifest, VisuTrack),
              },
            }))
          } catch (exception) {
            var message = $"'parse-manifest' fatal error: {exception.message}"
            Logger.error("VisuTrackLoader", message)
            Core.printStackTrace().printException(exception)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
          }
        },
        transitions: { 
          "idle": null, 
          "create-parser-tasks": null,
        },
      },
      "create-parser-tasks": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            var controller = fsm.context.controller
            controller.track = data.manifest

            var promises = new Map(String, Promise)
            var callback = function(promises, name, data) {
              promises.set(name, Beans.get(BeanFileService).send(data))
            }

            var events = new Stack(Struct, [
              {
                name: "texture",
                callback: callback,
                data: new Event("open-file")
                  .setData({ path: $"{data.path}{data.manifest.texture}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, iterator, acc) {
                        Logger.debug("VisuTrackLoader", $"Load texture '{json.name}'")
                        acc.promises.forEach(function(promise, key) {
                          if (promise.status == PromiseStatus.REJECTED) {
                            throw new Exception($"Found rejected load-texture promise for key '{key}'")
                          }
                        })

                        var textureIntent = Assert.isType(new prototype(json), TextureIntent)
                        textureIntent.file = FileUtil.get($"{acc.path}{textureIntent.file}")
                        var promise = new Promise()
                        acc.service.send(new Event("load-texture")
                          .setData(textureIntent)
                          .setPromise(promise))
                        acc.promises.add(promise, textureIntent.name)
                      },
                      acc: {
                        service: Beans.get(BeanTextureService),
                        promises: new Map(String, Promise),
                        path: controller.track.path,
                      },
                      steps: 2,
                      model: "Collection<io.alkapivo.core.service.texture.TextureIntent>",
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    })),
              },
              {
                name: "sound",
                callback: callback,
                data: new Event("open-file")
                  .setData({ path: $"{data.path}{data.manifest.sound}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        Logger.debug("VisuTrackLoader", $"Load sound intent '{key}'")
                        var soundService = acc.soundService
                        var soundIntent = new prototype(json)
                        var visuWASM = Callable.run("VisuWASM")
                        if (Core.getRuntimeType() == RuntimeType.GXGAMES && Core.isType(visuWASM, Struct)) {
                          Assert.isTrue(audio_group_is_loaded(visuWASM.getAudioGroup()), "audiogroup must be loaded")

                          var sound = Struct.get(visuWASM.getSounds(), soundIntent.file)
                          Assert.isType(sound, GMSound, $"Couldn't find sound for wasm target, {soundIntent.file}")
                          soundService.sounds.add(sound, key)
                          return
                        }

                        var path = FileUtil.get($"{acc.path}{soundIntent.file}")
                        Assert.fileExists(path)
                        Assert.isFalse(soundService.sounds.contains(key), "GMSound already loaded")

                        soundService.loadOGG(key, path, soundIntent)
                      },
                      acc: {
                        soundService: Beans.get(BeanSoundService),
                        path: controller.track.path,
                      },
                      steps: 1,
                      model: "Collection<io.alkapivo.core.service.sound.SoundIntent>",
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    })),
              },
              {
                name: "shader",
                callback: callback,
                data: new Event("open-file")
                  .setData({ path: $"{data.path}{data.manifest.shader}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        Logger.debug("VisuTrackLoader", $"Load shader template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.shaderPipeline.templates,
                      steps: MAGIC_NUMBER_TASK,
                      model: "Collection<io.alkapivo.core.service.shader.ShaderTemplate>",
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    })),
              },
              {
                name: "track",
                callback: callback,
                data: new Event("open-file")
                  .setData({ path: $"{data.path}{data.manifest.track}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        var name = Struct.get(json, "name")
                        Logger.debug("VisuTrackLoader", $"Load track '{name}'")
                        acc.trackService.openTrack(new prototype(json, { 
                          handlers: acc.trackService.handlers,
                          parseAsync: Core.getProperty("visu.manifest.parse-track-async", true),
                          parseTrackEventStep: Core.getProperty("visu.manifest.parse-track-event-step", 32),
                          parseSettings: function(json) {
                            var difficulty = Struct.get(json, "difficulty")
                            return {
                              "difficulty": {
                                "EASY": Struct.getDefault(difficulty, "EASY", true),
                                "NORMAL": Struct.getDefault(difficulty, "NORMAL", true),
                                "HARD": Struct.getDefault(difficulty, "HARD", true),
                                "LUNATIC": Struct.getDefault(difficulty, "LUNATIC", true),
                              }
                            }
                          },
                          parseEvent: (PRELOAD_TRACK_EVENT
                            ? function(event, index, config = null) {
                              var trackEvent = new TrackEvent(event, config)
                              trackEvent.parsedData = trackEvent.parseData(trackEvent.data)
                              return trackEvent
                            }
                            : function(event, index, config = null) {
                              return new TrackEvent(event, config)
                            }
                          ),
                          executeEventCallable: (PRELOAD_TRACK_EVENT
                            ? function(event, trackChannel) {
                              event.callable(event.parsedData, trackChannel)
                            }
                            : function(event, trackChannel) {
                              event.callable(event.parseData(event.data), trackChannel)
                            }
                          ),
                        }))
                      },
                      acc: { trackService: controller.trackService },
                      model: "io.alkapivo.core.service.track.Track",
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    })),
              },
              {
                name: "bullet",
                callback: callback,
                data: new Event("open-file")
                  .setData({ path: $"{data.path}{data.manifest.bullet}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        Logger.debug("VisuTrackLoader", $"Load bullet template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.bulletService.templates,
                      steps: MAGIC_NUMBER_TASK,
                      model: "Collection<io.alkapivo.visu.service.bullet.BulletTemplate>",
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    })),
              },
              {
                name: "coin",
                callback: callback,
                data: new Event("open-file")
                  .setData({ path: $"{data.path}{data.manifest.coin}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        Logger.debug("VisuTrackLoader", $"Load coin template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.coinService.templates,
                      steps: MAGIC_NUMBER_TASK,
                      model: "Collection<io.alkapivo.visu.service.coin.CoinTemplate>",
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    }))
              },
              {
                name: "subtitle",
                callback: callback,
                data: new Event("open-file")
                  .setData({ path: $"{data.path}{data.manifest.subtitle}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        Logger.debug("VisuTrackLoader", $"Load subtitle template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.subtitleService.templates,
                      steps: MAGIC_NUMBER_TASK,
                      model: "Collection<io.alkapivo.visu.service.subtitle.SubtitleTemplate>",
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    })),
              },
              {
                name: "shroom",
                callback: callback,
                data: new Event("open-file")
                  .setData({ path: $"{data.path}{data.manifest.shroom}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        Logger.debug("VisuTrackLoader", $"Load shroom template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.shroomService.templates,
                      steps: MAGIC_NUMBER_TASK,
                      model: "Collection<io.alkapivo.visu.service.shroom.ShroomTemplate>",
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    })),
              },
              {
                name: "particle",
                callback: callback,
                data: new Event("open-file")
                  .setData({ path: $"{data.path}{data.manifest.particle}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        Logger.debug("VisuTrackLoader", $"Load particle template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.particleService.templates,
                      steps: MAGIC_NUMBER_TASK,
                      model: "Collection<io.alkapivo.core.service.particle.ParticleTemplate>",
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    })),
              }
            ])

            fsmState.state.set("promises", promises)
            fsmState.state.set("events", events)
            fsmState.state.set("events-cooldown", new Timer(Core.getProperty("visu.manifest.file-cooldown", 0.128)))
            
            if (Core.isType(Struct.get(data.manifest, "video"), String)) {
              fsmState.state.set("video", new Event("open-video", {
                video: {
                  name: $"{data.manifest.video}",
                  path: $"{data.path}{data.manifest.video}",
                  timestamp: 0.0,
                  volume: 0.0,
                  loop: true,
                }
              }))
            }

            if (Core.getRuntimeType() == RuntimeType.GXGAMES
                && Core.isType(Callable.run("VisuWASM"), Struct)) {
              var audioGroupTask = new Task("load-audio-group")
                .setPromise(new Promise())
                .setTimeout(10.0)
                .setState({
                  isLoading: false
                })
                .whenUpdate(function() {
                  var visuWASM = Callable.run("VisuWASM")
                  var soundService = Beans.get(BeanSoundService)
                  if (!Core.isType(visuWASM, Struct) || !Optional.is(soundService)) {
                    this.reject()
                    return
                  }

                  var audioGroup = visuWASM.getAudioGroup()
                  if (!this.state.isLoading) {
                    this.state.isLoading = soundService.loadAudioGroup(audioGroup)
                  } else if (audio_group_is_loaded(audioGroup)) {
                    this.fullfill()
                  }
                })
              controller.executor.add(audioGroupTask)
              fsmState.state.set("audio-group", audioGroupTask.promise)
            }
            
            if (Core.getProperty("visu.manifest.load-brushes")) {
              data.manifest.editor.forEach(function(file, index, acc) { 
                acc.events.push({
                  name: file,
                  callback: acc.callback,
                  data: new Event("open-file")
                    .setData({ path: $"{acc.data.path}{file}" })
                    .setPromise(new Promise()
                      .setState({ 
                        callback: function(prototype, json, index, acc) {
                          Logger.debug("VisuTrackLoader", $"Load brush '{json.name}'")
                          acc.saveTemplate(new prototype(json))
                        },
                        acc: {
                          saveTemplate: Beans.get(BeanVisuController).brushService.saveTemplate,
                          file: file,
                        },
                        steps: MAGIC_NUMBER_TASK,
                        model: "Collection<io.alkapivo.visu.editor.api.VEBrushTemplate>",
                      })
                      .whenSuccess(function(result) {
                        return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                      })),
                })
              }, {
                data: data,
                callback: callback,
                events: events,
              })
            }
          },
        },
        update: function(fsm) {
          try {
            var promises = this.state.get("promises")
            var events = this.state.get("events")
            if (events.size() > 0) {
              var cooldown = this.state.get("events-cooldown")
              if (!cooldown.update().finished) {
                return
              }

              cooldown.reset()
              var event = events.pop()
              event.callback(promises, event.name, event.data)
              return
            }
            
            var filtered = promises.filter(fsm.context.utils.filterPromise)
            if (filtered.size() != promises.size()) {
              return
            }

            if (Core.getRuntimeType() == RuntimeType.GXGAMES
                && Core.isType(Callable.run("VisuWASM"), Struct)) {
              var audioGroupPromise = this.state.get("audio-group")
              if (audioGroupPromise.status == PromiseStatus.PENDING) {
                return
              }

              Assert.isTrue(audioGroupPromise.status == PromiseStatus.FULLFILLED,
                "audioGroupPromise value must be equal to PromiseStatus.FULLFILLED")
            }

            fsm.dispatcher.send(new Event("transition", {
              name: "parse-primary-assets",
              data: {
                video: this.state.get("video"),
                tasks: filtered.map(fsm.context.utils.mapPromiseToTask, null, String, Task),
              }
            }))
          } catch (exception) {
            var message = $"'create-parser-tasks' fatal error: {exception.message}"
            Logger.error("VisuTrackLoader", message)
            Core.printStackTrace().printException(exception)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
          }
        },
        transitions: {
          "idle": null, 
          "parse-primary-assets": null,
        },
      },
      "parse-primary-assets": {
        actions: {
          onStart: function(fsm, fsmState, acc) { 
            var addTask = fsm.context.utils.addTask
            var executor = fsm.context.executor
            var video = acc.video
            var tasks = acc.tasks
            fsmState.state
              .set("video", video)
              .set("tasks", tasks)
              .set("parsePrimaryCooldown", new Timer(Core.getProperty("visu.manifest.parse-cooldown", 0.0)))
              .set("promises", new Map(String, Promise, {
                "texture": addTask(tasks.get("texture"), executor),
                "sound": addTask(tasks.get("sound"), executor),
                "shader": addTask(tasks.get("shader"), executor),
              }))
          },
        },
        update: function(fsm) {
          try {
            var promises = this.state.get("promises")
            var filtered = promises.filter(fsm.context.utils.filterPromise)
            if (filtered.size() != promises.size()) {
              return
            }

            var texturePromises = this.state.get("tasks").get("texture").state.get("acc").promises
            var filteredTextures = texturePromises.filter(fsm.context.utils.filterPromise)
            if (filteredTextures.size() != texturePromises.size()) {
              return
            }

            if (!this.state.get("parsePrimaryCooldown").update().finished) {
              return
            }

            fsm.dispatcher.send(new Event("transition", {
              name: "parse-video",
              data: {
                video: this.state.get("video"),
                tasks: Assert.isType(this.state.get("tasks"), Map),
              }
            }))
          } catch (exception) {
            var message = $"'parse-primary-assets' fatal error: {exception.message}"
            Logger.error("VisuTrackLoader", message)
            Core.printStackTrace().printException(exception)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
          }
        },
        transitions: {
          "idle": null,
          "parse-video": null,
          "parse-secondary-assets": null,
        },
      },
      "parse-video": {
        actions: {
          onStart: function(fsm, fsmState, acc) { 
            var addTask = fsm.context.utils.addTask
            var executor = fsm.context.executor
            var promises = new Map(String, Promise)

            fsmState.state.set("tasks", acc.tasks).set("promises", promises)

            if (Core.isType(acc.video, Event)) {
              fsmState.state
                .get("promises")
                .set("video", Beans.get(BeanVisuController).videoService.send(acc.video))
            }
          },
        },
        update: function(fsm) {
          try {
            var promises = this.state.get("promises")
            var filtered = promises.filter(fsm.context.utils.filterPromise)
            if (filtered.size() != promises.size()) {
              return
            }

            fsm.dispatcher.send(new Event("transition", { 
              name: "parse-secondary-assets",
              data: Assert.isType(this.state.get("tasks"), Map)
            }))
          } catch (exception) {
            var message = $"'parse-video' fatal error: {exception.message}"
            Logger.error("VisuTrackLoader", message)
            Core.printStackTrace().printException(exception)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
          }
        },
        transitions: {
          "idle": null, 
          "parse-secondary-assets": null,
        },
      },
      "parse-secondary-assets": {
        actions: {
          onStart: function(fsm, fsmState, tasks) { 
            var addTask = fsm.context.utils.addTask
            var executor = fsm.context.executor
            var promises = new Map(String, Promise, {
              "bullet": addTask(tasks.get("bullet"), executor),
              "coin": addTask(tasks.get("coin"), executor),
              "subtitle": addTask(tasks.get("subtitle"), executor),
              "particle": addTask(tasks.get("particle"), executor),
              "shroom": addTask(tasks.get("shroom"), executor),
              "track": addTask(tasks.get("track"), executor),
            })

            tasks.forEach(function(task, key, acc) { 
              if (String.contains(key, ".json")) {
                acc.promises.add(acc.addTask(task, acc.executor), key)
              }
            }, { addTask: addTask, executor: executor, promises: promises })
            
            fsmState.state.set("tasks", tasks).set("promises", promises)
          },
        },
        update: function(fsm) {
          try {
            var promises = this.state.get("promises")
            var filtered = promises.filter(fsm.context.utils.filterPromise)
            if (filtered.size() != promises.size()) {
              return
            }

            if (fsm.context.controller.trackService.track == null) {
              Assert.isTrue(fsm.context.controller.trackService.executor.tasks.size() > 0,
                "parse-secondary-assets TrackService.executor.tasks.size() must be > 0")
              return
            }

            var audio = Assert.isType(fsm.context.controller.trackService.track.audio, Sound)
            var attempts = this.state.inject("attempts", GAME_FPS * 5) - DELTA_TIME
            //var attempts = this.state.inject("attempts", GAME_FPS * 5) - DeltaTime.apply(1)
            Assert.isTrue(attempts >= 0.0, "parse-secondary-assets attempts must be >= 0.0")
            this.state.set("attempts", attempts)
            audio.rewind(0.0)
            if (audio.getPosition() != 0.0) {
              return
            }

            audio.pause()
            fsm.dispatcher.send(new Event("transition", { name: "cooldown" }))
          } catch (exception) {
            var message = $"'parse-secondary-assets' fatal error: {exception.message}"
            Logger.error("VisuTrackLoader", message)
            Core.printStackTrace().printException(exception)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
          }
        },
        transitions: {
          "idle": null, 
          "cooldown": null,
        },
      },
      "cooldown": {
        actions: {
          onStart: function(fsm, fsmState) {
            var stack = new Stack(TextureTemplate)
            Beans.get(BeanTextureService).templates.forEach(function(template, name, stack) {
              stack.push(template)
            }, stack)

            Visu.assets().textures.forEach(function(template, name, stack) {
              stack.push(template)
            }, stack)

            var particles = new Stack(ParticleTemplate)
            Beans.get(BeanVisuController).particleService.templates.forEach(function(template, name, stack) {
              stack.push(template)
            }, particles)

            Visu.assets().particleTemplates.forEach(function(template, name, stack) {
              stack.push(template)
            }, particles)

            var textureLoadTask = new Task("texture-load-task")
              .setState({
                stack: stack,
                particles: particles,
                setup: false,
                render: function(task) {
                  if (!task.state.setup) {
                    if (Beans.get(BeanVisuController).visuRenderer.spinnerFactor < 1.0) {
                      task.state.setup = true
                    }

                    return
                  }

                  if (task.state.particles.size() > 0) {
                    try {
                      repeat (4) {
                        if (task.state.particles.size() == 0) {
                          break
                        } else {
                          var particle = task.state.particles.pop()
                          var particleService = Beans.get(BeanVisuController).particleService
                          var area = new Rectangle(0.0, 0.0, 10.0, 10.0)
                          particleService.spawnParticleEmitter(
                            "main",
                            particle.name,
                            (area.getX() + 0.5) * GRID_SERVICE_PIXEL_WIDTH,
                            (area.getY() + 0.5) * GRID_SERVICE_PIXEL_HEIGHT,
                            (area.getX() + area.getWidth() + 0.5) * GRID_SERVICE_PIXEL_WIDTH,
                            (area.getY() + area.getHeight() + 0.5) * GRID_SERVICE_PIXEL_HEIGHT,
                            FRAME_MS,
                            1.0,
                            FRAME_MS,
                            ParticleEmitterShape.RECTANGLE,
                            ParticleEmitterDistribution.LINEAR
                          )

                          particleService.dispatcher.execute(new Event("clear-particles"))
                        }
                      }
                    } catch (exception) {
                      Logger.error("VisuRenderer", $"particle-load-task exception: {exception.message}")
                      Core.printStackTrace().printException(exception)
                      task.reject()
                      return
                    }
                  } else {
                    try {
                      repeat (4) {
                        if (task.state.stack.size() == 0) {
                          task.fullfill()
                          break
                        } else {
                          var template = task.state.stack.pop()
                          for (var index = 0; index < template.frames; index++) {
                            Logger.debug("VisuRenderer", $"Render texture '{template.name}'")
                            draw_sprite_ext(
                              template.asset, 
                              index, 
                              random(GuiWidth()), 
                              random(GuiHeight()),
                              1.0 + random(10.0),
                              1.0 + random(10.0),
                              random(360.0),
                              make_color_rgb(irandom(255), irandom(255), irandom(255)),
                              1.0 / 255.0
                            )
                          }
                        }
                      }
                    } catch (exception) {
                      Logger.error("VisuRenderer", $"texture-load-task exception: {exception.message}")
                      Core.printStackTrace().printException(exception)
                      task.reject()
                      return
                    }
                  }
                },
              })
              .setPromise(new Promise())

            fsmState.state.set("texture-load-task", textureLoadTask)
            fsmState.state.set("cooldown-timer", new Timer(Core.getProperty("visu.manifest.loaded-cooldown", 0.128)))

            var controller = Beans.get(BeanVisuController)
            controller.visuRenderer.executor.add(textureLoadTask)
            controller.executor.tasks.forEach(function(task) {
              if (task.name != "fade-color" && task.name != "fade-sprite") {
                return
              }
      
              if (task.state.get("stage") == "fade-out") {
                task.fullfill()
                return
              }
              
              task.state.set("stage", "fade-out")
            })

            var gridService = controller.gridService
            var properties = gridService.properties
            gridService.send(new Event("transform-property", {
              key: "channelsPrimaryAlpha",
              container: properties,
              executor: gridService.executor,
              transformer: new NumberTransformer({
                value: properties.channelsPrimaryAlpha,
                target: 0.0,
                duration: 2.0,
                ease: EaseType.LINEAR,
              })
            }))
            
            gridService.send(new Event("transform-property", {
              key: "channelsSecondaryAlpha",
              container: properties,
              executor: gridService.executor,
              transformer: new NumberTransformer({
                value: properties.channelsSecondaryAlpha,
                target: 0.0,
                duration: 2.0,
                ease: EaseType.LINEAR,
              })
            }))
            
            gridService.send(new Event("transform-property", {
              key: "separatorsPrimaryAlpha",
              container: properties,
              executor: gridService.executor,
              transformer: new NumberTransformer({
                value: properties.separatorsPrimaryAlpha,
                target: 0.0,
                duration: 2.0,
                ease: EaseType.LINEAR,
              })
            }))
            
            gridService.send(new Event("transform-property", {
              key: "separatorsSecondaryAlpha",
              container: properties,
              executor: gridService.executor,
              transformer: new NumberTransformer({
                value: properties.separatorsSecondaryAlpha,
                target: 0.0,
                duration: 2.0,
                ease: EaseType.LINEAR,
              })
            }))
          },
        },
        update: function(fsm) {
          try {
            var textureLoadTask = this.state.get("texture-load-task")
            if (textureLoadTask.promise.status == PromiseStatus.PENDING) {
              return
            }
            Assert.isTrue(textureLoadTask.promise.status != PromiseStatus.REJECTED,
              "textureLoadTask.promise.status must be fullfilled")
            
            var timer = this.state.get("cooldown-timer")
            var editorIO = Beans.get(Visu.modules().editor.io)
            if (timer.update().finished) {
              fsm.dispatcher.send(new Event("transition", { name: "loaded" }))
            } else if (editorIO != null && editorIO.keyboard.keys.renderUI.pressed) {
              fsm.dispatcher.send(new Event("transition", { name: "loaded" }))

              var controller = Beans.get(BeanVisuController)
              var editor = Beans.get(Visu.modules().editor.controller)
              if (Optional.is(editor)) {
                editor.renderUI = !editor.renderUI
                var fsmState = controller.fsm.currentState
                if (editor.renderUI && Optional.is(fsmState) && fsmState.name == "load") {
                  fsmState.state.set("autoplay", false)
                }
              }
            }
          } catch (exception) {
            var message = $"'cooldown' fatal error: {exception.message}"
            Logger.error("VisuTrackLoader", message)
            Core.printStackTrace().printException(exception)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
          }
        },
        transitions: {
          "idle": null,
          "loaded": null,
        },
      },
      "loaded": {
        actions: {
          onStart: function(fsm, fsmState, tasks) { 
            var controller = Beans.get(BeanVisuController)
            controller.displayService.setCaption($"{game_display_name} | {fsm.context.controller.trackService.track.name} | {fsm.context.controller.track.path}")
            controller.gridService.avgTime.reset()

            var editor = Beans.get(Visu.modules().editor.controller)
            if (Optional.is(editor)) {
              editor.send(new Event("open"))
            }

            //var pathTrack = new PathTrack()
            //pathTrack.build(controller.trackService.duration)
            //controller.visuRenderer.gridRenderer.pathTrack = pathTrack

            var message = $"Project '{Beans.get(BeanVisuController).trackService.track.name}' loaded successfully"
            controller.send(new Event("spawn-popup", { message: message }))
          }
        },
        transitions: {
          "idle": null,
          "clear-state": null,
        },
      }
    }
  })

  ///@private
  ///@type {TaskExecutor}
  executor = new TaskExecutor(this, {
    loggerPrefix: "VisuTrackLoader",
    enableLogger: true,
    catchException: false
  })

  ///@return {VisuTrackLoader}
  updateFSM = function() {
    try {
      this.fsm.update()
    } catch (exception) {
      var message = $"FSM fatal error: {exception.message}"
      Logger.error("VisuTrackLoader", message)
      Core.printStackTrace().printException(exception)
      Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
    }

    return this
  }

  updateExecutor = function() {    
    try {
      this.executor.update()
    } catch (exception) {
      var message = $"executor fatal error: {exception.message}"
      Logger.error("VisuTrackLoader", message)
      Core.printStackTrace().printException(exception)
      this.executor.tasks.clear()
      this.fsm.dispatcher.send(new Event("transition", { name: "idle" }))
      Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
    }

    return this
  }

  ///@return {FSM}
  update = function() {
    var deltaTime = DELTA_TIME
    DELTA_TIME = 1.0
    this.updateFSM()
    this.updateExecutor()
    DELTA_TIME = deltaTime
    return this
  }
}