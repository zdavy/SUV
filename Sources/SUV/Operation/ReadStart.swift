public enum ReadStart {
  case UV
  case Custom(UVReadStartOperation)

  public var call: UVReadStartOperation {
    switch self {
      case UV: return UVReadStart
      case Custom(let readStartOperation): return readStartOperation
    }
  }
}
