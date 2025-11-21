///@package io.alkapivo.test.core.collection

///@param {Test} test
///@return {Task}
function Test_Grid(test) {
  var json = Struct.get(test, "data")
  return new Task("Test_Grid")
    .setTimeout(Struct.getDefault(json, "timeout", 3.0))
    .setPromise(new Promise())
    .setState({
      description: test.description,
    })
    .whenUpdate(function(executor) {
      this.fullfill("success")
    })
    .whenStart(function(executor) {
      Logger.test(BeanTestRunner, $"Test_Grid started.\nDescription: {this.state.description}")
      Beans.get(BeanTestRunner).installHooks()
    })
    .whenFinish(function(data) {
      Logger.test(BeanTestRunner, $"Test_Grid finished.\nDescription: {this.state.description}")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
    .whenTimeout(function() {
      Logger.test(BeanTestRunner, $"Test_Grid timeout.\nDescription: {this.state.description}")
      this.reject("failure")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
}
