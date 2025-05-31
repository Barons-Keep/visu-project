///@package io.alkapivo.core.util.task

///@enum
function _TaskStatus(): Enum() constructor {
  IDLE = "idle"
  RUNNING = "running"
  FULLFILLED = "fullfilled"
  REJECTED = "rejected"
}
global.__TaskStatus = new _TaskStatus()
#macro TaskStatus global.__TaskStatus


///@param {String} _name
///@param {Struct} [config]
function Task(_name, config = {}) constructor {

  ///@type {String}
  name = Assert.isType(_name, String, "Task.name must be type of String")

  ///@type {TaskStatus}
  status = Assert.isEnum(TaskStatus.IDLE, TaskStatus, "Task.status must be type of TaskStatus")

  ///@type {any}
  state = null

  ///@private
  ///@type {?Timer}
  timeout = null

  ///@private
  ///@type {?Callable}
  onTimeout = null

  ///@private
  ///@type {?Timer}
  tick = null

  ///@private
  ///@type {?Callable}
  onUpdate = null

  ///@private
  ///@type {?Callable}
  onStart = null

  ///@private
  ///@type {?Callable}
  onFinish = null

  ///@type {?Promise}
  promise = null

  ///@param {?Callable} onStart
  ///@return {Task}
  static whenStart = function(onStart) {
    this.onStart = Core.isType(onStart, Callable) ? method(this, onStart) : null
    return this
  }
  this.whenStart(Struct.get(config, "onStart"))
  
  ///@param {?Callable} onFinish
  ///@return {Task}
  static whenFinish = function(onFinish) {
    this.onFinish = Core.isType(onFinish, Callable) ? method(this, onFinish) : null
    return this
  }
  this.whenFinish(Struct.get(config, "onFinish"))

  ///@param {?Callable} onUpdate
  ///@return {Task}
  static whenUpdate = function(onUpdate) {
    this.onUpdate = Core.isType(onUpdate, Callable) ? method(this, onUpdate) : null
    return this
  }
  this.whenUpdate(Struct.get(config, "onUpdate"))

  ///@param {?Callable} onTimeout
  ///@return {Task}
  static whenTimeout = function(onTimeout) {
    this.onTimeout = Core.isType(onTimeout, Callable) ? method(this, onTimeout) : null
    return this
  }
  this.whenTimeout(Struct.get(config, "whenTimeout"))

  ///@param {?Number} timeout
  ///@return {Task}
  static setTimeout = function(timeout) {
    this.timeout = Core.isType(timeout, Number) ? new Timer(timeout) : null
    return this
  }
  this.setTimeout(Struct.get(config, "timeout"))

  ///@param {?Number} tick
  ///@return {Task}
  static setTick = function(tick) {
    this.tick = Core.isType(tick, Number) 
      ? new Timer(tick, { time: tick, loop: Infinity })
      : null
    return this
  }
  this.setTick(Struct.get(config, "tick"))

  ///@param {any} state
  ///@return {Task}
  static setState = function(state) {
    this.state = state
    return this
  }
  this.setState(Struct.get(config, "state"))

  ///@param {?Promise} promise
  ///@return {Task}
  static setPromise = function(promise) {
    this.promise = promise != null ? Assert.isType(promise, Promise) : null
    return this
  }
  this.setPromise(Struct.get(config, "promise"))

  ///@param {any} [data]
  ///@return {Task}
  static fullfill = function(data = null) {
    this.status = TaskStatus.FULLFILLED
    if (Optional.is(this.promise)) {
      this.promise.fullfill(data)
    }

    return this
  }

  ///@param {any} [data]
  ///@return {Task}
  static reject = function(data = null) {
    this.status = TaskStatus.REJECTED
    if (Optional.is(this.promise)) {
      this.promise.reject(data)
    }
    
    return this
  }

  ///@param {TaskExecutor} executor
  ///@return {Task}
  ///@throws {Exception}
  static update = function(executor = null) {
    if (this.status == TaskStatus.FULLFILLED) {
      return this
    }

    if (Optional.is(this.timeout) && this.timeout.update().finished) {
      this.reject()
      if (Optional.is(this.onTimeout)) {
        this.onTimeout(executor)
      } else {
        throw new Exception($"Task timed out: '{this.name}'")
      }
    }

    if (Optional.is(this.tick) && !this.tick.update().finished) {
      return this
    }

    if (Optional.is(this.onUpdate)) {
      this.onUpdate(executor)
    }

    return this
  }
}


