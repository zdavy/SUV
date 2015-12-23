/* public var TCPInit: UVTCPInitOperation = UVTCPInit */

public enum TCPInit {
  case UV
  case Custom(UVTCPInitOperation)

  public var call: UVTCPInitOperation {
    switch self {
      case UV: return UVTCPInit
      case Custom(let tcpInitOperation): return tcpInitOperation
    }
  }
}
