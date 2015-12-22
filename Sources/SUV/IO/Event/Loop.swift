import UV

public class Loop {
  public typealias Pointer = UnsafeMutablePointer<UVLoopType>

  public static let defaultLoop = Loop(UVLoopDefault)

  public let pointer: Pointer
  public let status: Status

  public init(_ uv_loop_init: LoopInit = .UV) {
    self.pointer = Pointer.alloc(sizeof(UVLoopType))
    self.status = Status(uv_loop_init.call(self.pointer))
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
    self.status = .OK
  }

  public func run(uv_run: Run = .UV, _ runMode: RunMode) -> Status {
    return Status(uv_run.call(self.pointer, runMode.value))
  }
}
