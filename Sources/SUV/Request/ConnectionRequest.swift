public class ConnectionRequest {
  public typealias Pointer = UnsafeMutablePointer<UVConnect>

  public let pointer: Pointer

  public init() {
    self.pointer = Pointer.alloc(sizeof(UVConnect))
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
  }
}
