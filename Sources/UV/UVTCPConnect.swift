import libUV

public typealias UVTCPConnectFn = (UnsafeMutablePointer<UVConnectType>, UnsafeMutablePointer<UVTCPType>, UnsafePointer<SockAddr>, UVConnectCallback) -> Int32
public let UVTCPConnect: UVTCPConnectFn = uv_tcp_connect
