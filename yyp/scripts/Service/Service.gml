///@package io.alkapivo.core.service

///@interface
///param {?Struct} [config]
function Service(config = null) constructor {

  ///@type {Boolean}
  enabled = Struct.getIfType(config, "enabled", Boolean, true)

  ///@param {Boolean} isEnabled
  ///@return {SceneController}
  enable = Optional.is(Struct.getIfType(config, "enable", Callable))
    ? method(this, config.enable)
    : function(isEnabled) {
      this.enabled = isEnabled
      return this
    }

  ///@return {Service}
  updateBegin = Optional.is(Struct.getIfType(config, "updateBegin", Callable))
    ? method(this, config.updateBegin)
    : function() {
      return this
    }

  ///@return {Service}
  update = Optional.is(Struct.getIfType(config, "update", Callable))
    ? method(this, config.update)
    : function() {
      return this
    }

  ///@return {Service}
  free = Optional.is(Struct.getIfType(config, "free", Callable))
    ? method(this, config.free)
    : function() {
      return this
    }
}
