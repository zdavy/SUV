public class Loop {
  public typealias Pointer = UnsafeMutablePointer<UVLoopType>

  public static let defaultLoop = Loop(UVLoopDefault)

  public let pointer: Pointer

  public init() {
    self.pointer = Pointer.alloc(sizeof(UVLoopType))
    LoopInit(self.pointer)
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
  }

  public func run(runMode: RunMode) -> Status {
    return Status(Run(self.pointer, runMode.value))
  }
}
