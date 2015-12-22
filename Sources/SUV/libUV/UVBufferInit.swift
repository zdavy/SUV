import libUV

public typealias UVBufferInitFn = (UnsafeMutablePointer<Int8>, UInt32) -> UVBufferType
public let UVBufferInit: UVBufferInitFn = uv_buf_init
