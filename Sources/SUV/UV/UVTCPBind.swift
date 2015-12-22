import libUV

public typealias UVTCPBindFn = (UnsafeMutablePointer<UVTCPType>, UnsafePointer<SockAddr>, UInt32) -> Int32
public let UVTCPBind: UVTCPBindFn = uv_tcp_bind
