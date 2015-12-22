public class WriteRequest {
  public typealias Pointer = UnsafeMutablePointer<UVWriteType>
  public let pointer: Pointer

  public init() {
    self.pointer = UnsafeMutablePointer.alloc(sizeof(UVWriteType))
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
  }

  public func write(uv_write: Write = .UV, _ stream: StreamHandle, _ buffer: Buffer, callback: (WriteRequest, Status) -> Void) -> Status {
    self.pointer.memory.data = Cast.toVoid(callback)

    return Status(uv_write.call(pointer, stream.pointer, buffer.pointer, 1) { request, status in
      let callback: (WriteRequest, Status) -> Void = Cast.fromVoid(request.memory.data)!
      callback(WriteRequest(request), Status(status))
    })
  }

  public func free() {
    self.pointer.dealloc(sizeofValue(self.pointer))
  }
}
