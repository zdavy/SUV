public enum RunMode {
  case Default
  case Once
  case NoWait

  public var value: UVRunMode {
    switch self {
      case Default: return UVRunDefault
      case Once: return UVRunOnce
      case NoWait: return UVRunNoWait
    }
  }
}
