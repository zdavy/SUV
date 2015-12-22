public class TCPHandle: HandleType {
  public typealias Pointer = UnsafeMutablePointer<UVTCPType>

  public let loop: Loop
  public let pointer: Pointer
  public let status: Status

  public init(_ uv_tcp_init: TCPInit = .UV, _ loop: Loop) {
    self.loop = loop
    self.pointer = Pointer.alloc(sizeof(UVTCPType))

    self.status = Status(uv_tcp_init.call(self.loop.pointer, self.pointer))
  }

  public func bind(uv_tcp_bind: TCPBind = .UV, _ addr: Addr, _ inet: INet = .AF) -> SUV.Status {
    return Status(uv_tcp_bind.call(self.pointer, addr.pointer, inet.family))
  }

  /* public func connect(addr: Addr, callback: (ConnectionRequest, Status) -> Void) -> Status { */
  /*   let connectionRequest = ConnectionRequest() */
  /*   connectionRequest.pointer.memory.data = Cast.toVoid(callback) */
  /*  */
  /*   return Status(TCPConnect(connectionRequest.pointer, self.pointer, addr.pointer) { connection, status in */
  /*     let callback: (ConnectionRequest, Status) -> Void = Cast.fromVoid(connection.memory.data)! */
  /*     callback(ConnectionRequest(connection), Status(status)) */
  /*   }) */
  /* } */

  public func close(uv_close: Close = .UV, _ callback: (Handle) -> Void) {
    Handle(self).close(uv_close) { callback($0) }
  }
}
