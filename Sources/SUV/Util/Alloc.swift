import libUV

public enum Alloc {
  case Default
  case OnAlloc(uv_alloc_cb!)

  var callback: uv_alloc_cb! {
    get {
      switch self {
        case .Default: return { _, size, buffer in
          buffer.memory = uv_buf_init(UnsafeMutablePointer.alloc(size), UInt32(size))
        }
        case .OnAlloc(let cb): return cb
      }
    }
  }
}
