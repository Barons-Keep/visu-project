///@package io.alkapivo.visu.service.grid

///@param {Struct} json
function GridItemFeature(json) constructor {

  ///@private
  ///@param {Struct} condition
  ///@return {GridItemCondition}
  static parseCondition = function(condition) {
    return new GridItemCondition(condition)
  }

  ///@type {String}
  type = "GridItemFeature"
  
  ///@type {?Array<GridItemCondition>}
  conditions = Struct.contains(json, "conditions")
    ? new Array(GridItemCondition, GMArray.map(json.conditions, parseCondition))
    : null

  ///@type {?Timer}
  timer = Struct.getIfType(json, "timer", Number) != null
    ? new Timer(json.timer, { loop: Infinity }) 
    : null

  ///@return {Boolean}
  static checkConditions = function(gridItem, controller) {
    gml_pragma("forceinline")
    if (this.conditions == null) {
      return true
    }

    var size = this.conditions.size()
    for (var index = 0; index < size; index++) { 
      if (!this.conditions.get(index).check(gridItem, controller)) {
        return false
      }
    }

    return true
  }

  ///@return {Boolean}
  static updateTimer = function() {
    gml_pragma("forceinline")
    return this.timer == null ? true : this.timer.update().finished
  }

  ///@param {GridItem} gridItem
  ///@param {VisuController} controller
  static update = function(gridItem, controller) { }
}