///@static
function _TaskUtil() constructor {
  
  ///@param {Task} task
  ///@param {any} iterator
  ///@param {String} name
  filterByName = function(task, iterator, name) {
    return task.name == name
  }

  ///@param {Task} task
  ///@return {Boolean}
  filterFinished = function(task) {
    return task.status == TaskStatus.FULLFILLED
        || task.status == TaskStatus.REJECTED
  }

  ///@param {Task} task
  ///@param {any} [iterator]
  ///@param {any} [data]
  fullfill = function(task, iterator = null, data = null) { 
    if (task.status != TaskStatus.FULLFILLED 
        && task.status != TaskStatus.REJECTED) {
      task.fullfill(data)
    }
  }

  ///@param {Task} task
  ///@param {any} [iterator]
  ///@param {any} [data]
  reject = function(task, iterator = null, data = null) { 
    if (task.status != TaskStatus.FULLFILLED 
        && task.status != TaskStatus.REJECTED) {
      task.reject(data)
    }
  }

  ///@type {Struct}
  factory = {
    ///@param {?Struct} [config]
    ///@return {Task}
    splashscreen: function(config = null) {
      return new Task(Struct.getIfType(config, "name", String, "splashscreen"))
        .setTimeout(Struct.getIfType(config, "timeout", Number, 15.0))
        .setState(Struct.appendRecursiveUnique({
          fadeIn: new Timer(Struct.getIfType(config, "fadeIn", Number, 1.0)),
          duration: new Timer(Struct.getIfType(config, "duration", Number, 1.0)),
          fadeOut: new Timer(Struct.getIfType(config, "fadeOut", Number, 1.0)),
          alpha: Struct.getIfType(config, "alpha", Number, 0.0),
          showSkipTimer: new Timer(Struct.getIfType(config, "showSkipTimer", Number, 0.5)),
          skipTimer: new Timer(Struct.getIfType(config, "skipTimer", Number, 0.5)),
          showSkip: Struct.getIfType(config, "showSkip", Boolean, false),
          skip: Struct.getIfType(config, "skip", Boolean, false),
          skipAlpha: Struct.getIfType(config, "skipAlpha", Number, 0.0),
          stage: Struct.getIfType(config, "stage", String, "in"),
          resolveAlpha: function(task) {
            static resolve = function(task) {
              switch(task.state.stage) {
                case "in": return task.state.fadeIn.getProgress()
                case "on": return 1.0
                case "out": return 1.0 - task.state.fadeOut.getProgress()
                default: return task.state.alpha
              }
            }

            task.state.alpha = resolve(task)
            return this
          },
          resolveSkipAlpha: function(task) {
            if (task.state.showSkip && !task.state.skip) {
              task.state.skipAlpha = task.state.showSkipTimer.update().finished
                ? 1.0
                : task.state.showSkipTimer.getProgress()
              return this
            }

            if (task.state.skip) {
              if (!task.state.showSkipTimer.finished) {
                task.state.skipTimer.time = (task.state.skipTimer.duration) * (1.0 - task.state.showSkipTimer.getProgress())
                task.state.showSkipTimer.finish().update()
              }

              task.state.skipAlpha = task.state.skipTimer.update().finished
                ? 0.0
                : 1.0 - task.state.skipTimer.getProgress()
              return this
            }

            return this
          },
          resolveKey: function(task) {
            if (!task.state.getKey()) {
              return this
            }

            if (!task.state.showSkip) {
              task.state.showSkip = true
              return this
            }

            if (!task.state.skip) {
              task.state.skip = true
            }
            
            if (task.state.fadeIn.finished) {
              task.state.duration.finish().update()
              task.state.stage = "out"
            }

            return this
          },
          stages: {
            init: function(task) {
              task.state.fadeIn.reset()
              task.state.duration.reset()
              task.state.fadeOut.reset()
              task.state.alpha = 0.0

              task.state.showSkipTimer.reset()
              task.state.skipTimer.reset()
              task.state.showSkip = false
              task.state.skip = false
              task.state.skipAlpha = 0.0

              task.state.stage = "in"
            },
            in: function(task) {
              if (task.state.fadeIn.update().finished) {
                task.state.stage = "on"
              }
            },
            on: function(task) {
              if (task.state.duration.update().finished) {
                task.state.stage = "out"
              }
            },
            out: function(task) {
              if (task.state.fadeOut.update().finished) {
                task.fullfill()
              }
            }
          },
          getKey: Struct.getIfType(config, "getKey", Callable, function(task) {
            return keyboard_check_pressed(vk_anykey)
                || mouse_check_button_pressed(mb_any)
          }),
          render: Struct.getIfType(config, "render", Callable, function(task, layout) {
            return this
          }),
        }, config, true))
        .whenUpdate(function(executor) {
          Callable.run(Assert.isType(
            Struct.get(this.state.stages, this.state.stage), Callable, 
            $"stage must be callable, stage: {this.state.stage}"
          ), this)

          this.state.resolveKey(this)
          this.state.resolveAlpha(this)
          this.state.resolveSkipAlpha(this)
        })
    },
  }
}

global.__TaskUtil = new _TaskUtil()
#macro TaskUtil global.__TaskUtil