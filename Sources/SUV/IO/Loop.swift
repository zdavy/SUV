import libUV

public class Loop {
  public typealias Pointer = UnsafeMutablePointer<UVLoop>

  public static let defaultLoop = Loop(UVLoopDefault)

  public let pointer: Pointer

  public init() {
    self.pointer = Pointer.alloc(sizeof(UVLoop))
    uv_loop_init(self.pointer)
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
  }

  public func run(runMode: RunMode) -> Status {
    return Status(uv_run(self.pointer, runMode.value))
  }
}
