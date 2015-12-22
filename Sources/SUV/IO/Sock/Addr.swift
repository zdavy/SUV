public class Addr {
  public typealias Pointer = UnsafePointer<SockAddr>
  public let pointer: Pointer

  public init<T: AddrType>(_ addr: T) {
    self.pointer = Pointer(addr.pointer)
  }
}
