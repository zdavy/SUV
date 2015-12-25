import libUV

public typealias UVFilesystemReadOperation = (UnsafeMutablePointer<UVLoopType>, UnsafeMutablePointer<UVFilesystemType>, UVFile, UnsafePointer<UVBufferType>, UInt32, Int64, UVFilesystemCallback) -> Int32
public let UVFilesystemRead: UVFilesystemReadOperation = uv_fs_read
