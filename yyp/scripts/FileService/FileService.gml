///@package io.alkapivo.core.service.file

#macro BeanFileService "FileService"
///@param {Struct} config
function FileService(config = {}): Service() constructor {

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "fetch-file": function(event) {
      var task = new Task("fetch-file-buffer")
        .setPromise(event.promise) // pass promise to TaskExecutor
        .setState(new Map(String, any, { 
          path: Assert.isType(event.data.path, String)
        }))
        .whenUpdate(function(executor) {
          var path = this.state.get("path")
          var buffer = BufferUtil.loadAsTextBuffer(path)
          var data = buffer.get()
          buffer.free()
          Logger.info("FileService", $"FetchFileBuffer successfully: {path}")
          this.fullfill(new File({ path: path, data: data }))
        })
      
      this.executor.add(task)
      event.setPromise() // disable promise in EventPump, the promise will be resolved within TaskExecutor
    },
    "fetch-file-dialog": function(event) {
      var path = FileUtil.getPathToOpenWithDialog(event.data)
      if (!Core.isType(path, String) || String.isEmpty(path)) {
        var promise = event.promise
        if (Core.isType(event.promise, Promise)) {
          event.setPromise()
          promise.reject()
        }
        return
      }

      this.send(new Event("fetch-file")
        .setPromise(event.promise)
        .setData({ path: path }))
      event.setPromise() // disable promise in EventPump, the promise will be resolved within TaskExecutor
    },
    "fetch-file-sync": function(event) {
      return FileUtil.readFileSync(event.data.path)
    },
    "fetch-file-sync-dialog": function(event) {
      var path = FileUtil.getPathToOpenWithDialog(event.data)
      if (!Core.isType(path, String) || String.isEmpty(path)) {
        var promise = event.promise
        if (Core.isType(event.promise, Promise)) {
          event.setPromise()
          promise.reject()
        }
        return
      }

      this.send(new Event("fetch-file-sync")
        .setPromise(event.promise)
        .setData({ path: path }))
      event.setPromise() // disable promise in EventPump, the promise will be resolved within TaskExecutor
    },
    "save-file-sync": function(event) {
      FileUtil.writeFileSync(Assert.isType(event.data, File))
    },
  }), Core.isType(Struct.get(config, "dispatcher"), Struct) ? config.dispatcher : {})

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this)

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    Struct.set(event.data, "fileService", this)
    return this.dispatcher.send(event)
  }

  ///@return {FileService}
  update = function() {
    this.dispatcher.update()
    this.executor.update()
    return this
  }
}
