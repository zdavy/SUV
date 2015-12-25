import libUV

public typealias UVFSWriteOperation = (UnsafeMutablePointer<UVLoopType>, UnsafeMutablePointer<UVFSType>, UVFile, UnsafePointer<UVBufferType>, UInt32, Int64, UVFSCallback) -> Int32
public let UVFSWrite: UVFSWriteOperation = uv_fs_write
