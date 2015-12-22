public enum OnAlloc {
  case Default
  case OnAlloc(UVAllocCallback)

  public var callback: UVAllocCallback {
      switch self {
        case .Default: return { handle, size, buffer in
          buffer.memory = BufferInit.UV.call(UnsafeMutablePointer.alloc(size), UInt32(size))
        }
        case .OnAlloc(let cb): return cb
      }
  }
}
