/* public var BufferInit: UVBufferInitOperation = UVBufferInit */

public enum BufferInit {
  case UV
  case Custom(UVBufferInitOperation)

  public var call: UVBufferInitOperation {
    switch self {
      case UV: return UVBufferInit
      case Custom(let bufferInitOperation): return bufferInitOperation
    }
  }
}
