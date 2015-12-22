/* public var TCPBind: UVTCPBindFn = UVTCPBind */

public enum TCPBind {
  case UV
  case Custom(UVTCPBindFn)

  public var call: UVTCPBindFn {
    switch self {
      case UV: return UVTCPBind
      case Custom(let tcpBindFn): return tcpBindFn
    }
  }
}
