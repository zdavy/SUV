import libUV

public typealias UVListenOperation = (UnsafeMutablePointer<UVStreamType>, Int32, UVConnectionCallback) -> Int32
public let UVListen: UVListenOperation = uv_listen
