import UV
/* public var Run: UVRunFn = UVRun */

public enum Run {
  case UV
  case Custom(UVRunFn)

  public var call: UVRunFn {
    switch self {
      case UV: return UVRun
      case Custom(let runFn): return runFn
    }
  }
}
