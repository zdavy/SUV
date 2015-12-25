public enum FilesystemOpen {
  case UV
  case Custom(UVFilesystemOpenOperation)

  public var call: UVFilesystemOpenOperation {
    switch self {
      case UV: return UVFilesystemOpen
      case Custom(let fsOpenOperation): return fsOpenOperation
    }
  }
}
