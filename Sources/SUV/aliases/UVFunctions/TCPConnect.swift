/* public var TCPConnect: UVTCPConnectFn = UVTCPConnect */

public enum TCPConnect {
  case UV
  case Custom(UVTCPConnectFn)

  public var call: UVTCPConnectFn {
    switch self {
      case UV: return UVTCPConnect
      case Custom(let tcpConnectFn): return tcpConnectFn
    }
  }
}
