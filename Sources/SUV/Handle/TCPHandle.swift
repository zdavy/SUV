public class TCPHandle: HandleType {
  public typealias Pointer = UnsafeMutablePointer<UVTCPType>

  public let loop: Loop
  public let pointer: Pointer
  public let status: Status

  public init(_ loop: Loop, _ uv_tcp_init: TCPInit = UVTCPInit) {
    self.loop = loop
    self.pointer = Pointer.alloc(sizeof(UVTCPType))

    self.status = Status(uv_tcp_init(self.loop.pointer, self.pointer))
  }

  public func bind(addr: Addr, _ uv_tcp_bind: TCPBind = UVTCPBind, _ inet: INet = .AF) -> SUV.Status {
    return Status(uv_tcp_bind(self.pointer, addr.pointer, inet.family))
  }

  public func close(uv_close: Close = UVClose, _ callback: (Handle) -> Void) {
    Handle(self).close(uv_close) { callback($0) }
  }
}
