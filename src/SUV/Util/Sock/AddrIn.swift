import libUV

public class AddrIn: AddrType {
  public typealias Pointer = UnsafeMutablePointer<SockAddrIn>

  public let pointer: Pointer
  public let status: Status

  public init(_ host: String, _ port: Int) {
    self.pointer = Pointer.alloc(sizeof(SockAddrIn))
    self.status = Status(uv_ip4_addr(host, Int32(port), self.pointer))
  }
}
