public enum FSRead {
  case UV
  case Custom(UVFSReadOperation)

  public var call: UVFSReadOperation {
    switch self {
      case UV: return UVFSRead
      case Custom(let fsReadOperation): return fsReadOperation
    }
  }
}
