/* public var TCPConnect: UVTCPConnectOperation = UVTCPConnect */

public enum TCPConnect {
  case UV
  case Custom(UVTCPConnectOperation)

  public var call: UVTCPConnectOperation {
    switch self {
      case UV: return UVTCPConnect
      case Custom(let tcpConnectOperation): return tcpConnectOperation
    }
  }
}
