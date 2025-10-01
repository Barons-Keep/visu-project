///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json 
function KillFeature(json): GridItemFeature(json) constructor {

  ///@override
  ///@type {String}
  type = "KillFeature"

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    item.signal("kill")
  }
}
