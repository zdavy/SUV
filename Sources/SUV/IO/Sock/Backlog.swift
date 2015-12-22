public enum Backlog {
  case Max
  case Exactly(Int32)

  public var amount: Int32 {
    get {
      switch self {
        case Max: return SoMaxConn
        case (let Exactly(amount)): return Int32(amount)
      }
    }
  }
}
