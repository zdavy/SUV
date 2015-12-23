import libUV

public typealias UVBufferInitOperation = (UnsafeMutablePointer<Int8>, UInt32) -> UVBufferType
public let UVBufferInit: UVBufferInitOperation = uv_buf_init
