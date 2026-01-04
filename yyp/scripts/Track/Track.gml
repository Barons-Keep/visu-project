///@package io.alkapivo.core.service.track

///@static
///@type {Map<String, Callable>}
global.__DEFAULT_TRACK_EVENT_HANDLERS = new Map(String, Callable, {
  "dummy": {
    run: function(data) {
      Core.print("Dummy track event")
    },
  },
})
#macro DEFAULT_TRACK_EVENT_HANDLERS global.__DEFAULT_TRACK_EVENT_HANDLERS


///@enum
function _TrackStatus(): Enum() constructor {
  PLAYING = "playing"
  PAUSED = "paused"
  STOPPED = "stopped"
}
global.__TrackStatus = new _TrackStatus()
#macro TrackStatus global.__TrackStatus


///@interface
///@param {?Struct} [config]
function TimeSource(config = null) constructor {
  
  ///@return {TimeSource}
  play = method(this, Struct.getIfType(config, "play", Callable) != null ? config.play : function() { return this })
  
  ///@return {TimeSource}
  stop = method(this, Struct.getIfType(config, "stop", Callable) != null ? config.stop : function() { return this })
  
  ///@return {TimeSource}
  pause = method(this, Struct.getIfType(config, "pause", Callable) != null ? config.pause : function() { return this })
  
  ///@param {Number} timestamp
  ///@return {TimeSource}
  rewind = method(this, Struct.getIfType(config, "rewind", Callable) != null ? config.rewind : function(timestamp) { return this })
  
  ///@return {TimeSource}
  resume = method(this, Struct.getIfType(config, "resume", Callable) != null ? config.resume : function() { return this })
  
  ///@return {Boolean}
  isLoaded = method(this, Struct.getIfType(config, "isLoaded", Callable) != null ? config.isLoaded : function() { return false })
  
  ///@return {Boolean}
  isPaused = method(this, Struct.getIfType(config, "isPaused", Callable) != null ? config.isPaused : function() { return false })
  
  ///@return {Boolean}
  isPlaying = method(this, Struct.getIfType(config, "isPlaying", Callable) != null ? config.isPlaying : function() { return false })
  
  ///@return {Number}
  getPosition = method(this, Struct.getIfType(config, "getPosition", Callable) != null ? config.getPosition : function() { return 0.0 })
  
  ///@return {Number}
  getDuration = method(this, Struct.getIfType(config, "getDuration", Callable) != null ? config.getDuration : function() { return 0.0 })

  ///@return {TimeSource}
  update = method(this, Struct.getIfType(config, "update", Callable) != null ? config.getDuration : function() { return this })

  Struct.appendUnique(this, config)
}

/* AudioTimeSource
new TimeSource({
  sound: Assert.isType(SoundUtil.fetch(Struct.get(json, "audio"), { loop: false }), Sound, "Track.sound must be type of Sound")
  play: function() {
    this.sound.play()
    return this
  },
  stop: function() {
    this.sound.stop()
    return this
  },
  pause: function() {
    this.sound.pause()
    return this
  },
  rewind: function(timestamp) {
    this.sound.rewind(timestamp)
    return this
  },
  resume: function() {
    this.sound.resume()
    return this
  },
  isLoaded: function() {
    return this.sound.isLoaded()
  },
  isPaused: function() {
    return this.sound.isPaused()
  },
  isPlaying: function() {
    return this.sound.isPlaying()
  },
  getPosition: function() {
    return this.sound.getPosition()
  },
  getDuration: function() {
    return this.sound.getDuration()
  },
  update: function() {
    if (!this.isPlaying()) {
      return this
    }

    var sound = this.sound
    var volume = Visu.settings.getValue("visu.audio.ost-volume")
    if (sound.getVolume() != volume) {
      sound.setVolume(volume)
    }
    
    return this
  }
})
*/


