import libUV

public class Handle {
}

public class ConnectionRequest {
  public func free() {
  }
}

public class TCPHandle: HandleType {
  public typealias Pointer = UnsafeMutablePointer<UVTCP>

  public let loop: Loop
  public let pointer: Pointer
  public let status: Status

  public init(_ loop: Loop) {
    self.loop = loop
    self.pointer = Pointer.alloc(sizeof(UVTCP))

    self.status = Status(uv_tcp_init(self.loop.pointer, self.pointer))
  }

  public func bind(addr: Addr, _ inet: INet = .AF) -> SUV.Status {
    return Status(uv_tcp_bind(self.pointer, addr.pointer, inet.family))
  }

  public func connect(addr: Addr, callback: (ConnectionRequest, Status) -> Void) {
  }

  public func close(callback: (Handle) -> Void) {
  }
}
