import UV

public enum INet {
  case AF
  case PF

  public var family: UInt32 {
    switch self {
      case AF: return INetAF
      case PF: return INetPF
    }
  }
}
