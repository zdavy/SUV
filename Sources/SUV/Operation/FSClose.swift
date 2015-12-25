public enum FSClose {
  case UV
  case Custom(UVFSCloseOperation)

  public var call: UVFSCloseOperation {
    switch self {
      case UV: return UVFSClose
      case Custom(let filesystemCloseOperation): return filesystemCloseOperation
    }
  }
}
