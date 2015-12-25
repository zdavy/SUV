public enum FilesystemRead {
  case UV
  case Custom(UVFilesystemReadOperation)

  public var call: UVFilesystemReadOperation {
    switch self {
      case UV: return UVFilesystemRead
      case Custom(let fsReadOperation): return fsReadOperation
    }
  }
}
