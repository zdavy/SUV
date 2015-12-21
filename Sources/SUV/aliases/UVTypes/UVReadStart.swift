import libUV

public typealias UVReadStartFn = (UnsafeMutablePointer<UVStreamType>, UVAllocCallback, UVReadCallback) -> Int32
public let UVReadStart: UVReadStartFn = uv_read_start
