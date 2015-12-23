/* public var Listen: UVListenOperation = UVListen */

public enum Listen {
  case UV
  case Custom(UVListenOperation)

  public var call: UVListenOperation {
    switch self {
      case UV: return UVListen
      case Custom(let listenOperation): return listenOperation
    }
  }
}
