import libUV

public class TCPHandle {
  public typealias Pointer = UnsafeMutablePointer<UVTCP>

  public let loop: Loop
  public let pointer: Pointer
  public let status: Status

  public init(_ loop: Loop) {
    self.loop = loop
    self.pointer = Pointer.alloc(sizeof(UVTCP))

    self.status = Status(uv_tcp_init(self.loop.pointer, self.pointer))
  }

  public func bind(addr: Addr, _ inet: INet) -> SUV.Status {
    return Status(uv_tcp_bind(self.pointer, addr.pointer, inet.family))
  }
}
