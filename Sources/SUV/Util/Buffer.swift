import libUV

public class Buffer {
  public let pointer: UnsafeMutablePointer<UVBuffer>

  init(_ pointer: UnsafePointer<UVBuffer>, _ size: Int) {
    self.pointer = UnsafeMutablePointer.alloc(size)
    self.pointer.memory = uv_buf_init(pointer.memory.base, UInt32(size))
  }

  public init() {
    self.pointer = UnsafeMutablePointer.alloc(sizeof(UVBuffer))
    self.pointer.memory = uv_buf_init(UnsafeMutablePointer<CChar>.alloc(sizeof(CChar)), UInt32(sizeof(CChar)))
  }
}
