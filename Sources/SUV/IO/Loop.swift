public class Loop {
  public typealias Pointer = UnsafeMutablePointer<UVLoopType>

  public static let defaultLoop = Loop(UVLoopDefault)

  public let pointer: Pointer
  public let status: Status

  public init() {
    self.pointer = Pointer.alloc(sizeof(UVLoopType))
    self.status = Status(LoopInit(self.pointer))
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
    self.status = .OK
  }

  public func run(runMode: RunMode) -> Status {
    return Status(Run(self.pointer, runMode.value))
  }
}