///@param {Struct} json
///@param {?Struct} [config]
function Track(json, config = null) constructor {

  ///@type {String}
  name = Assert.isType(Struct.get(json, "name"), String,
    "Track::name must be type of String")

  ///@type {Sound}
  audio = Assert.isType(SoundUtil.fetch(Struct.get(json, "audio"), { loop: false }), Sound,
    "Track::audio must be type of Sound")

  ///@type {Map<String, TrackChannel>}
  channels = new Map(String, TrackChannel)

  ///@type {Task}
  var track = this
  task = new Task("parse-track")
    .setPromise(Struct.getIfType(config, "promise", Promise, null))
    .setState({
      track: track,
      config: config,
      index: 0,
      channel: null,
      channels: new Queue(Struct, Struct.getIfType(json, "channels", GMArray, [])),
    })
    .whenUpdate(function() {
      if (!Struct.getIfType(this.state.config, "parseAsync", Boolean, false)) {
        this.state.channels.forEach(function(entry, index, state) {
          var channel = state.track.parseTrackChannel(entry, index, state.config)
          channel.task.update()
          state.index = index
          state.track.channels.add(channel, channel.name)
        }, this.state)
        
        this.fullfill()
      } else {
        if (!Optional.is(this.state.channel)) {
          if (this.state.channels.size() == 0) {
            this.fullfill()
            return
          }
          this.state.channel = this.state.track.parseTrackChannel(this.state.channels.pop(), this.state.index, this.state.config)
        } else {
          this.state.channel.task.update()
          if (this.state.channel.task.status == TaskStatus.FULLFILLED) {
            this.state.track.channels.add(this.state.channel, this.state.channel.name)
            this.state.channel = null
            this.state.index += 1
          } else if (this.state.channel.task.status == TaskStatus.REJECTED) {
            this.reject()
          }
        }
      }
    })

  ///@private
  ///@param {Struct} channel
  ///@param {Number} index
  ///@param {?Struct} [config]
  ///@return {TrackChannel}
  parseTrackChannel = Core.isType(Struct.get(config, "parseTrackChannel"), Callable)
    ? method(this, config.parseTrackChannel)
    : function(channel, index, config) {
        //Logger.debug("Track", $"Parse channel '{channel.name}' at index {index}")
        return new TrackChannel({ 
          name: Assert.isType(Struct.get(channel, "name"), String),
          events: Assert.isType(Struct.get(channel, "events"), GMArray),
          index: index,
          settings: Struct.get(channel, "settings"),
        }, config)
      }

  ///@private
  ///@param {String} name
  ///@param {?Struct} [config]
  ///@return {TrackChannel}
  injectTrackChannel = method(this, Assert.isType(Struct
    .getDefault(config, "injectTrackChannel", function(name, config) {
      return this.channels.contains(name)
        ? this.channels.get(name)
        : this.channels.set(name, this.parseTrackChannel({ 
            name: name, 
            events: []
          }, this.channels.size(), config)).get(name)
    }), Callable))

  ///@param {String} name
  ///@param {TrackEvent} event
  ///@return {Track}
  addEvent = method(this, Assert.isType(Struct
    .getDefault(config, "add", function(name, event) {
      this.injectTrackChannel(name).add(event)
      return this
    }), Callable))

  ///@param {String} channelName
  ///@param {TrackEvent} event
  ///@return {Track}
  removeEvent = method(this, Assert.isType(Struct
    .getDefault(config, "remove", function(channelName, event) {
      this.injectTrackChannel(channelName).remove(event)
      return this
    }), Callable))

  ///@param {String} name
  ///@param {?Struct} [config]
  ///@return {Track}
  addChannel = method(this, Assert.isType(Struct
    .getDefault(config, "addChannel", function(name, config) {
      if (this.channels.contains(name)) {
        return this
      }

      this.injectTrackChannel(name, config)
      return this
    }), Callable))

  ///@param {String} name
  ///@return {Track}
  removeChannel = Core.isType(Struct.get(config, "removeChannel"), Callable)
    ? method(this, config.removeChannel)
    : function(name) {
      var channel = this.channels.get(name)
      if (channel == null) {
        return this
      }

      Logger.info("Track", $"Remove channel '{name}'")
      this.channels.remove(name).forEach(function(channel, name, index) {
        if (channel.index > index) {
          channel.index = channel.index - 1
        }
      }, channel.index)
      delete channel

      return this
    }
  
  ///@param {Number} timestamp
  ///@return {Track}
  rewind = method(this, Assert.isType(Struct
    .getDefault(config, "rewind", function(timestamp) {
      static rewindChannel = function(channel, name, timestamp) {
        channel.rewind(timestamp)
      }

      this.audio.rewind(timestamp)
      this.channels.forEach(rewindChannel, timestamp)
      return this
    }), Callable))

  ///@param {Number} timestamp
  ///@return {Track}
  update = method(this, Assert.isType(Struct
    .getDefault(config, "update", function(timestamp) {
      static updateChannel = function(channel, name, timestamp) {
        channel.update(timestamp)
      }

      if (this.getStatus() == TrackStatus.PLAYING) {
        this.channels.forEach(updateChannel, timestamp)
      }

      return this
    }), Callable))

  ///@return {TrackStatus}
  getStatus = method(this, Assert.isType(Struct
    .getDefault(config, "getStatus", function() {
      if (!Core.isType(this.audio, Sound)) {
        return TrackStatus.STOPPED
      }

      if (this.audio.isPlaying()) {
        return TrackStatus.PLAYING
      }

      if (this.audio.isPaused()) {
        return TrackStatus.PAUSED
      }

      return TrackStatus.STOPPED     
    }), Callable))

  ///@return {String}
  serialize = method(this, Assert.isType(Struct
    .getDefault(config, "serialize", function() {
      return JSON.stringify({
        "model": "io.alkapivo.core.service.track.Track",
        "version": "1",
        "data": {
          "name": this.name,
          "audio": this.audio.name,
          "channels": this.channels
            .toArray(function(channel) {
              return channel  
            }, null, any)
            .sort(function(a, b) { 
              return a.index <= b.index
            })
            .map(function(channel) { 
              return channel.serialize()
            })
            .getContainer(),
        }
      }, true)
    }), Callable))
}


