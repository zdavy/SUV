/* public var Accept: UVAcceptFn = UVAccept */

public enum Accept {
  case UV
  case Custom(UVAcceptFn)

  public var call: UVAcceptFn {
    switch self {
      case UV: return UVAccept
      case Custom(let acceptFn): return acceptFn
    }
  }
}
