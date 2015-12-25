import libUV

public typealias UVFilesystemCloseOperation = (UnsafeMutablePointer<UVLoopType>, UnsafeMutablePointer<UVFilesystemType>, UVFile, UVFilesystemCallback) -> Int32
public let UVFilesystemClose: UVFilesystemCloseOperation = uv_fs_close
