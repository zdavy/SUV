public enum LoopInit {
  case UV
  case Custom(UVLoopInitOperation)

  public var call: UVLoopInitOperation {
    switch self {
      case UV: return UVLoopInit
      case Custom(let loopInitOperation): return loopInitOperation
    }
  }
}
