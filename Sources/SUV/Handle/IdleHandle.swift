public class IdleHandle {
  public typealias Pointer = UnsafeMutablePointer<UVIdleType>

  public let loop: Loop
  public let pointer: Pointer
  public let status: Status

  public init(_ loop: Loop, uv_idle_init: IdleInit = UVIdleInit) {
    self.loop = loop
    self.pointer = Pointer.alloc(sizeof(UVIdleType))
    self.status = Status(uv_idle_init(loop.pointer, pointer))
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
    self.loop = Loop(pointer.memory.loop)
    self.status = .OK
  }

  public func start(uv_idle_start uv_idle_start: IdleStart = UVIdleStart, _ callback: (IdleHandle) -> Void) -> Status {
    pointer.memory.data = Cast.toVoid(callback)

    return Status(uv_idle_start(pointer) { handle in
        let callback: (IdleHandle) -> Void = Cast.fromVoid(handle.memory.data)!
        callback(IdleHandle(handle))
    })
  }

  public func stop(uv_idle_stop uv_idle_stop: IdleStop = UVIdleStop) -> Status {
    return Status(uv_idle_stop(self.pointer))
  }
}
