import UV
/* public var TCPInit: UVTCPInitFn = UVTCPInit */

public enum TCPInit {
  case UV
  case Custom(UVTCPInitFn)

  public var call: UVTCPInitFn {
    switch self {
      case UV: return UVTCPInit
      case Custom(let tcpInitFn): return tcpInitFn
    }
  }
}
