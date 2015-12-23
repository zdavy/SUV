import libUV

public typealias UVTCPConnectOperation = (UnsafeMutablePointer<UVConnectType>, UnsafeMutablePointer<UVTCPType>, UnsafePointer<SockAddr>, UVConnectCallback) -> Int32
public let UVTCPConnect: UVTCPConnectOperation = uv_tcp_connect
