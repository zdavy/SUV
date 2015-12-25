public enum FSWrite {
  case UV
  case Custom(UVFSWriteOperation)

  public var call: UVFSWriteOperation {
    switch self {
      case UV: return UVFSWrite
      case Custom(let fsWriteOperation): return fsWriteOperation
    }
  }
}
