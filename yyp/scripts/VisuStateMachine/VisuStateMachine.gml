///@package io.alkapivo.visu

///@param {VisuController} context
///@param {String} name
///@return {FSM}
function VisuStateMachine(context, name) {
  static parseSceneIntent = function() {
    return {
      initialState: Struct.getIfType(
        Struct.get(Scene.getIntent(), BeanVisuController),
        "initialState", Struct, {
          name: Core.getProperty("visu.skip-splashscreen") ? "idle" : "splashscreen",
        }),
    }
  }

  return new FSM(context, {
    displayName: name,
    initialState: parseSceneIntent().initialState,
    states: {
      "splashscreen": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            var controller = Beans.get(BeanVisuController)
            if (Optional.is(controller.ostSound)) {
              controller.ostSound.stop()
              controller.ostSound = null
            }
            
            var task = TaskUtil.factory.splashscreen({
              fadeIn: 1.75,
              duration: 6.0,
              fadeOut: 0.75,
              showSkipTimer: 0.5,
              skipTimer: 0.5,
              initTimer: new Timer(1.5),
              bkgFactor: (FRAME_MS / 64.0) * -30.0,
              fadeInEmitt: false,
              fadeOutEmitt: false,
              sfxPlayed: false,
              logo: Assert.isType(SpriteUtil.parse({ name: "texture_barons_keep" }), Sprite, 
                "logo must be type of Sprite"),
              label: new UILabel({
                text: "Press any key to skip",
                color: "#ffffff",
                font: "font_inter_24_bold",
                align: { v: VAlign.CENTER, h: HAlign.CENTER },
                useScale: true,
                alpha: 0.0,
              }),
              bkg: Assert.isType(SpriteUtil.parse({ name: "texture_bkg_spaace_2" }), Sprite, 
                "bkg must be type of Sprite"),
              render: function(task, layout) {
                var controller = Beans.get(BeanVisuController)
                var displayService = controller.displayService
                var width = layout.width()
                var height = layout.height()
                task.state.bkgFactor += DELTA_TIME * (FRAME_MS / 48.0)
                //task.state.bkgFactor += DeltaTime.apply(FRAME_MS / 48.0)
                task.state.bkg
                  .scaleToFill(GuiWidth() + 400, GuiHeight() + 400)
                  .setScaleX(task.state.bkg.getScaleX() + task.state.bkgFactor)
                  .setScaleY(task.state.bkg.getScaleY() + task.state.bkgFactor)
                  //.setBlend(ColorUtil.parse("#ff00f7ff").toGMColor())
                  .setAlpha(clamp(5.0 * task.state.bkgFactor * (1.0 - task.state.fadeOut.getProgress()), 0.0, 1.0))
                  .setAngle(45.0 * task.state.bkgFactor)
                  .render(
                    ((GuiWidth() - (task.state.bkg.getWidth() * task.state.bkg.getScaleX())) / 2.0) - 200,
                    ((GuiHeight() - (task.state.bkg.getHeight() * task.state.bkg.getScaleY())) / 2.0) - 200
                  )

                if (!task.state.initTimer.update().finished) {
                  return
                }

                if (!task.state.sfxPlayed && task.state.fadeIn.finished) {
                  task.state.sfxPlayed = true
                  //controller.sfxService.play("menu-splashscreen")
                  try {
                    var sound = Assert.isType(SoundUtil.fetch("sound_sfx_intro", { loop: false }), Sound, "sound_sfx_intro must be sound")
                    var ostVolume = Visu.settings.getValue("visu.audio.ost-volume")
                    sound.play(0.0).setVolume(ostVolume, 1.0)
                  } catch (exception) {
                    Logger.error(BeanVisuController, $"Fatal error, splashscreen, {exception.message}")
                    Core.printStackTrace()
                  }
                }

                
                var interval = 5
                var duration = 3
                var amount = 3
                if (!task.state.fadeInEmitt) {
                  task.state.fadeInEmitt = true
                  controller.particleService.spawnParticleEmitter(
                    "main",
                    "particle-splashscreen",
                    GuiWidth() / 2.0,
                    GuiHeight() / 2.0,
                    GuiWidth() / 2.0,
                    GuiHeight() / 2.0,
                    FRAME_MS * interval * duration,
                    amount,
                    FRAME_MS * interval
                  )
                }

                controller.particleService.update().systems.get("main").render()
                if (shader_is_compiled(shader_dissolve)) {
                  var u_time = shader_get_uniform(shader_dissolve, "u_time")

                  var time = (0.75 * task.state.fadeIn.getProgress())
                    + (2.5 * task.state.duration.getProgress())
                    + (0.75 * task.state.fadeOut.getProgress())
                  shader_set(shader_dissolve)
                  shader_set_uniform_f(u_time, 6.0 + time)
                  task.state.logo
                    .scaleToFit(max(displayService.minWidth, ((time * 50.0) + width) / 1.5), max(displayService.minHeight, ((time * 50.0) + height) / 1.5))
                    .setAlpha(task.state.alpha)
                    .render(width / 2.0, height / 2.0)
                  shader_reset()
                } else {
                  task.state.logo
                    .scaleToFit(max(displayService.minWidth, width / 1.5), max(displayService.minHeight, height / 1.5))
                    .setAlpha(task.state.alpha)
                    .render(width / 2.0, height / 2.0)
                }

                task.state.label
                  .setAlpha(task.state.skipAlpha)
                  .render(width / 2.0, height * 0.925, width * 0.9, height * 0.2)

                return this
              },
            })

            controller.visuRenderer.executor.add(task)

          },
          onFinish: function(fsm, fsmState, data) {
            var controller = Beans.get(BeanVisuController)
            if (Optional.is(controller.ostSound)) {
              controller.ostSound.stop()
              controller.ostSound = null
            }
          },
        },
        update: function(fsm) {
          try {
            var controller = Beans.get(BeanVisuController)
            if (Optional.is(controller.ostSound)) {
              controller.ostSound.stop()
              controller.ostSound = null
            }

            var task = controller.visuRenderer.executor.tasks
              .find(TaskUtil.filterByName, "splashscreen")
            if (!Optional.is(task)) {
              fsm.dispatcher.send(new Event("transition", { name: "idle" }))
            }
          } catch (exception) {
            var message = $"'fsm::update' (state: 'splashscreen') fatal error: {exception.message}"
            Logger.error(BeanVisuController, message)
            Core.printStackTrace()
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
          }
        },
        transitions: {
          "splashscreen": null,
          "idle": null,
          "quit": null,
        },
      },
      "idle": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            var controller = Beans.get(BeanVisuController)
            controller.visuRenderer.gridRenderer.camera.breathTimer1.reset()
            controller.visuRenderer.gridRenderer.camera.breathTimer2.reset()

            if (Optional.is(controller.ostSound)) {
              controller.ostSound.stop()
              controller.ostSound = null
            }

            if (Core.isType(data, Event)) {
              fsm.context.send(data)
            }

            fsmState.state.set("bkgTimer", new Timer(6.0 + random(10.0), { loop: Infinity }))
            fsmState.state.set("bkgColorTimer", new Timer(6.0 + random(10.0), { loop: Infinity }))
            fsmState.state.set("glitchTimer", new Timer(6.0 + random(10.0), { loop: Infinity }))
          },
          onFinish: function(fsm, fsmState, data) {
            var controller = Beans.get(BeanVisuController)
            controller.visuRenderer.gridRenderer.camera.breathTimer1.reset()
            controller.visuRenderer.gridRenderer.camera.breathTimer2.reset()

            if (Optional.is(controller.ostSound)) {
              controller.ostSound.stop()
              controller.ostSound = null
            }
          },
        },
        update: function(fsm) {
          var controller = Beans.get(BeanVisuController)
          var gridService = controller.gridService
          if (!Optional.is(controller.ostSound)) {
            var sound = SoundUtil.fetch("sound_goetia_cerecloth", { loop: true })
            controller.ostSound = Core.isType(sound, Sound)
              ? sound 
              : controller.ostSound
          } else {
            var ostVolume = Visu.settings.getValue("visu.audio.ost-volume")
            if (!controller.ostSound.isLoaded()) {
              //controller.ostSound.play(0.0).rewind(random(90.0)).setVolume(ostVolume, 2.0)
              controller.ostSound.play(0.0).setVolume(ostVolume, 2.0)
            } else if (controller.ostSound.isPaused()) {
              controller.ostSound.resume().setVolume(ostVolume, 2.0)
            } else if (controller.ostSound.isPlaying()
                && ostVolume != controller.ostSound.getVolume()) {
              controller.ostSound.setVolume(ostVolume, 2.0)
            }
          }
  
          var bkgTimer = this.state.get("bkgTimer")
          if (bkgTimer.update().finished) {
            bkgTimer.setDuration(6.0 + random(10.0))
            gridService.init(bkgTimer.duration * (0.75 + random(0.75)))
          }

          var bkgColorTimer = this.state.get("bkgColorTimer")
          if (bkgColorTimer.update().finished) {
            bkgColorTimer.setDuration(6.0 + random(10.0))
            var properties = gridService.properties
            var pump = controller.dispatcher
            var executor = controller.executor
            var color = ColorUtil.parse(GMArray.getRandom([
              "#000000ff",
              "#081179ff",
              "#000000",
              "#480564ff",
              "#0e1e1bff",
              "#8e0a0aff",
              "#000000",
              //"#21670eff",
              "#1a1748ff",
              //"#c70a68ff",
              "#000000",
              //"#d31c44ff",
              "#000000",
              "#570e4eff"
            ]))
            Visu.resolveColorTransformerTrackEvent(
              {
                use: true,
                col: color,
                spd: bkgColorTimer.duration * 0.9,
              }, 
              "use",
              "col",
              "spd",
              "gridClearColor",
              properties,
              pump,
              executor
            )
          }

          var glitchTimer = this.state.get("glitchTimer")
          if (glitchTimer.update().finished) {
            glitchTimer.setDuration(6.0 + random(10.0))
            var factor = 0.08 + random(1.0) * 0.08
            effect_track_event.brush_effect_glitch.run({
              "ef-glt_use-config": false,
              "ef-glt_use-fade-out": true,
              "ef-glt_fade-out": factor,
              "ef-glt_glitch": choose(GlitchType.GRID, GlitchType.GRID, GlitchType.BACKGROUND),
            })
          }

          controller.visuRenderer.gridRenderer.camera.breathTimer1.update()
          controller.visuRenderer.gridRenderer.camera.breathTimer2.update()
        },
        transitions: { 
          "idle": null, 
          "game-over": null,
          "load": null, 
          "play": null, 
          "pause": null, 
          "paused": null,
          "quit": null,
        },
      },
      "game-over": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            var promises = new Map(String, Promise, {
              "track": fsm.context.trackService.dispatcher
                .execute(new Event("pause-track")),
            })

            if (Optional.is(fsm.context.videoService.getVideo())) {
              promises.set("video", fsm.context.videoService.dispatcher
                .execute(new Event("pause-video")))
            }

            fsmState.state.set("promises", promises)
            fsm.context.menu.send(fsm.context.menu
              .factoryOpenMainMenuEvent({ 
                titleLabel: "Game over"
              }))
          },
        },
        update: function(fsm) {
          if (!fsm.context.menu.enabled) {
            fsm.context.menu.send(fsm.context.menu
              .factoryOpenMainMenuEvent({ 
                titleLabel: "Game over"
              }))
          }
        },
        transitions: { 
          "idle": null, 
          "game-over": null,
          "load": null, 
          "play": null, 
          "pause": null, 
          "paused": null,
          "quit": null,
        },
      },
      "load": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            var controller = Beans.get(BeanVisuController)
            controller.menu.send(new Event("close"))
            controller.loader.fsm.dispatcher.send(new Event("transition", {
              name: "clear-state",
              data: data.manifest,
            }))
            fsmState.state.set("autoplay", Struct.getDefault(data, "autoplay", false))
            
            if (Optional.is(controller.ostSound)) {
              controller.ostSound.stop()
              controller.ostSound = null
            }

            var staticSounds = GMArray.toMap(VISU_SFX_AUDIO_NAMES, String, Boolean, Lambda.returnTrue, null, Lambda.passthrough)

            audio_stop_all()
            controller.visuRenderer.gridRenderer.clear()
            Beans.get(BeanSoundService).free(staticSounds)
            //Beans.get(BeanTextureService).free()
            
            controller.trackService.dispatcher.execute(new Event("close-track"))
          },
        },
        update: function(fsm) {
          try {
            var loaderState = fsm.context.loader.fsm.getStateName()
            Assert.areEqual(loaderState != null && loaderState != "idle", true, $"Invalid loader state: {loaderState}")
            if (loaderState == "loaded") {
              fsm.dispatcher.send(new Event("transition", {
                name: this.state.get("autoplay") ? "play" : "pause",
              }))
            }
          } catch (exception) {
            var message = $"'fsm::update' (state: 'load') fatal error: {exception.message}"
            Logger.error(BeanVisuController, message)
            Core.printStackTrace()
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
            fsm.context.loader.fsm.dispatcher.send(new Event("transition", { name: "idle" }))
          }
        },
        transitions: { 
          "idle": null, 
          "play": null, 
          "pause": null,
        },
      },
      "play": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            var controller = Beans.get(BeanVisuController)
            controller.visuRenderer.gridRenderer.camera.breathTimer1.reset()
            controller.visuRenderer.gridRenderer.camera.breathTimer2.reset()
            controller.menu.send(new Event("close", { fade: true }))

            var promises = new Map(String, Promise, {})
            fsmState.state.set("promises", promises)

            var videoService = controller.videoService
            if (Optional.is(videoService.getVideo())) {
              promises.set("video", videoService.send(new Event("resume-video")))
            }

            ///@hack
            var trackService = controller.trackService
            if (trackService.isTrackLoaded() && !trackService.track.audio.isLoaded()) {
              trackService.time = 0.0
            }
          },
        },
        update: function(fsm) {
          try {
            if (this.state.get("promises-resolved") != "success") {
              var promises = this.state.get("promises")
              var filtered = promises.filter(fsm.context.loader.utils.filterPromise)
              if (filtered.size() != promises.size()) {
                return
              }

              if (!promises.contains("track")) {
                promises.set("track", fsm.context.trackService.send(new Event("resume-track")))
                return
              }

              this.state.set("promises-resolved", "success")
              return
            }

            //Assert.isType(fsm.context.playerService.player, Player)
            //Assert.areEqual(fsm.context.videoService.getVideo().getStatus(), VideoStatus.PLAYING)
            //Assert.areEqual(fsm.context.trackService.track.getStatus(), TrackStatus.PLAYING)
          } catch (exception) {
            var message = $"'fsm::update' (state: 'play') fatal error: {exception.message}"
            Logger.error(BeanVisuController, message)
            Core.printStackTrace()
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
          }
        },
        transitions: { 
          "idle": null, 
          "game-over": null,
          "load": null, 
          "pause": null, 
          "rewind": null, 
          "quit": null,
        },
      },
      "pause": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            var promises = new Map(String, Promise, {
              "track": fsm.context.trackService
                .send(new Event("pause-track")),
            })

            if (Optional.is(fsm.context.videoService.getVideo())) {
              promises.set("video", fsm.context.videoService
                .send(new Event("pause-video")))
            }

            fsmState.state.set("promises", promises)
            fsmState.state.set("menuEvent", data)
          },
        },
        update: function(fsm) {
          try {
            if (this.state.get("promises-resolved") != "success") {
              var promises = this.state.get("promises")
              var filtered = promises.filter(fsm.context.loader.utils.filterPromise)
              if (filtered.size() != promises.size()) {
                return
              }
              this.state.set("promises-resolved", "success")
            }

            fsm.dispatcher.send(new Event("transition", { 
              name: "paused", 
              data: this.state.get("menuEvent"),
            }))
            //Assert.areEqual(fsm.context.videoService.getVideo().getStatus(), VideoStatus.PAUSED)
            //Assert.areEqual(fsm.context.trackService.track.getStatus(), TrackStatus.PAUSED)
          } catch (exception) {
            var message = $"'fsm::update' (state: 'pause') fatal error: {exception.message}"
            Logger.error(BeanVisuController, message)
            Core.printStackTrace()
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
          }
        },
        transitions: { 
          "idle": null, 
          "load": null, 
          "play": null, 
          "paused": null,
          "rewind": null, 
          "quit": null,
        },
      },
      "paused": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            if (Core.isType(data, Event)) {
              Beans.get(BeanVisuController).menu.send(data)
            }
          },
          onFinish: function(fsm, fsmState, data) {
            Beans.get(BeanVisuController).menu.send(new Event("close", { fade: true }))
          },
        },
        update: function(fsm) { },
        transitions: {
          "idle": null, 
          "load": null,
          "play": null, 
          "pause": null, 
          "rewind": null, 
          "quit": null,
        }
      },
      "rewind": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            var promises = new Map(String, Promise, {
              "pause-track": fsm.context.trackService
                .send(new Event("pause-track")),
            })

            var trackDuration = fsm.context.trackService.duration
            var video = fsm.context.videoService.getVideo()
            if (Optional.is(video) && trackDuration > 0.0) {
              var videoData = JSON.clone(data)
              var videoDuration = video.getDuration()
              if (videoData.timestamp > videoDuration) {
                videoData.timestamp = videoData.timestamp mod videoDuration
              }
              
              promises.set("rewind-video", fsm.context.videoService
                .send(new Event("rewind-video", videoData)))
            }

            fsmState.state
              .set("resume", data.resume)
              .set("data", data)
              .set("promises", promises)
          },
        },
        update: function(fsm) {
          try {
            if (this.state.get("promises-resolved") != "success") {
              var promises = this.state.get("promises")
              ///@description gml bug answered by videoServiceAttempts "feature"
              try {
                var filtered = promises.filter(fsm.context.loader.utils.filterPromise)
                if (filtered.size() != promises.size()) {
                  return
                }
              } catch (exception) {
                var message = $"Rewind exception: {exception.message}"
                Logger.warn("VisuController", message)
                //Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
                if (!promises.contains("rewind-video")) {
                  return
                }

                promises.forEach(function(promise, name) {
                  if (name != "rewind-video" && promise.status == PromiseStatus.REJECTED) {
                    throw new Exception($"non-video promise failed: '{name}'")
                  }
                })

                var data = this.state.get("data")
                var videoServiceAttempts = Struct.get(data, "videoServiceAttempts")
                if (!Core.isType(videoServiceAttempts, Number) 
                  || videoServiceAttempts == 0) {
                  throw new Exception($"video promise failed. 'videoServiceAttempts' value: {videoServiceAttempts}")
                }
                data.videoServiceAttempts = videoServiceAttempts - 1
                Logger.debug("VisuController", $"videoServiceAttempts value: {data.videoServiceAttempts}")
                promises.set("rewind-video", fsm.context.videoService.send(new Event("rewind-video", data)))
                return
              }

              if (!promises.contains("rewind-track")) {
                promises.set("rewind-track", fsm.context.trackService.send(new Event(
                  "rewind-track", this.state.get("data"))))
                return
              }

              this.state.set("promises-resolved", "success")
            } else {
              fsm.context.send(new Event(this.state.get("resume") ? "play" : "pause"))
            }
          } catch (exception) {
            var message = $"'fsm::update' (state: 'rewind') fatal error: {exception.message}"
            Logger.error(BeanVisuController, message)
            Core.printStackTrace()
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
            fsm.dispatcher.send(new Event("transition", {
              name: this.state.get("resume") ? "play" : "pause",
            }))
          }
        },
        transitions: {
          "idle": null, 
          "play": null, 
          "pause": null, 
          "quit": null,
        },
      },
      "quit": {
        actions: {
          onStart: function(fsm, fsmState, data) { 
            fsm.context.free()
            game_end()
          }
        },
      },
    },
  })
}