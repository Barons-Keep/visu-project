///@description __context.onSocialEvent()

	if (this.__onSocialEvent != null && this.enabled()) {
		var json = {
			type: async_load[? "type"],
		}

		this.__onSocialEvent(json)
	}
  
