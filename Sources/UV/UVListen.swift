import libUV

public typealias UVListenFn = (UnsafeMutablePointer<UVStreamType>, Int32, UVConnectionCallback) -> Int32
public let UVListen: UVListenFn = uv_listen
