///@package io.alkapivo.core.util

///@param {Test} test
///@return {Task}
function Test_NumberTransformer_Ease(test) {
  var json = Struct.get(test, "data")
  return new Task("Test_NumberTransformer_Ease")
    .setTimeout(Struct.getIfType(json, "timeout", Number, 90.0))
    .setPromise(new Promise())
    .setState({
      description: test.description,
      transformer: null,
      transformers: new Queue(Struct, Struct.getIfType(json, "transformers", GMArray, [
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_SINE,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.OUT_SINE,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_OUT_SINE,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_QUAD,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.OUT_QUAD,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_OUT_QUAD,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_CUBIC,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.OUT_CUBIC,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_OUT_CUBIC,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_QUART,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.OUT_QUART,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_OUT_QUART,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_QUINT,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.OUT_QUINT,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_OUT_QUINT,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_EXPO,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.OUT_EXPO,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_OUT_EXPO,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_CIRC,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.OUT_CIRC,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_OUT_CIRC,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_BACK,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.OUT_BACK,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_OUT_BACK,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_ELASTIC,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.OUT_ELASTIC,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_OUT_ELASTIC,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_BOUNCE,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.OUT_BOUNCE,
        },
        {
          value: 0.0,
          target: 1.0,
          duration: 2.0,
          ease: EaseType.IN_OUT_BOUNCE,
        }
      ])),
    })
    .whenUpdate(function(executor) {
      if (!Optional.is(this.state.transformer)) {
        if (this.state.transformers.size() > 0.0) {
          var transformer = Assert.isType(this.state.transformers.pop(), Struct, "this.state.transformers.pop() must return a Struct value")
          this.state.transformer = new NumberTransformer(transformer)
        } else {
          return this.fullfill()
        }
      }

      if (Optional.is(this.state.transformer) 
          && !this.state.transformer.finished 
          && this.state.transformer.update().finished) {
        var report = JSON.stringify({
          startValue: this.state.transformer.startValue,
          target: this.state.transformer.target,
          time: this.state.transformer.time,
          duration: this.state.transformer.duration,
          easeType: this.state.transformer.easeType,
        }, { pretty: true })

        Logger.test("Test_NumberTransformer_Ease", $"Result:\n{report}\n")
        this.state.transformer = null
      }
    })
    .whenStart(function(executor) {
      Logger.test(BeanTestRunner, $"Test_NumberTransformer_Ease started. Description: {this.state.description}")
      Beans.get(BeanTestRunner).installHooks()
    })
    .whenFinish(function(data) {
      Logger.test(BeanTestRunner, $"Test_NumberTransformer_Ease finished. Description: {this.state.description}")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
    .whenTimeout(function() {
      Logger.test(BeanTestRunner, $"Test_NumberTransformer_Ease timeout. Description: {this.state.description}")
      this.reject("failure")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
}