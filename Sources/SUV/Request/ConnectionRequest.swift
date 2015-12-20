public class ConnectionRequest {
  public typealias Pointer = UnsafeMutablePointer<UVConnectType>

  public let pointer: Pointer

  public init() {
    self.pointer = Pointer.alloc(sizeof(UVConnectType))
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
  }
}
