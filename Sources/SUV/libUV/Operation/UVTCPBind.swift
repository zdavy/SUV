import libUV

public typealias UVTCPBindOperation = (UnsafeMutablePointer<UVTCPType>, UnsafePointer<SockAddr>, UInt32) -> Int32
public let UVTCPBind: UVTCPBindOperation = uv_tcp_bind
