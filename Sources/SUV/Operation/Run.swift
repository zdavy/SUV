/* public var Run: UVRunOperation = UVRun */

public enum Run {
  case UV
  case Custom(UVRunOperation)

  public var call: UVRunOperation {
    switch self {
      case UV: return UVRun
      case Custom(let runOperation): return runOperation
    }
  }
}
