///@package io.alkapivo.core.util

///@enum
function _EaseType(): Enum() constructor {
  LEGACY = "LEGACY"
  LINEAR = "LINEAR"
  IN_SINE = "IN_SINE"
  OUT_SINE = "OUT_SINE"
  IN_OUT_SINE = "IN_OUT_SINE"
  IN_QUAD = "IN_QUAD"
  OUT_QUAD = "OUT_QUAD"
  IN_OUT_QUAD = "IN_OUT_QUAD"
  IN_CUBIC = "IN_CUBIC"
  OUT_CUBIC = "OUT_CUBIC"
  IN_OUT_CUBIC = "IN_OUT_CUBIC"
  IN_QUART = "IN_QUART"
  OUT_QUART = "OUT_QUART"
  IN_OUT_QUART = "IN_OUT_QUART"
  IN_QUINT = "IN_QUINT"
  OUT_QUINT = "OUT_QUINT"
  IN_OUT_QUINT = "IN_OUT_QUINT"
  IN_EXPO = "IN_EXPO"
  OUT_EXPO = "OUT_EXPO"
  IN_OUT_EXPO = "IN_OUT_EXPO"
  IN_CIRC = "IN_CIRC"
  OUT_CIRC = "OUT_CIRC"
  IN_OUT_CIRC = "IN_OUT_CIRC"
  IN_BACK = "IN_BACK"
  OUT_BACK = "OUT_BACK"
  IN_OUT_BACK = "IN_OUT_BACK"
  IN_ELASTIC = "IN_ELASTIC"
  OUT_ELASTIC = "OUT_ELASTIC"
  IN_OUT_ELASTIC = "IN_OUT_ELASTIC"
  IN_BOUNCE = "IN_BOUNCE"
  OUT_BOUNCE = "OUT_BOUNCE"
  IN_OUT_BOUNCE = "IN_OUT_BOUNCE"
}
global.__EaseType = new _EaseType()
#macro EaseType global.__EaseType


