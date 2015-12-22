import libUV

public typealias UVCloseFn = (UnsafeMutablePointer<UVHandleType>, UVCloseCallback) -> Void
public let UVClose: UVCloseFn = uv_close
