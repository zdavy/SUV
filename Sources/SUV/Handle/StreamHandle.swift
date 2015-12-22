import UV

public class StreamHandle: HandleType {
  public typealias Pointer = UnsafeMutablePointer<UVStreamType>

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

  public func listen(uv_listen: Listen = .UV, _ backlog: Backlog = .Max, callback: (StreamHandle, Status) -> Void) -> Status {
    self.pointer.memory.data = Cast.toVoid(callback)

    return Status(uv_listen.call(self.pointer, backlog.amount) { stream, status in
      let callback: (StreamHandle, Status) -> Void = Cast.fromVoid(stream.memory.data)!
      callback(StreamHandle(stream), Status(status))
    })
  }

  public func accept(uv_accept: Accept = .UV, _ input: StreamHandle) -> Status {
    return Status(uv_accept.call(input.pointer, self.pointer))
  }

  public func read(uv_read_start: ReadStart = .UV, alloc: OnAlloc = .Default, callback: (StreamHandle, Int, Buffer) -> Void) -> Status {
    self.pointer.memory.data = Cast.toVoid(callback)

    return Status(uv_read_start.call(self.pointer, alloc.callback) { client, size, buffer in
      let callback: (StreamHandle, Int, Buffer) -> Void = Cast.fromVoid(client.memory.data)!
      callback(StreamHandle(client), size, Buffer(buffer, size))
    })
  }

  public func close(uv_close: Close = .UV, _ callback: (Handle -> Void)) {
    Handle(self).close(uv_close) { callback($0) }
  }
}
