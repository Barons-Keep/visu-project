///@package io.alkapivo.Basil.util.FSM
///@description FSM stands for Finite-state fsm


///@param {String} _name
///@param {Struct} [config]
function FSMState(_name, config = {}) constructor {

  ///@type {String}
  name = Assert.isType(_name, String, "FSMState::name must be type of String")

  ///@private
  ///@return {Map<String, any>}
  defaultFactoryState = function() { 
    return new Map(String, any)
  }

  ///@private
  ///@param {FSM} fsm
  ///@return {FSMState}
  defaultUpdate = function(fsm) {
    return this
  }

  ///@private
  ///@return {Map<String, any>}
  factoryState = method(this, Struct.getIfType(config, "factoryState", Callable, this.defaultFactoryState))

  ///@type {Map<String, any>}
  state = Assert.isType(this.factoryState(), Map, "FSMState::state must be type of Map")
  
  ///@type {Callable}
  update = method(this, Struct.getIfType(config, "update", Callable, this.defaultUpdate))

  ///@type {Map<String, Callable>}
  actions = Assert.isType(Struct.contains(config, "actions")
      ? Struct.toMap(Struct.get(config, "actions"), String, Callable)
      : new Map(String, Callable), 
    Map)
  
  ///@type {Map<String, ?Callable>}
  transitions = Assert.isType(Struct.contains(config, "transitions")
      ? Struct.toMap(Struct.get(config, "transitions"), String, Optional.of(Callable))
      : new Map(String, Optional.of(Callable)), 
    Map)
}

///@param {Struct} _context
///@param {Struct} config
function FSM(_context, config) constructor {

  ///@private
  ///@type {Struct}
  context = Assert.isType(_context, Struct)

  ///@private
  ///@type {Struct}
  initialState = Assert.isType(Struct.get(config, "initialState"), Struct)
  Assert.isType(Struct.get(this.initialState, "name"), String)

  ///@type {String}
  displayName = Core.isType(Struct.get(config, "displayName"), String)
    ? $"FSM::{config.displayName}" 
    : "FSM"

  ///@type {?FSMState}
  currentState = null

  ///@type {Map<String, Struct>}
  states = Assert.isType(Struct.contains(config, "states") 
      ? Struct.toMap(Struct.get(config, "states"), String, Struct) 
      : new Map(String, Struct), 
    Map)

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "transition": function(event) {
      var name = Struct.get(event.data, "name") 
      var data = Struct.get(event.data, "data")
      this.transition(name, data)
    },
  }))

  ///@return {FSM}
  update = function() {
    if (!Core.isType(this.currentState, FSMState)) {
      this.dispatcher.send(new Event("transition", {
        name: this.initialState.name,
        data: Struct.get(this.initialState, "data"),
      }))
    } else {
      this.currentState.update(this)
    }

    this.dispatcher.update()
    return this
  }

  ///@private
  ///@param {String} name
  ///@param {any} [data]
  ///@return {FSM}
  transition = function(name, data = null) {
    var targetState = new FSMState(name, this.states.get(name))
    if (Core.isType(this.currentState, FSMState)) {
      if (!this.currentState.transitions.contains(name)) {
        var message = $"Transition from '{this.currentState.name}' to '{name}' is not supported"
        Logger.warn(this.displayName, message)
        return this
      }
      
      if (this.currentState.actions.contains("onFinish")) {
        Callable.run(this.currentState.actions.get("onFinish"), 
          this, this.currentState, data)
      }
      Callable.run(this.currentState.transitions.get(name), 
        this, this.currentState, data)
    }

    var from = this.currentState != null ? this.currentState.name : "null"
    this.currentState = targetState
    
    Logger.info(this.displayName, $"Transition from '{from}' to '{this.currentState.name}'")

    if (targetState.actions.contains("onStart")) {
      Callable.run(targetState.actions.get("onStart"), 
        this, targetState, data)
    }

    return this
  }

  ///@return {?String}
  getStateName = function() {
    return Core.isType(this.currentState, FSMState)
      ? this.currentState.name
      : null
  }
}