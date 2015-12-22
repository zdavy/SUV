import UV

public enum RunMode {
  case Default
  case Once
  case NoWait

  public var value: UVRunModeType {
    switch self {
      case Default: return UVRunDefault
      case Once: return UVRunOnce
      case NoWait: return UVRunNoWait
    }
  }
}
