import libUV

public class StreamHandle: HandleType {
  public typealias Pointer = UnsafeMutablePointer<UVStream>

  public let pointer: Pointer
  public let loop: Loop

  public init<T: HandleType>(_ handle: T) {
    self.pointer = UnsafeMutablePointer(handle.pointer)
    self.loop = handle.loop
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
    self.loop = Loop(pointer.memory.loop)
  }

  public func listen(backlog: Backlog = .Max, callback: (StreamHandle, Status) -> Void) -> Status {
    self.pointer.memory.data = Cast.toVoid(callback)

    return Status(uv_listen(self.pointer, backlog.amount) { stream, status in
      let callback: (StreamHandle, Status) -> Void = Cast.fromVoid(stream.memory.data)!
      callback(StreamHandle(stream), Status(status))
    })
  }

  public func read(input: StreamHandle, alloc: Alloc = .Default, callback: (StreamHandle, Int, Buffer) -> Void) {
    self.pointer.memory.data = Cast.toVoid(callback)

    uv_accept(input.pointer, self.pointer)

    uv_read_start(self.pointer, alloc.callback) { client, size, buffer in
      let callback: (StreamHandle, Int, Buffer) -> Void = Cast.fromVoid(client.memory.data)!
      callback(StreamHandle(client), size, Buffer(buffer, size))
    }
  }

  public func close(callback: (Handle -> Void)) {
    Handle(self).close(callback)
  }
}
