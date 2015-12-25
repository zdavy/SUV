public enum FSOpen {
  case UV
  case Custom(UVFSOpenOperation)

  public var call: UVFSOpenOperation {
    switch self {
      case UV: return UVFSOpen
      case Custom(let fsOpenOperation): return fsOpenOperation
    }
  }
}
