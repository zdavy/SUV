import UV
/* public var IP4Addr: UVIP4AddrFn = UVIP4Addr */

public enum IP4Addr {
  case UV
  case Custom(UVIP4AddrFn)

  public var call: UVIP4AddrFn {
    switch self {
      case UV: return UVIP4Addr
      case Custom(let ip4AddrFn): return ip4AddrFn
    }
  }
}
