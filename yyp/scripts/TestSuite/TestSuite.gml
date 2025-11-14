///@package io.alkapivo.core.test

///@param {Struct} [json]
function TestSuite(json = {}) constructor {
  
  ///@type {String}
  name = Struct.getIfType(json, "name", String, "Undefined test suite")

  ///@type {Boolean}
  stopAfterFailure = Struct.getIfType(json, "stopAfterFailure", Boolean, false)

  ///@type {Boolean}
  finished = false

  ///@type {Array<Test>}
  tests = new Array(Test, GMArray.map(Struct.getIfType(json, "tests", GMArray, []), function(json) {
    return new Test(json)
  }))

  ///@type {Array<Struct>}
  results = this.tests.map(function(test, idx, testSuite) {
    return {
      name: $"{test.handler}: {test.description}",
      promise: { status: PromiseStatus.PENDING },
      duration: 0,
      _start: 0,
      _stop: 0,
    }
  }, this, Struct)

  ///@private
  ///@type {Number}
  testsPointer = 0

  ///@private
  ///@type {Number}
  resultsPointer = 0

  ///@param {TaskExecutor}
  ///@return {TestSuite}
  update = function(executor) {
    if (this.finished) {
      return this
    }

    if (this.testsPointer >= this.tests.size()) {
      this.finished = true
      return this
    }

    var unixTimestamp = Core.getCurrentUnixTimestamp()
    var result = this.results.get(this.testsPointer)
    if (this.testsPointer == this.resultsPointer) {
      var test = this.tests.get(this.testsPointer)
      var task = Assert.isType(Callable.run(test.handler, Struct.get(test, "data")),
        Task, "TestSuite.update task must be type of task")
      executor.add(task)
      result.promise = task.promise
      result._start = unixTimestamp
      result._stop = unixTimestamp
      this.resultsPointer++
    } else {
      result._stop = unixTimestamp
      result.duration = result._stop - result._start
      switch (result.promise.status) {
        case PromiseStatus.REJECTED:
          this.finished = this.stopAfterFailure ? true : this.finished
          this.testsPointer++
          break
        case PromiseStatus.FULLFILLED:
          this.testsPointer++
          break
      }
    }

    return this
  }
}
