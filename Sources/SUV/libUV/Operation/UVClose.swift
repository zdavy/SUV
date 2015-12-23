import libUV

public typealias UVCloseOperation = (UnsafeMutablePointer<UVHandleType>, UVCloseCallback) -> Void
public let UVClose: UVCloseOperation = uv_close
