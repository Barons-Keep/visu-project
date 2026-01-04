///@package io.alkapivo.core.service.sound

#macro GMAudioGroupID "GMAudioGroupID"

#macro BeanSoundService "SoundService"
function SoundService() constructor {

  ///@type {Map<String, GMSound>}
  sounds = new Map(String, GMSound)

  ///@type {Map<String, SoundIntent>}
  intents = new Map(String, SoundIntent)

  ///@type {Map<String, GMAudioGroupID>}
  audioGroups = new Map(String, GMAudioGroupID)

  ///@param {GMAudioGroupID}
  ///@return {Boolean}
  loadAudioGroup = function(audioGroupId) {
    if (!Core.isType(audioGroupId, GMAudioGroupID)) {
      return false
    }

    var name = audio_group_name(audioGroupId)
    if (!Core.isType(name, String)) {
      return false
    }

    if (!audio_group_is_loaded(audioGroupId)) {
      var response = audio_group_load(audioGroupId)
      if (response) {
        this.audioGroups.set(name, audioGroupId)    
      }
      return response
    }
    
    this.audioGroups.set(name, audioGroupId)
    return true
  }

  ///@param {GMAudioGroupID}
  ///@return {SoundService}
  unloadAudioGroup = function(audioGroupId) {
    if (!Core.isType(audioGroupId, GMAudioGroupID)) {
      return this
    }

    var name = audio_group_name(audioGroupId)
    if (!Core.isType(name, String)) {
      return this
    }

    if (audio_group_is_loaded(audioGroupId)) {
      var res = audio_group_unload(audioGroupId)
      res = audio_group_unload(audioGroupId)
    }
    this.audioGroups.remove(name)

    return this
  }

  ///@param {String} name
  ///@param {String} path
  ///@param {?SoundIntent} [intent]
  ///@return {SoundService}
  loadOGG = function(name, path, intent = null) {
    Logger.debug(BeanSoundService, $"Load OGG sound '{name}'\n{path}")
    var stream = audio_create_stream(path)
    this.sounds.add(stream, name)

    var soundIntent = Core.isType(intent, SoundIntent)
      ? intent
      : new SoundIntent({ file: path })
    this.intents.add(soundIntent, name)

    return this
  }

  ///@param {String} name
  ///@return {SoundService}
  freeOGG = function(name) {
    var sound = this.sounds.get(name)
    if (Core.isType(sound, GMSound)) {
      Logger.debug(BeanSoundService, $"Free ogg sound '{name}'")
      audio_destroy_stream(sound)
      this.sounds.remove(name)
    }

    var intent = this.intents.get(name)
    if (Core.isType(intent, SoundIntent)) {
      this.intents.remove(name)
    }
    
    return this
  }

  ///@return {SoundService}
  update = function() {
    return this
  }

  ///@param {?Map<String, Boolean>} [staticSounds]
  ///@return {SoundService}
  free = function(staticSounds = null) {
    this.sounds.forEach(function(sound, name, staticSounds) {
      try {
        if (staticSounds != null && staticSounds.get(name) == true) {
          Logger.debug("SoundService", $"Keep sound '{name}'")
          return
        }
        Logger.debug("SoundService", $"Free sound '{name}'")
        audio_destroy_stream(sound)
      } catch (exception) {
        Logger.error("SoundService", $"Free sound '{name}' exception: {exception.message}")
        Core.printStackTrace().printException(exception)
      }
    }, staticSounds)

    this.sounds.keys()
      .filter(function(key, idx, staticSounds) {
        return staticSounds == null || staticSounds.get(key) != true
      }, staticSounds)
      .forEach(function(key, idx, sounds) {
        sounds.remove(key)
      }, this.sounds)

    this.audioGroups.forEach(function(audioGroupId, name) {
      try {
        Logger.debug("SoundService", $"Free audioGroupId '{name}'")
        this.unloadAudioGroup(audioGroupId)
      } catch (exception) {
        Logger.error("SoundService", $"Free audioGroupId '{name}' exception: {exception.message}")
        Core.printStackTrace().printException(exception)
      }
    }, staticSounds).clear()

    this.intents.keys()
      .filter(function(key, idx, staticSounds) {
        return staticSounds == null || staticSounds.get(key) != true
      }, staticSounds)
      .forEach(function(key, idx, intents) {
        intents.remove(key)
      }, this.intents)
    return this
  }
}

