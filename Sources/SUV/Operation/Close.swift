import UV
/* public var Close: UVCloseFn = UVClose */

public enum Close {
  case UV
  case Custom(UVCloseFn)

  public var call: UVCloseFn {
    switch self {
      case UV: return UVClose
      case Custom(let closeFn): return closeFn
    }
  }
}
