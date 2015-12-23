/* public var Close: UVCloseOperation = UVClose */

public enum Close {
  case UV
  case Custom(UVCloseOperation)

  public var call: UVCloseOperation {
    switch self {
      case UV: return UVClose
      case Custom(let closeOperation): return closeOperation
    }
  }
}
