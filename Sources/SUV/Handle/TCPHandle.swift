import libUV

public class TCPHandle: HandleType {
  public typealias Pointer = UnsafeMutablePointer<UVTCPType>

  public let loop: Loop
  public let pointer: Pointer
  public let status: Status

  public init(_ loop: Loop) {
    self.loop = loop
    self.pointer = Pointer.alloc(sizeof(UVTCPType))

    self.status = Status(uv_tcp_init(self.loop.pointer, self.pointer))
  }

  public func bind(addr: Addr, _ inet: INet = .AF) -> SUV.Status {
    return Status(uv_tcp_bind(self.pointer, addr.pointer, inet.family))
  }

  public func connect(addr: Addr, callback: (ConnectionRequest, Status) -> Void) -> Status {
    let connectionRequest = ConnectionRequest()
    connectionRequest.pointer.memory.data = Cast.toVoid(callback)

    return Status(uv_tcp_connect(connectionRequest.pointer, self.pointer, addr.pointer) { connection, status in
      let callback: (ConnectionRequest, Status) -> Void = Cast.fromVoid(connection.memory.data)!
      callback(ConnectionRequest(connection), Status(status))
    })
  }

  public func close(callback: (Handle) -> Void) {
    Handle(self).close(callback)
  }
}
