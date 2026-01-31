///@package io.alkapivo.core.service.file

#macro BeanFileService "FileService"
///@param {?Struct} [config]
function FileService(config = null): Service(config) constructor {

  ///@private
  ///@type {Boolean}
  skipBufferDispatch = false

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open-file": function(event) {
      var path = Assert.isType(Struct.get(event.data, "path"), String, "open-file: event.data.path must be type of String")
      var task = new Task("open-file-buffer")
        .setTimeout(60.0)
        .setPromise(event.promise) // pass promise to TaskExecutor
        .setState({ 
          context: Assert.isType(Struct.get(event.data, BeanFileService), FileService, $"open-file: event.data.{BeanFileService} must be type of FileService"),
          path: path,
          buffer: null,
          requestId: null,
          status: null,
          stage: "init",
          stages: {
            init: function(task) {
              if (task.state.context.skipBufferDispatch) {
                return
              }

              task.state.buffer = new TextBuffer({ type: BufferType.GROW })
              task.state.requestId = buffer_load_async(task.state.buffer.asset, task.state.path, 0, -1)
              task.state.stage = "wait"
              task.state.skipBufferDispatch = true
            },
            wait: function(task) {
              if (task.state.context.skipBufferDispatch) {
                return
              }

              var status = task.state.status
              if (!Optional.is(status)) {
                return
              }

              var path = task.state.path
              var data = task.state.buffer.get()
              if (status) {
                Logger.info(BeanFileService, $"open-file-buffer: success\n{path}")
                task.fullfill(new File({ path: path, data: data }))
              } else {
                Logger.warn(BeanFileService, $"open-file-buffer: failure, status: {status}\n{path}")
                task.reject()
              }
            },
          },
        })
        .whenUpdate(function() {
          var stage = Struct.get(this.state.stages, this.state.stage)
          stage(this)
        })
        .whenFinish(function() {
          var path = this.state.path
          Logger.info(BeanFileService, $"open-file-buffer: free\n{path}")
          this.state.buffer.free()
        })

      this.executor.add(task)
      event.setPromise() // disable promise in EventPump, the promise will be resolved within TaskExecutor
    },
    "open-file-dialog": function(event) {
      var path = FileUtil.getPathToOpenWithDialog(event.data)
      if (!Core.isType(path, String) || String.isEmpty(path)) {
        var promise = event.promise
        if (Core.isType(event.promise, Promise)) {
          event.setPromise()
          promise.reject()
        }
        return
      }

      this.send(new Event("open-file")
        .setPromise(event.promise)
        .setData({ path: path }))
      event.setPromise() // disable promise in EventPump, the promise will be resolved within TaskExecutor
    },
    "open-file-sync": function(event) {
      return FileUtil.readFileSync(event.data.path)
    },
    "open-file-sync-dialog": function(event) {
      var path = FileUtil.getPathToOpenWithDialog(event.data)
      if (!Core.isType(path, String) || String.isEmpty(path)) {
        var promise = event.promise
        if (Core.isType(event.promise, Promise)) {
          event.setPromise()
          promise.reject()
        }
        return
      }

      this.send(new Event("open-file-sync")
        .setPromise(event.promise)
        .setData({ path: path }))
      event.setPromise() // disable promise in EventPump, the promise will be resolved within TaskExecutor
    },
    "save-file": function(event) {
      var file = Assert.isType(event.data, File, "save-file: event.data must be type of File")
      var path = file.getPath()
      var data = file.getData()
      var task = new Task("save-file-buffer")
        .setTimeout(60.0)
        .setPromise(event.promise) // pass promise to TaskExecutor
        .setState({
          context: Assert.isType(Struct.get(event.data, BeanFileService), FileService, $"save-file: event.data.{BeanFileService} must be type of FileService"),
          path: path,
          data: data,
          buffer: null,
          requestId: null,
          status: null,
          stage: "init",
          stages: {
            init: function(task) {
              if (task.state.context.skipBufferDispatch) {
                return
              }

              var size = String.size(task.state.data) 
              task.state.buffer = new TextBuffer({ size: size })
              task.state.buffer.add(task.state.data)
              task.state.requestId = buffer_save_async(task.state.buffer.asset, task.state.path, 0, size)
              task.state.stage = "wait"
              task.state.skipBufferDispatch = true
            },
            wait: function(task) {
              if (task.state.context.skipBufferDispatch) {
                return
              }

              var status = task.state.status
              if (!Optional.is(status)) {
                return
              }

              var path = task.state.path
              if (status) {
                Logger.info(BeanFileService, $"save-file-buffer: success\n{path}")
                task.fullfill()
              } else {
                Logger.warn(BeanFileService, $"save-file-buffer: failure\n{path}")
                task.reject()
              }
            },
          },
        })
        .whenUpdate(function() {
          var stage = Struct.get(this.state.stages, this.state.stage)
          stage(this)
        })
        .whenFinish(function(e) {
          var path = this.state.path
          Logger.info(BeanFileService, $"save-file-buffer: free\n{path}")
          this.state.buffer.free()
        })
    
      this.executor.add(task)
      event.setPromise() // disable promise in EventPump, the promise will be resolved within TaskExecutor
    },
    "save-file-sync": function(event) {
      FileUtil.writeFileSync(Assert.isType(event.data, File, "save-file-sync: event.data must be type of File"))
    },
  }), Core.isType(Struct.get(config, "dispatcher"), Struct) ? config.dispatcher : {})

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this)

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    Struct.set(event.data, BeanFileService, this)
    return this.dispatcher.send(event)
  }

  ///@return {FileService}
  update = function() {
    this.dispatcher.update()
    this.executor.update()
    this.skipBufferDispatch = false
    return this
  }

  ///@return {FileService}
  onSaveLoadEvent = function() {
    static filterByRequestId = function(task, iterator, requestId) {
      return task.state.requestId == requestId
    }

    var requestId = async_load[? "id"]
    if (!Optional.is(requestId)) {
      return this
    }

    var task = this.executor.tasks.find(filterByRequestId, requestId)
    if (!Optional.is(task)) {
      return this
    }

    var status = async_load[? "status"]
    switch (task.name) {
      case "open-file-buffer":
        task.state.status = status == 1
        break
      case "save-file-buffer":
        task.state.status = status != false
        break
      default:
        Logger.warn("FileService::onSaveLoadEvent", $"Found unsupported task '{task.name}', status: '{status}'")
        break
    }

    return this
  }
}
