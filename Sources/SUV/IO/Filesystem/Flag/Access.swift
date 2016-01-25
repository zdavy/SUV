public enum Access {
  case ReadOnly
  case Create
  case ReadWrite
  case Code(Int32)
  indirect case Or([Access])

  public var flag: Int32 {
    switch self {
      case ReadOnly: return UVReadOnly
      case Create: return UVCreate
      case ReadWrite: return UVReadWrite
      case Code(let code): return code
      case Or(let access): return access.reduce(0) { $0 | $1.flag }
    }
  }
}
