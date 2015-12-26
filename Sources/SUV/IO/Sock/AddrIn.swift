public class AddrIn: AddrType {
  public typealias Pointer = UnsafeMutablePointer<SockAddrIn>

  public let pointer: Pointer
  public let status: Status

  public init(_ host: String, _ port: Int, _ uv_ip4_addr: UVIP4AddrOperation = UVIP4Addr) {
    self.pointer = Pointer.alloc(sizeof(SockAddrIn))
    self.status = Status(uv_ip4_addr(host, Int32(port), self.pointer))
  }
}
