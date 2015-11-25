import Darwin

public let UVINetAF = UInt32(AF_INET)
public let UVINetPF = UInt32(PF_INET)

public enum INet {
  case AF
  case PF

  public var family: UInt32 {
    switch self {
      case AF: return UVINetAF
      case PF: return UVINetPF
    }
  }
}
