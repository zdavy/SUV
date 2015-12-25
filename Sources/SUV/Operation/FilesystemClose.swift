public enum FilesystemClose {
  case UV
  case Custom(UVFilesystemCloseOperation)

  public var call: UVFilesystemCloseOperation {
    switch self {
      case UV: return UVFilesystemClose
      case Custom(let filesystemCloseOperation): return filesystemCloseOperation
    }
  }
}