///@param {Struct} json
///@param {?Struct} [config]
function TrackChannel(json, config = null) constructor {

  ///@type {String}
  name = Assert.isType(Struct.get(json, "name"), String)

  ///@type {Number}
  index = Assert.isType(Struct.get(json, "index"), Number)

  ///@type {Boolean}
  muted = false

  ///@private
  ///@type {Number}
  time = 0.0

  ///@private
  ///@type {?Number}
  pointer = null

  ///@private
  ///@type {Number}
  MAX_EXECUTION_PER_FRAME = 99

  ///@private
  ///@param {Event}
  ///@param {Number} index
  ///@param {?Struct} [config]
  ///@return {TrackEvent}
  parseEvent = Optional.is(Struct.getIfType(config, "parseEvent", Callable))
    ? method(this, config.parseEvent)
    : function(event, index, config = null) {
      return new TrackEvent(event, config)
    }

  ///@private
  ///@param {Struct} json
  ///@return {Struct}
  parseSettings = Optional.is(Struct.getIfType(config, "parseSettings", Callable))
    ? method(this, config.parseSettings)
    : function(json) {
      return Core.isType(json, Struct) ? json : { }
    }
  
  ///@private
  ///@param {TrackEvent} a
  ///@param {TrackEvent} b
  ///@return {Boolean}
  compareEvents = Optional.is(Struct.getIfType(config, "compareEvents", Callable))
    ? method(this, config.compareEvents)
    : function(a, b) {
      return a.timestamp <= b.timestamp
    }

  ///@private
  ///@type {Array<TrackEvent>}
  events = new Array(TrackEvent, GMArray.createGMArray(GMArray.size(Struct.getIfType(json, "events", GMArray, [ ]))))
  //events = new Array(TrackEvent)
  /*
  events = GMArray
    .toArray(
      Struct.getIfType(json, "events", GMArray, [ ]), 
      TrackEvent, 
      this.parseEvent,
      Struct.set((Core.isType(config, Struct) ? config : { }),
        "__channelName", this.name)
    ).sort(compareEvents)
  */

  ///@type {Task}
  var channel = this
  task = new Task("parse-track-channel")
    .setPromise(Struct.getIfType(config, "promise", Promise, null))
    .setState({
      channel: channel,
      config: Struct.set((Core.isType(config, Struct) ? config : { }), "__channelName", channel.name),
      index: 0,
      events: Struct.getIfType(json, "events", GMArray, [ ]),
      parseEvent: channel.parseEvent,
      compareEvents: channel.compareEvents,
    })
    .whenUpdate(function() {
      var size = GMArray.size(this.state.events)
      if (!Struct.getIfType(this.state.config, "parseAsync", Boolean, false)) {
        GMArray.forEach(this.state.events, function(entry, index, state) {
          state.channel.events.set(index, state.parseEvent(entry, index, state.config))
          state.index = index + 1
        }, this.state)
        this.state.channel.events.sort(this.state.compareEvents)
        this.fullfill()
      } else if (this.state.index < size) {
        var step = Struct.getIfType(this.state.config, "parseTrackEventStep", Number, 32)
        for (var idx = this.state.index; idx < clamp(min(idx + step, size), 0, size); idx++) {
          //this.state.channel.events.add(this.state.parseEvent(this.state.events[idx], idx, this.state.config))
          this.state.channel.events.set(idx, this.state.parseEvent(this.state.events[idx], idx, this.state.config))
          this.state.index = idx + 1
        }
      } else {
        this.state.channel.events.sort(this.state.compareEvents)
        this.fullfill()
      }
    })

  ///@type {Struct}
  settings = this.parseSettings(Struct.getIfType(json, "settings", Struct))

  ///@param {TrackEvent} event
  ///@return {TrackChannel}
  add = Optional.is(Struct.getIfType(config, "add", Callable))
    ? method(this, config.add)
    : function(event) {
      var size = this.events.size()
      for (var index = 0; index < size; index++) {
        if (event.timestamp < this.events.get(index).timestamp) {
          break
        }
      }
      
      var lastExecutedEvent = this.pointer != null ? this.events.get(this.pointer) : null
      this.events.add(event, index)
      if (lastExecutedEvent == null) {
        return this
      }

      size = this.events.size()
      for (var index = 0; index < size; index++) {
        if (this.events.get(index) == lastExecutedEvent) {
          this.pointer = index
          break
        }
      }

      return this
    }

  ///@param {TrackEvent} event
  ///@return {TrackChannel}
  remove = Optional.is(Struct.getIfType(config, "remove", Callable))
    ? method(this, config.remove)
    : function(event) {
      if (this.events.size() == 0) {
        return this
      }

      var size = this.events.size()
      for (var index = 0; index < size; index++) {
        if (this.events.get(index) == event) {
          break
        }

        if (index == this.events.size() - 1) {
          Logger.warn("TrackChannel", $"TrackEvent wasn't found. channel: '{this.name}'")
          return this
        }
      }

      var lastExecutedEvent = this.pointer != null ? this.events.get(this.pointer) : null
      var trackEvent = this.events.get(index)
      this.events.remove(index)
      //Logger.debug("TrackChannel", $"TrackEvent removed: channel: '{this.name}', timestamp: {trackEvent.timestamp}, callable: '{trackEvent.callableName}'")
      if (this.pointer == null) {
        return this
      }

      if (lastExecutedEvent == event) {
        this.pointer = this.pointer == 0 ? null : this.pointer - 1
      } else {
        size = this.events.size()
        for (var index = 0; index < size; index++) {
          if (this.events.get(index) == lastExecutedEvent) {
            this.pointer = index
            break
          }
        }
      }
      return this
    }

  ///@param {Number} timestamp
  ///@return {TrackChannel}
  rewind = Optional.is(Struct.getIfType(config, "rewind", Callable))
    ? method(this, config.rewind)
    : function(timestamp) {
      var size = this.events.size()
      this.pointer = null
      this.time = timestamp
      for (var index = 0; index < size; index++) {
        this.pointer = index
        if (this.events.get(index).timestamp >= timestamp) {
          this.pointer = index == 0 ? null : index - 1
          break
        }
      }

      return this
    }

  ///@param {TrackChannel} trackChannel
  ///@param {Event} event
  executeEventCallable = Optional.is(Struct.getIfType(config, "executeEventCallable", Callable))
    ? method(this, config.executeEventCallable)
    : function(event, trackChannel) {
      event.callable(event.parseData(event.data), trackChannel)
    }

  ///@param {Number} timestamp
  ///@return {TrackChannel}
  update = Optional.is(Struct.getIfType(config, "update", Callable))
    ? method(this, config.update)
    : function(timestamp) {
      if (this.time > timestamp) {
        this.rewind(timestamp)
      }
      this.time = timestamp

      var size = events.size()
      if (size == 0) {
        return this
      }

      for (var index = 0; index < this.MAX_EXECUTION_PER_FRAME; index++) {
        var pointer = this.pointer == null ? 0 : (this.pointer + 1)
        if (pointer == size) {
          break
        }

        var event = events.get(pointer)
        if (timestamp < event.timestamp) {
          continue
        }
        
        this.pointer = pointer
        if (this.muted) {
          continue
        }

        //Logger.debug("Track", $"(channel: '{this.name}', timestamp: {timestamp}) dispatch event: '{event.callableName}'")
        this.executeEventCallable(event, this)
      }

      return this
    }

  ///@return {Struct}
  serialize = Optional.is(Struct.getIfType(config, "serialize", Callable))
    ? method(this, config.serialize)
    : function() {
      return {
        "name": this.name,
        "events": this.events.map(function(event) {
          return event.serialize()
        }).getContainer(),
        "settings": Core.isType(Struct.get(this.settings, "serialize"), Callable) 
          ? this.settings.serialize() 
          : this.settings,
      }
    }
}


