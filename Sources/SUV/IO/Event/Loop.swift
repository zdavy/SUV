public class Loop {
  public typealias Pointer = UnsafeMutablePointer<UVLoopType>

  public static let defaultLoop = Loop(UVLoopDefault)

  public let pointer: Pointer
  public let status: Status

  public init(uv_loop_init: LoopInit = UVLoopInit) {
    self.pointer = Pointer.alloc(sizeof(UVLoopType))
    self.status = Status(uv_loop_init(self.pointer))
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
    self.status = .OK
  }

  public func run(runMode: RunMode, uv_run: Run = UVRun) -> Status {
    return Status(uv_run(self.pointer, runMode.value))
  }

  public func close(uv_loop_close: LoopClose = UVLoopClose) {
    uv_loop_close(self.pointer)
  }
}
