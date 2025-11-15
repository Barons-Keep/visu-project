///@package io.alkapivo.core.test

#macro BeanTestRunner "TestRunner"
function TestRunner() constructor {

  ///@type {?TestSuite}
  testSuite = null

  ///@type {?Struct}
  report = null

  ///@type {Queue<TestSuite>}
  testSuites = new Queue(TestSuite)
  
  ///@type {Stack<Struct>}
  exceptions = new Stack(Struct)

  ///@type {Map<String, Callable>}
  restoreHooks = new Map(String, Callable)

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this, { 
    enableLogger: true,
    catchException: true,
    exceptionCallback: function(task, exception) {
      task.status = TaskStatus.REJECTED
    },
    loggerPrefix: BeanTestRunner,
  })

  ///@return {TestRunner}
  installHooks = function() {
    this.restoreHooks.set("Logger.error", method(this, Logger.error))
    Logger.info(BeanTestRunner, "install hook 'Logger.error'")
    Logger.error = function(context, message) {
      Logger.log(context, "ERROR ", message)

      var runner = Beans.get(BeanTestRunner)
      if (!Core.isType(runner, TestRunner)) {
        return
      }

      runner.exceptions.push({
        timestamp: string(current_year) + "-"
          + string(string_replace(string_format(current_month, 2, 0), " ", "0")) + "-"
          + string(string_replace(string_format(current_day, 2, 0), " ", "0")) + " "
          + string(string_replace(string_format(current_hour, 2, 0), " ", "0")) + ":"
          + string(string_replace(string_format(current_minute, 2, 0), " ", "0")) + ":"
          + string(string_replace(string_format(current_second, 2, 0), " ", "0")),
        context: context,
        message: message,
      })
    }
    
    return this
  }

  ///@return {TestRunner}
  uninstallHooks = function() {
    Logger.info(BeanTestRunner, "uninstall hook 'Logger.error'")
    var hook = this.restoreHooks.get("Logger.error")
    if (Core.isType(Logger, Struct) && Core.isType(hook, Callable))  {
      Logger.error = method(Logger, hook)
    }

    return this
  }

  ///@return {Struct}
  factoryReport = function() {
    var unixTimestamp = Core.getCurrentUnixTimestamp()
    return {
      results: {
        tool: {
          "name": "io.alkapivo.core.test.TestRunner"
        },
        summary: {
          "tests": 0,
          "passed": 0,
          "failed": 0,
          "pending": 0,
          "skipped": 0,
          "other": 0,
          "start": unixTimestamp,
          "stop": unixTimestamp,
        },
        tests: [],
        environment: {
          "appName": game_display_name,
        }
      }
    }
  }

  ///@param {String} path
  ///@return {TestRunner}
  push = function(path) {
    var context = this
    var json = FileUtil.readFileSync(path).getData()
    var task = JSON.parserTask(json, {
      callback: function(prototype, json, index, acc) {
        var testSuite = new prototype(json)
        acc.testSuites.push(testSuite)
      },
      acc: context,
      model: "io.alkapivo.core.test.TestSuite",
    })
    
    if (task != null) {
      task.update()
    }

    return this
  }

  ///@private
  ///@return {TestRunner}
  saveReport = function() {
    if (this.testSuite == null || this.report == null) {
      return
    }

    this.testSuite.results.forEach(function(result, idx, runner) {
      var report = runner.report
      report.results.summary.tests++
      report.results.summary.stop = Core.getCurrentUnixTimestamp()
      var status = "skipped"
      switch (result.promise.status) {
        case PromiseStatus.FULLFILLED:
          status = "passed"
          report.results.summary.passed++
          break
        case PromiseStatus.REJECTED:
          status = "failed"
          report.results.summary.failed++
          break
        default:
          status = "skipped"
          report.results.summary.skipped++
          break
      }

      GMArray.add(report.results.tests, {
        name: result.name,
        status: status,
        duration: result.duration,
      })
    }, this)

    FileUtil.writeFileSync(new File({
      path: FileUtil.get($"{working_directory}ctrf-report.json"),
      data: JSON.stringify(this.report, { pretty: true })
    }))

    return this
  }

  ///@private
  ///@return {TestRunner}
  shutdown = function() {
    Logger.info(BeanTestRunner, "Shutdown")
    game_end()
    return this
  }

  ///@return {TestRunner}
  update = function() {
    if (this.testSuite == null && this.testSuites.size() > 0) {
      this.testSuite = this.testSuites.pop()
    }

    if (this.testSuite == null) {
      return this
    }

    if (this.report == null) {
      this.report = this.factoryReport()
    }

    try {
      this.executor.update()
      this.testSuite.update(this.executor)
      if (!this.testSuite.finished) {
        return this
      }

      this.saveReport()
      this.testSuite = null
    } catch (exception) {
      Logger.error("TestRunner::update", $"Exception: {exception.message}")
      Core.printStackTrace()
      try {
        this.saveReport()
        this.testSuite = null
        var size = testSuites.size()
        for (var idx = 0; idx < size; idx++) {
          this.testSuite = this.testSuites.pop()
          this.saveReport()
          this.testSuite = null
        }
      } catch (ex) {
        Logger.error("TestRunner::update", $"Unable to save test results: {ex.message}")
        Core.printStackTrace()
      }

      this.shutdown()
    }

    if (this.testSuites.size() == 0) {
      this.shutdown()
    }

    return this
  }
  
  ///@return {TestRunner}
  free = function() {
    this.uninstallHooks()
    return this
  }
}
