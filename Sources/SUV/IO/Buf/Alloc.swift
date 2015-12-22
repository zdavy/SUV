import UV

public enum Alloc {
  case Default
  case OnAlloc(UVAllocCallback)

  public var callback: UVAllocCallback {
      switch self {
        case .Default: return { handle, size, buffer in
          let uv_buf_init: BufferInit = Cast.fromVoid(handle.memory.data)!
          buffer.memory = uv_buf_init.call(UnsafeMutablePointer.alloc(size), UInt32(size))
        }
        case .OnAlloc(let cb): return cb
      }
  }
}
