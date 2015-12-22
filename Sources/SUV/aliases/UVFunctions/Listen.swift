/* public var Listen: UVListenFn = UVListen */

public enum Listen {
  case UV
  case Custom(UVListenFn)

  public var call: UVListenFn {
    switch self {
      case UV: return UVListen
      case Custom(let listenFn): return listenFn
    }
  }
}
