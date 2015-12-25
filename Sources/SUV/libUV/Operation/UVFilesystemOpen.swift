import libUV

public typealias UVFilesystemOpenOperation = (UnsafeMutablePointer<UVLoopType>, UnsafeMutablePointer<UVFilesystemType>, UnsafePointer<Int8>, Int32, Int32, UVFilesystemCallback) -> Int32
public let UVFilesystemOpen: UVFilesystemOpenOperation = uv_fs_open
