public class AddrIn: AddrType {
  public typealias Pointer = UnsafeMutablePointer<SockAddrIn>

  public let pointer: Pointer
  public let status: Status

  public init(_ uv_ip4_addr: IP4Addr = .UV, _ host: String, _ port: Int) {
    self.pointer = Pointer.alloc(sizeof(SockAddrIn))
    self.status = Status(uv_ip4_addr.call(host, Int32(port), self.pointer))
  }
}
