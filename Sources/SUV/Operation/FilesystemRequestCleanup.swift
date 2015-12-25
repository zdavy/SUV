public enum FilesystemRequestCleanup {
  case UV
  case Custom(UVFilesystemRequestCleanupOperation)

  public var call: UVFilesystemRequestCleanupOperation {
    switch self {
      case UV: return UVFilesystemRequestCleanup
      case Custom(let filesystemRequestCleanupOperation): return filesystemRequestCleanupOperation
    }
  }
}
