import libUV

public typealias UVAcceptFn = (UnsafeMutablePointer<UVStreamType>, UnsafeMutablePointer<UVStreamType>) -> Int32
public let UVAccept: UVAcceptFn = uv_accept
