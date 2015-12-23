import libUV

public typealias UVTCPInitOperation = (UnsafeMutablePointer<UVLoopType>, UnsafeMutablePointer<UVTCPType>) -> Int32
public let UVTCPInit: UVTCPInitOperation = uv_tcp_init
