import libUV

public typealias UVWriteOperation = (UnsafeMutablePointer<uv_write_t>, UnsafeMutablePointer<uv_stream_t>, UnsafePointer<uv_buf_t>, UInt32, UVWriteCallback) -> Int32
public let UVWrite: UVWriteOperation = uv_write
