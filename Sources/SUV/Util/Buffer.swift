import libUV

public class Buffer {
  public let pointer: UnsafeMutablePointer<UVBufferType>

  init(_ pointer: UnsafePointer<UVBufferType>, _ size: Int) {
    self.pointer = UnsafeMutablePointer.alloc(size)
    self.pointer.memory = uv_buf_init(pointer.memory.base, UInt32(size))
  }

  public init() {
    self.pointer = UnsafeMutablePointer.alloc(sizeof(UVBufferType))
    self.pointer.memory = uv_buf_init(UnsafeMutablePointer<CChar>.alloc(sizeof(CChar)), UInt32(sizeof(CChar)))
  }
}
