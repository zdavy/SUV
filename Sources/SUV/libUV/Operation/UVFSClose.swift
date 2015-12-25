import libUV

public typealias UVFSCloseOperation = (UnsafeMutablePointer<UVLoopType>, UnsafeMutablePointer<UVFSType>, UVFile, UVFSCallback) -> Int32
public let UVFSClose: UVFSCloseOperation = uv_fs_close
