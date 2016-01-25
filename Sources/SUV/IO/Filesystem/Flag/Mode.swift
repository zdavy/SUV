import Glibc
public typealias ModeType = mode_t

public enum Mode {
  public enum Permission {
    case User
  }

  case Read(Permission)
  case MODE(ModeType)
  indirect case Or([Mode])

  public var flag: Int32 {
    switch self {
      case Read(let permission): switch permission {
        case .User: return UVModeReadUser
      }
      case MODE(let mode): return Int32(mode)
      case Or(let mode): return mode.reduce(0) { $0 | $1.flag }
    }
  }
}
