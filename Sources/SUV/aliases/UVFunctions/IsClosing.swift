/* public var IsClosing: UVIsClosingFn = UVIsClosing */

public enum IsClosing {
  case UV
  case Custom(UVIsClosingFn)

  public var call: UVIsClosingFn {
    switch self {
      case UV: return UVIsClosing
      case Custom(let isClosingFn): return isClosingFn
    }
  }
}
