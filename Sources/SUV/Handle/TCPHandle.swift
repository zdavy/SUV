public class TCPHandle: HandleType {
  public typealias Pointer = UnsafeMutablePointer<UVTCPType>

  public let loop: Loop
  public let pointer: Pointer
  public let status: Status

  public init(_ loop: Loop, uv_tcp_init: TCPInit = UVTCPInit) {
    self.loop = loop
    self.pointer = Pointer.alloc(sizeof(UVTCPType))

    self.status = Status(uv_tcp_init(self.loop.pointer, self.pointer))
  }

  public func bind(addr: Addr, inet: INet = .AF, uv_tcp_bind: TCPBind = UVTCPBind) -> SUV.Status {
    return Status(uv_tcp_bind(self.pointer, addr.pointer, inet.family))
  }

  public func close(uv_close uv_close: Close = UVClose, _ callback: (Handle) -> Void) {
    Handle(self).close(uv_close: uv_close) { callback($0) }
  }
}
