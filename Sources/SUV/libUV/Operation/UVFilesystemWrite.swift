import libUV

public typealias UVFilesystemWriteOperation = (UnsafeMutablePointer<UVLoopType>, UnsafeMutablePointer<UVFilesystemType>, UVFile, UnsafePointer<UVBufferType>, UInt32, Int64, UVFilesystemCallback) -> Int32
public let UVFilesystemWrite: UVFilesystemWriteOperation = uv_fs_write