///@static
global.__Ease = {

  ///@param {EaseType} [ease]
  ///@return {Callable}
  get: function(ease = EaseType.LINEAR) {

    #region ease functions
    static easeLegacy = function(progress = 0.0) {
      return progress
    }
  
    static easeLinear = function(progress = 0.0) {
      return progress
    }
  
    static easeInSine = function(progress = 0.0) {
      return 1.0 - cos((progress * pi) / 2.0)
    }
  
    static easeOutSine = function(progress = 0.0) {
      return sin((progress * pi) / 2.0)
    }
  
    static easeInOutSine = function(progress = 0.0) {
      return -1.0 * (cos(progress * pi) - 1.0) / 2.0
    }
  
    static easeInQuad = function(progress = 0.0) {
      return Math.pow(progress, 2.0)
    }
  
    static easeOutQuad = function(progress = 0.0) {
      return 1.0 - Math.pow(1.0 - progress, 2.0)
    }
  
    static easeInOutQuad = function(progress = 0.0) {
      return progress < 0.5
        ? Math.pow(progress, 2.0) * 2.0
        : 1.0 - Math.pow(-2.0 * progress + 2.0, 2.0) / 2.0
    }
  
    static easeInCubic = function(progress = 0.0) {
      return Math.pow(progress, 3.0)
    }
  
    static easeOutCubic = function(progress = 0.0) {
      return 1.0 - Math.pow(1.0 - progress, 3.0)
    }
  
    static easeInOutCubic = function(progress = 0.0) {
      return progress < 0.5
        ? Math.pow(progress, 3.0) * 4.0
        : 1.0 - Math.pow(-2.0 * progress + 2.0, 3.0) / 2.0
    }
  
    static easeInQuart = function(progress = 0.0) {
      return Math.pow(progress, 4.0)
    }
  
    static easeOutQuart = function(progress = 0.0) {
      return 1.0 - Math.pow(1.0 - progress, 4.0)
    }
  
    static easeInOutQuart = function(progress = 0.0) {
      return progress < 0.5
        ? Math.pow(progress, 4.0) * 8.0
        : 1.0 - Math.pow(-2.0 * progress + 2.0, 4.0) / 2.0
    }
  
    static easeInQuint = function(progress = 0.0) {
      return Math.pow(progress, 5.0)
    }
  
    static easeOutQuint = function(progress = 0.0) {
      return 1.0 - Math.pow(1.0 - progress, 5.0)
    }
  
    static easeInOutQuint = function(progress = 0.0) {
      return progress < 0.5
        ? Math.pow(progress, 5.0) * 16.0
        : 1.0 - Math.pow(-2.0 * progress + 2.0, 5.0) / 2.0
    }
  
    static easeInExpo = function(progress = 0.0) {
      return progress == 0.0 ? 0.0 : Math.pow(2.0, 10.0 * progress - 10.0)
    }
  
    static easeOutExpo = function(progress = 0.0) {
      return progress == 1.0 ? 1.0 : 1.0 - Math.pow(2.0, -10.0 * progress)
    }
  
    static easeInOutExpo = function(progress = 0.0) {
      return progress == 0.0
        ? 0.0
        : (progress == 1.0
          ? 1.0
          : (progress < 0.5
            ? Math.pow(2.0, 20.0 * progress - 10.0) / 2.0
            : (2.0 - Math.pow(2.0, -20.0 * progress + 10.0)) / 2.0))
    }
  
    static easeInCirc = function(progress = 0.0) {
      return 1.0 - Math.sqr(1.0 - Math.pow(progress, 2.0))
    }
  
    static easeOutCirc = function(progress = 0.0) {
      return Math.sqr(1.0 - Math.pow((progress - 1.0), 2.0))
    }
  
    static easeInOutCirc = function(progress = 0.0) {
      return progress < 0.5
        ? (1.0 - Math.sqr(1.0 - Math.pow(2.0 * progress, 2.0))) / 2.0
        : (Math.sqr(1.0 - Math.pow(-2.0 * progress + 2.0, 2.0)) + 1.0) / 2.0
    }
  
    static easeInBack = function(progress = 0.0) {
      return (2.70158) * progress * progress * progress - 1.70158 * progress * progress
    }
  
    static easeOutBack = function(progress = 0.0) {
      return 1.0 + 2.70158 * Math.pow(progress - 1.0, 3.0) + 1.70158 * Math.pow(progress - 1.0, 2.0)
    }
  
    static easeInOutBack = function(progress = 0.0) {
      return progress < 0.5
        ? (Math.pow(2.0 * progress, 2.0) * (((1.70158 * 1.525) + 1.0) * 2.0 * progress - (1.70158 * 1.525))) / 2.0
        : (Math.pow(2.0 * progress - 2.0, 2.0) * (((1.70158 * 1.525) + 1.0) * (progress * 2.0 - 2.0) + (1.70158 * 1.525)) + 2.0) / 2.0
    }
  
    static easeInElastic = function(progress = 0.0) {
      return progress == 0.0
        ? 0.0
        : (progress == 1.0
          ? 1.0
          : -1.0 * Math.pow(2.0, 10.0 * progress - 10.0) * sin((progress * 10.0 - 10.75) * ((2.0 * pi) / 3.0)))
    }
  
    static easeOutElastic = function(progress = 0.0) {
      return progress == 0.0
        ? 0.0
        : (progress == 1.0
          ? 1.0
          : Math.pow(2.0, -10.0 * progress) * sin((progress * 10.0 - 0.75) * ((2.0 * pi) / 3.0)) + 1.0)
    }
  
    static easeInOutElastic = function(progress = 0.0) {
      return progress == 0.0
        ? 0.0
        : (progress == 1.0
          ? 1.0
          : (progress < 0.5
            ? -1.0 * (Math.pow(2.0, 20.0 * progress - 10.0) * sin((20.0 * progress - 11.125) * ((2.0 * pi) / 4.5))) / 2.0
            : (Math.pow(2.0, -20.0 * progress + 10.0) * sin((20.0 * progress - 11.125) * ((2.0 * pi) / 4.5))) / 2.0 + 1.0 ))
    }
  
    static easeInBounce = function(progress = 0.0) {
      static helperFunction = function(progress = 0.0) {
        if (progress < 1.0 / 2.75) {
          return 7.5625 * progress * progress
        } else if (progress < 2.0 / 2.75) {
          return 7.5625 * ((progress - 1.5) / 2.75) * (progress - 1.5) + 0.75
        } else if (progress < 2.5 / 2.75) {
          return 7.5625 * ((progress - 2.25) / 2.75) * (progress - 2.25) + 0.9375
        } else {
          return 7.5625 * ((progress - 2.625) / 2.75) * (progress - 2.625) + 0.984375
        }
      }
  
      return helperFunction(1.0 - progress)
    }
  
    static easeOutBounce = function(progress = 0.0) {
      if (progress < 1.0 / 2.75) {
        return 7.5625 * progress * progress
      } else if (progress < 2.0 / 2.75) {
        return 7.5625 * ((progress - 1.5) / 2.75) * (progress - 1.5) + 0.75
      } else if (progress < 2.5 / 2.75) {
        return 7.5625 * ((progress - 2.25) / 2.75) * (progress - 2.25) + 0.9375
      } else {
        return 7.5625 * ((progress - 2.625) / 2.75) * (progress - 2.625) + 0.984375
      }
    }
  
    static easeInOutBounce = function(progress = 0.0) {
      static helperFunction = function(progress = 0.0) {
        if (progress < 1.0 / 2.75) {
          return 7.5625 * progress * progress
        } else if (progress < 2.0 / 2.75) {
          return 7.5625 * ((progress - 1.5) / 2.75) * (progress - 1.5) + 0.75
        } else if (progress < 2.5 / 2.75) {
          return 7.5625 * ((progress - 2.25) / 2.75) * (progress - 2.25) + 0.9375
        } else {
          return 7.5625 * ((progress - 2.625) / 2.75) * (progress - 2.625) + 0.984375
        }
      }
  
      return progress < 0.5
        ? (1.0 - helperFunction(1.0 - 2.0 * progress)) / 2.0
        : (1.0 + helperFunction(2.0 * progress - 1.0)) / 2.0
    }
    #endregion
    
    switch (ease) {
      case EaseType.LEGACY: return easeLegacy
      case EaseType.LINEAR: return easeLinear
      case EaseType.IN_SINE: return easeInSine
      case EaseType.OUT_SINE: return easeOutSine
      case EaseType.IN_OUT_SINE: return easeInOutSine
      case EaseType.IN_QUAD: return easeInQuad
      case EaseType.OUT_QUAD: return easeOutQuad
      case EaseType.IN_OUT_QUAD: return easeInOutQuad
      case EaseType.IN_CUBIC: return easeInCubic
      case EaseType.OUT_CUBIC: return easeOutCubic
      case EaseType.IN_OUT_CUBIC: return easeInOutCubic
      case EaseType.IN_QUART: return easeInQuart
      case EaseType.OUT_QUART: return easeOutQuart
      case EaseType.IN_OUT_QUART: return easeInOutQuart
      case EaseType.IN_QUINT: return easeInQuint
      case EaseType.OUT_QUINT: return easeOutQuint
      case EaseType.IN_OUT_QUINT: return easeInOutQuint
      case EaseType.IN_EXPO: return easeInExpo
      case EaseType.OUT_EXPO: return easeOutExpo
      case EaseType.IN_OUT_EXPO: return easeInOutExpo
      case EaseType.IN_CIRC: return easeInCirc
      case EaseType.OUT_CIRC: return easeOutCirc
      case EaseType.IN_OUT_CIRC: return easeInOutCirc
      case EaseType.IN_BACK: return easeInBack
      case EaseType.OUT_BACK: return easeOutBack
      case EaseType.IN_OUT_BACK: return easeInOutBack
      case EaseType.IN_ELASTIC: return easeInElastic
      case EaseType.OUT_ELASTIC: return easeOutElastic
      case EaseType.IN_OUT_ELASTIC: return easeInOutElastic
      case EaseType.IN_BOUNCE: return easeInBounce
      case EaseType.OUT_BOUNCE: return easeOutBounce
      case EaseType.IN_OUT_BOUNCE: return easeInOutBounce
      default: return easeLinear
    }
  },
}
#macro Ease global.__Ease