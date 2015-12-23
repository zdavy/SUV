/* public var TCPBind: UVTCPBindOperation = UVTCPBind */

public enum TCPBind {
  case UV
  case Custom(UVTCPBindOperation)

  public var call: UVTCPBindOperation {
    switch self {
      case UV: return UVTCPBind
      case Custom(let tcpBindOperation): return tcpBindOperation
    }
  }
}