///@param {Struct} json
///@param {?Struct} [config]
function TrackEvent(json, config = null): Event("TrackEvent") constructor {

  ///@type {?String}
  uid = Struct.getIfType(json, "uid", String)

  ///@override
  ///@type {Struct}
  data = Struct.getIfType(json, "data", Struct, { })

  ///@type {Number}
  timestamp = abs(Assert.isType(Struct.get(json, "timestamp"), Number))

  ///@type {String}
  callableName = Struct.getIfType(json, "callable", String, "dummy")

  var handler = Struct.getIfType(config, "handlers", Map, DEFAULT_TRACK_EVENT_HANDLERS)
    .get(this.callableName)

  ///@type {Callable}
  callable = Struct.getIfType(handler, "run", Callable, Lambda.dummy)

  ///@type {Callable}
  parseData = Struct.getIfType(handler, "parse", Callable, Lambda.passthrough)

  ///@type {Struct}
  parsedData = null

  ///@type {Callable}
  serializeData = Struct.getIfType(handler, "serialize", Callable, Struct.serialize)
  
  ///@return {Struct}
  serialize = method(this, Struct.getIfType(config, "serialize", Callable, function() {
    return {
      "timestamp": this.timestamp,
      "callable": this.callableName,
      "data": this.serializeData(this.data),
    }
  }))
}
