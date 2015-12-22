/* public var Write: UVWriteFn = UVWrite */

public enum Write {
  case UV
  case Custom(UVWriteFn)

  public var call: UVWriteFn {
    switch self {
      case UV: return UVWrite
      case Custom(let writeFn): return writeFn
    }
  }
}
