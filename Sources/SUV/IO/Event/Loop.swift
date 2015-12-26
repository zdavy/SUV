public class Loop {
  public typealias Pointer = UnsafeMutablePointer<UVLoopType>

  public static let defaultLoop = Loop(UVLoopDefault)

  public let pointer: Pointer
  public let status: Status

  public init(_ uv_loop_init: UVLoopInitOperation = UVLoopInit) {
    self.pointer = Pointer.alloc(sizeof(UVLoopType))
    self.status = Status(uv_loop_init(self.pointer))
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
    self.status = .OK
  }

  public func run(runMode: RunMode, _ uv_run: UVRunOperation = UVRun) -> Status {
    return Status(uv_run(self.pointer, runMode.value))
  }
}
