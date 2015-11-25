import libUV

public class Loop {
  public typealias Pointer = UnsafeMutablePointer<UVLoop>

  public static let defaultLoop = Loop(UVLoopDefault)

  public let pointer: Pointer
  public let status: Status

  public init() {
    self.pointer = Pointer.alloc(sizeof(UVLoop))
    self.status = Status(uv_loop_init(self.pointer))
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
    self.status = .OK
  }
}
