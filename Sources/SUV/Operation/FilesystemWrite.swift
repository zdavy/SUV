public enum FilesystemWrite {
  case UV
  case Custom(UVFilesystemWriteOperation)

  public var call: UVFilesystemWriteOperation {
    switch self {
      case UV: return UVFilesystemWrite
      case Custom(let fsWriteOperation): return fsWriteOperation
    }
  }
}
