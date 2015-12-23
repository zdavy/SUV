/* public var Write: UVWriteOperation = UVWrite */

public enum Write {
  case UV
  case Custom(UVWriteOperation)

  public var call: UVWriteOperation {
    switch self {
      case UV: return UVWrite
      case Custom(let writeOperation): return writeOperation
    }
  }
}
