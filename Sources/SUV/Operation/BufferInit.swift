import UV
/* public var BufferInit: UVBufferInitFn = UVBufferInit */

public enum BufferInit {
  case UV
  case Custom(UVBufferInitFn)

  public var call: UVBufferInitFn {
    switch self {
      case UV: return UVBufferInit
      case Custom(let bufferInitFn): return bufferInitFn
    }
  }
}
