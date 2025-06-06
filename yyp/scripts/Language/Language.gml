///@package io.alkapivo.core.util

///@enum
function _LanguageType(): Enum() constructor {
  en_EN = "en_EN"
  pl_PL = "pl_PL"
}
global.__LanguageType = new _LanguageType()
#macro LanguageType global.__LanguageType


///@param {Struct} json
function LanguagePack(json) constructor {

  ///@type {String}
  code = Assert.isType(json.code, String)

  ///@private
  ///@type {Map<String, String>}
  labels = new Map(String, String)
  if (Core.isType(Struct.get(json, "labels"), Struct)) {
    Struct.forEach(json.labels, function(value, key, labels) {
      Logger.debug("LanguagePack", $"Load label {key}")
      labels.set(key, value)
    }, this.labels)
  }
}


///@static
function _Language() constructor {

  ///@type {?LanguagePack}
  pack = null

  ///@param {String} code
  ///@return {Language}
  load = function(code) {
    var path = null
    switch (code) {
      case LanguageType.en_EN: path = $"{working_directory}lang/en_EN.json" break
      case LanguageType.pl_PL: path = $"{working_directory}lang/pl_PL.json" break
      default: path = $"{working_directory}lang/en_EN.json" break
    }
    
    var json = FileUtil.readFileSync(FileUtil.get(path)).getData()
    JSON.parserTask(json, {
      acc: this,
      callback: function(prototype, json, index, acc) {
        Language.pack = Assert.isType(new prototype(json), LanguagePack,
          "Language.pack must be type of LanguagePack")
      },
    }).update()

    return this
  }

  ///@type {String} key
  ///@type {any} [...params]
  ///@return {String}
  get = function(key/*, ...params */) {
    if (!Core.isType(this.pack, LanguagePack)) {
      return ""
    }

    var label = this.pack.labels.get(key)
    if (!Core.isType(label, String)) {
      return ""
    }

    if (argument_count > 1) {
      for (var index = 1; index < argument_count; index++) {
        label = String.replaceAll(label, "{" + string(index - 1) + "}", argument[index])
      }
    }

    return label
  }

  ///@return {LanguageType}
  getCode = function() {
    if (!Core.isType(this.pack, LanguagePack)) {
      return LanguageType.en_EN
    }

    return this.pack.code
  }
}
global.__Language = new _Language()
#macro Language global.__Language
