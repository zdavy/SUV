public enum Mode {
  case Read(Permission)

  public enum Permission {
    case User
  }

  public var flag: Int32 {
    switch self {
      case Read(let permission): switch permission {
        case .User: return UVModeReadUser
      }
    }
  }
}
