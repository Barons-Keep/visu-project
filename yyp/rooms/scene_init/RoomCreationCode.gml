Core.print("Init scene_init")

GMObjectUtil.factoryStructInstance(
	GMServiceInstance, 
	Scene.fetchLayer("instance_main", 100),
	{
	  timer: new Timer(0.5, { 
	    callback: function() {
	      Scene.open("scene_visu")
	    }
	  }),
	  update: function() {
			DeltaTime.deltaTime = 1.0
	    this.timer.update()
	  }
	}
)

/*
GMObjectUtil.factoryStructInstance(
	GMServiceInstance, 
	Scene.fetchLayer("instance_main", 100),
	{
    buffer: new BufferTest(),
	  update: function() {
      if (!this.buffer.growing) {
        Scene.open("scene_visu")
      }

			this.buffer.update()

      return this
	  },
	}
)
*/