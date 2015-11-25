public enum Status {
  case OK
  case Fail(Int32)

  public init(_ code: Int32) {
    self = code == 0 ? .OK : .Fail(code)
  }
}
