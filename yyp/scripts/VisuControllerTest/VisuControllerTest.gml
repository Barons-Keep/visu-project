///@package io.alkapivo.visu


///@param {Test} json
///@return {Task}
function Test_VisuController_load(test) {
  var json = Struct.get(test, "data")
  return new Task("Test_VisuController_load")
    .setTimeout(Struct.getDefault(json, "timeout", 10.0))
    .setPromise(new Promise())
    .setState({
      description: test.description,
      path: Assert.isType(Struct.get(json, "path"), String, "path must be type of String"),
      trackName: Assert.isType(Struct.get(json, "trackName"), String, "trackName must be type of String"),
      cooldown: new Timer(Struct.getIfType(json, "cooldown", Number, 2.0)),
      stage: "cooldownBefore",
      stages: {
        cooldownBefore: function(task) {
          if (task.state.cooldown.update().finished) {
            task.state.stage = "setup"
            task.state.cooldown.reset()
          }
        },
        setup: function(task) {
          if (Beans.get(BeanVisuController).fsm.getStateName() == "load") {
            return
          }

          runner = Beans.get(BeanTestRunner)
          runner.exceptions.clear()
          Beans.get(BeanVisuController).send(new Event("load", {
            manifest: task.state.path,
            autoplay: false
          }))

          task.state.stage = "verify"
        },
        verify: function(task) {
          Assert.isTrue(Beans.get(BeanTestRunner).exceptions.size() == 0, "No exceptions can be thrown")
          var controller = Beans.get(BeanVisuController)
          if (controller.loader.fsm.getStateName() == "loaded" 
            && controller.trackService.track.name == task.state.trackName) {
            task.state.stage = "pause" 
          }
        },
        pause: function(task) {
          var controller = Beans.get(BeanVisuController)
          if (controller.fsm.getStateName() == "paused") {
            task.state.stage = "cooldownAfter"
          }
        },
        cooldownAfter: function(task) {
          if (task.state.cooldown.update().finished) {
            task.fullfill("success")
          }
        }
      },
    })
    .whenUpdate(function(executor) {
      var stage = Struct.get(this.state.stages, this.state.stage)
      stage(this)
    })
    .whenStart(function(executor) {
      Logger.test(BeanTestRunner, $"Test_VisuController_load started. Description: {this.state.description}")
      Beans.get(BeanTestRunner).installHooks()
      Visu.settings.setValue("visu.god-mode", true)
    })
    .whenFinish(function(data) {
      Logger.test(BeanTestRunner, $"Test_VisuController_load finished. Description: {this.state.description}")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
    .whenTimeout(function() {
      Logger.test(BeanTestRunner, $"Test_VisuController_load timeout. Description: {this.state.description}")
      this.reject("failure")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
}


///@param {Test} json
///@return {Task}
function Test_VisuController_playback(test) {
  var json = Struct.get(test, "data")
  return new Task("Test_VisuController_playback")
    .setTimeout(Struct.getDefault(json, "timeout", 20.0))
    .setPromise(new Promise())
    .setState({
      description: test.description,
      duration: Struct.getDefault(json, "duration", 10.0),
      cooldown: new Timer(Struct.getDefault(json, "cooldown", 2.0)),
      stage: "cooldownBefore",
      videoLimit: new Timer(Struct.getDefault(json, "videoLimit", 2.0)),
      stages: {
        cooldownBefore: function(task) {
          if (task.state.cooldown.update().finished) {
            task.state.stage = "setup"
            task.state.cooldown.reset()
          }
        },
        setup: function(task) {
          Beans.get(BeanTestRunner).exceptions.clear()
          Beans.get(BeanVisuController).send(new Event("play"))
          task.state.stage = "playback"
        },
        playback: function(task) {
          Assert.isTrue(Beans.get(BeanTestRunner).exceptions.size() == 0, "No exceptions can be thrown")
          var controller = Beans.get(BeanVisuController)
          if (controller.trackService.time > task.state.duration) {
            controller.send(new Event("pause"))
            task.state.stage = "pause" 
          }

          var track = controller.trackService.track
          var video = controller.videoService.getVideo()
          if (Optional.is(video) && track.getStatus() == TrackStatus.PLAYING) {
            if (video.getStatus() != VideoStatus.PLAYING) {
              task.state.videoLimit.update()
            }
            Assert.isFalse(task.state.videoLimit.finished, "Video must be played")
          }

          var player = controller.playerService.player
          if (Core.isType(player, Player)) {
            if (!Struct.getDefault(player, "keyboardHook", false)) {
              Struct.set(player, "keyboardHook", true)

              var keypressMap = new Map(String, TestKeypress, {
                up: new TestKeypress({
                  durations: [ 0.1, 0.2, 0.3, 0.5, 0.7, 1.0, 1.1, 1.25, 1.5, 1.7, 2.0 ],
                  luck: 0.66,
                  key: "up"
                }),
                down: new TestKeypress({
                  durations: [ 0.1, 0.2, 0.3, 0.5, 0.7, 1.0, 1.1, 1.25, 1.5, 1.7, 2.0 ],
                  luck: 0.66,
                  key: "down"
                }),
                left: new TestKeypress({
                  durations: [ 0.1, 0.2, 0.3, 0.5, 0.7, 1.0, 1.1, 1.25, 1.5, 1.7, 2.0 ],
                  luck: 0.66,
                  key: "left"
                }),
                right: new TestKeypress({
                  durations: [ 0.1, 0.2, 0.3, 0.5, 0.7, 1.0, 1.1, 1.25, 1.5, 1.7, 2.0 ],
                  luck: 0.66,
                  key: "right"
                }),
                action: new TestKeypress({
                  durations: [ 0.1, 0.2, 0.3, 0.5, 0.7, 1.0, 1.1, 1.25, 1.5, 1.7, 2.0 ],
                  luck: 0.33,
                  key: "action"
                }),
                bomb: new TestKeypress({
                  durations: [ 0.1, 0.2, 0.3, 0.5, 0.7, 1.0, 1.1, 1.25, 1.5, 1.7, 2.0 ],
                  luck: 0.15,
                  key: "bomb"
                }),
                focus: new TestKeypress({
                  durations: [ 0.1, 0.2, 0.3, 0.5, 0.7, 1.0, 1.1, 1.25, 1.5, 1.7, 2.0 ],
                  luck: 0.50,
                  key: "focus"
                }),
              })
              Struct.set(player.keyboard, "keypressMap", keypressMap)
              Struct.set(player.keyboard, "_update", player.keyboard.update)
              player.keyboard.update = method(player.keyboard, function() {
                this.keypressMap.forEach(function(keypress, name, keyboard) {
                  keypress.update().updateKeyboard(keyboard)
                }, this)

                return this
              })
            }
          }
        },
        pause: function(task) {
          var controller = Beans.get(BeanVisuController)
          if (controller.fsm.getStateName() == "paused") {
            task.state.stage = "cooldownAfter"
          }
        },
        cooldownAfter: function(task) {
          if (task.state.cooldown.update().finished) {
            task.fullfill("success")
          }
        }
      },
    })
    .whenUpdate(function(executor) {
      var stage = Struct.get(this.state.stages, this.state.stage)
      stage(this)
    })
    .whenStart(function(executor) {
      Logger.test(BeanTestRunner, $"Test_VisuController_playback started. Description: {this.state.description}")
      Beans.get(BeanTestRunner).installHooks()
      Visu.settings.setValue("visu.god-mode", true)
    })
    .whenFinish(function(data) {
      Logger.test(BeanTestRunner, $"Test_VisuController_playback finished. Description: {this.state.description}")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
    .whenTimeout(function() {
      Logger.test(BeanTestRunner, $"Test_VisuController_playback timeout. Description: {this.state.description}")
      this.reject("failure")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
}


///@param {Test} json
///@return {Task}
function Test_VisuController_rewind(test) {
  var json = Struct.get(test, "data")
  return new Task("Test_VisuController_rewind")
    .setTimeout(Struct.getDefault(json, "timeout", 20.0))
    .setPromise(new Promise())
    .setState({
      description: test.description,
      amount: Struct.getDefault(json, "amount", 5),
      minDuration: Struct.getDefault(json, "maxDuration", 0.2),
      maxDuration: Struct.getDefault(json, "maxDuration", 3.0),
      target: 0,
      timer: new Timer(random_range(1, 2)),
      cooldown: new Timer(Struct.getDefault(json, "cooldown", 2.0)),
      stage: "cooldownBefore",
      count: 0,
      countTarget: Struct.getDefault(json, "amount", 5),
      stages: {
        cooldownBefore: function(task) {
          if (task.state.cooldown.update().finished) {
            task.state.stage = "rewind"
            task.state.cooldown.reset()
          }
        },
        setup: function(task) {
          controller.send(new Event("pause"))
          task.state.stage = "rewind"

          var editor = Beans.get(Visu.modules().editor.controller)
          if (Optional.is(editor)) {
            editor.renderUI = true
            editor.send(new Event("open"))
            if (!editor.store.getValue("_render-trackControl")) {
              editor.store.get("_render-trackControl").set(true)
            }
          }
        },
        rewind: function(task) {
          var controller = Beans.get(BeanVisuController)
          var trackService = controller.trackService
          if (task.state.timer.update().finished && task.state.amount > 0) {
            var delta = abs(trackService.time - task.state.target)
            if (delta < 2) {
              task.state.count++
            }
            Logger.test("Test_VisuController_rewind", $"Current delta: {delta}, counter: {task.state.count}")
            task.state.timer.reset()
            task.state.timer.duration = random_range(task.state.minDuration, task.state.maxDuration)
            task.state.target = random(trackService.duration * 0.7500)
            controller.send(new Event("rewind", { 
              timestamp: task.state.target,
            }))
            task.state.amount--
          }

          if (task.state.timer.finished && task.state.amount <= 0) {
            Logger.test("Test_VisuController_rewind", $"{task.state.count} successfull rewind attempts, target is {floor(task.state.countTarget * 0.75)}")
            if (task.state.count >= floor(task.state.countTarget * 0.75)) {
              var video = controller.videoService.getVideo()
              if (Core.isType(video, Video)) {
                if (video.getStatus() != VideoStatus.CLOSED) {
                  task.state.stage = "cooldownAfter"
                } else {
                  Logger.test("Test_VisuController_rewind", $"rejected, invalid video status: {video.getStatus()}")
                  task.reject()
                }
              } else {
                task.state.stage = "cooldownAfter"
              }
            } else {
              Logger.test("Test_VisuController_rewind", $"rejected, not matching target: {task.state.countTarget * 0.75}")
              task.reject()
            }
          }
        },
        cooldownAfter: function(task) {
          if (task.state.cooldown.update().finished) {
            task.fullfill("success")

            var editor = Beans.get(Visu.modules().editor.controller)
            if (Optional.is(editor)) {
              editor.send(new Event("close"))
              if (editor.store.getValue("render-trackControl")) {
                editor.store.get("render-trackControl").set(false)
              }
            }
          }
        }
      },
    })
    .whenUpdate(function(executor) {
      var stage = Struct.get(this.state.stages, this.state.stage)
      stage(this)
    })
    .whenStart(function(executor) {
      Logger.test(BeanTestRunner, $"Test_VisuController_rewind started. Description: {this.state.description}")
      Beans.get(BeanTestRunner).installHooks()
      Visu.settings.setValue("visu.god-mode", true)
    })
    .whenFinish(function(data) {
      Logger.test(BeanTestRunner, $"Test_VisuController_rewind finished. Description: {this.state.description}")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
    .whenTimeout(function() {
      Logger.test(BeanTestRunner, $"Test_VisuController_rewind timeout. Description: {this.state.description}")
      this.reject("failure")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
}