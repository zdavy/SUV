import libUV

public typealias UVAcceptOperation = (UnsafeMutablePointer<UVStreamType>, UnsafeMutablePointer<UVStreamType>) -> Int32
public let UVAccept: UVAcceptOperation = uv_accept
