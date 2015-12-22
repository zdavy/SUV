import libUV

public typealias UVTCPInitFn = (UnsafeMutablePointer<UVLoopType>, UnsafeMutablePointer<UVTCPType>) -> Int32
public let UVTCPInit: UVTCPInitFn = uv_tcp_init
