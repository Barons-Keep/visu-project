///@description __context

	///@type {?Struct}
	__context = null
  
  ///@type {?Callable}
	__free = null
  
  ///@type {?String}
  __bean = null

  ///@return {Boolean}
  enabled = function() {
    return Struct.getDefault(this.__context, "enabled", true) != false
  }