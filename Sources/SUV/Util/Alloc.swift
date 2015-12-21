public enum Alloc {
  case Default
  case OnAlloc(UVAllocCallback)

  var callback: UVAllocCallback {
    get {
      switch self {
        case .Default: return { _, size, buffer in
          buffer.memory = BufferInit(UnsafeMutablePointer.alloc(size), UInt32(size))
        }
        case .OnAlloc(let cb): return cb
      }
    }
  }
}
