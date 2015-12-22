/* public var ReadStart: UVReadStartFn = UVReadStart */

public enum ReadStart {
  case UV
  case Custom(UVReadStartFn)

  public var call: UVReadStartFn {
    switch self {
      case UV: return UVReadStart
      case Custom(let readStartFn): return readStartFn
    }
  }
}
