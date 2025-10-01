///@description __context.onSocialEvent()

	if (this.__onSocialEvent != null) {
		var json = {
			type: async_load[? "type"],
		}

		this.__onSocialEvent(json)
	}
  
