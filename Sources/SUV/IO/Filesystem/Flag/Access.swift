public enum Access {
  case ReadOnly

  public var flag: Int32 {
    switch self {
      case ReadOnly: return UVReadOnly
    }
  }
}
