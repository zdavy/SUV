import UV
/* public var LoopInit: UVLoopInitFn = UVLoopInit */

public enum LoopInit {
  case UV
  case Custom(UVLoopInitFn)

  public var call: UVLoopInitFn {
    switch self {
      case UV: return UVLoopInit
      case Custom(let loopInitFn): return loopInitFn
    }
  }
}
