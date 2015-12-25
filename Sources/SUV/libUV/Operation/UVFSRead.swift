import libUV

public typealias UVFSReadOperation = (UnsafeMutablePointer<UVLoopType>, UnsafeMutablePointer<UVFSType>, UVFile, UnsafePointer<UVBufferType>, UInt32, Int64, UVFSCallback) -> Int32
public let UVFSRead: UVFSReadOperation = uv_fs_read
