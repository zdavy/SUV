public enum Accept {
  case UV
  case Custom(UVAcceptOperation)

  public var call: UVAcceptOperation {
    switch self {
      case UV: return UVAccept
      case Custom(let acceptOperation): return acceptOperation
    }
  }
}
