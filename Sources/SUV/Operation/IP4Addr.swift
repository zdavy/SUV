public enum IP4Addr {
  case UV
  case Custom(UVIP4AddrOperation)

  public var call: UVIP4AddrOperation {
    switch self {
      case UV: return UVIP4Addr
      case Custom(let ip4AddrOperation): return ip4AddrOperation
    }
  }
}
