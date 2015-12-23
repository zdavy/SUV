import libUV

public typealias UVReadStartOperation = (UnsafeMutablePointer<UVStreamType>, UVAllocCallback, UVReadCallback) -> Int32
public let UVReadStart: UVReadStartOperation = uv_read_start
