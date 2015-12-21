public class AddrIn: AddrType {
  public typealias Pointer = UnsafeMutablePointer<SockAddrIn>

  public let pointer: Pointer
  public let status: Status

  public init(_ host: String, _ port: Int) {
    self.pointer = Pointer.alloc(sizeof(SockAddrIn))
    self.status = Status(IP4Addr(host, Int32(port), self.pointer))
  }
}
