public enum FSRequestCleanup {
  case UV
  case Custom(UVFSRequestCleanupOperation)

  public var call: UVFSRequestCleanupOperation {
    switch self {
      case UV: return UVFSRequestCleanup
      case Custom(let filesystemRequestCleanupOperation): return filesystemRequestCleanupOperation
    }
  }
}
