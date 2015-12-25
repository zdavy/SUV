import libUV

public typealias UVFSOpenOperation = (UnsafeMutablePointer<UVLoopType>, UnsafeMutablePointer<UVFSType>, UnsafePointer<Int8>, Int32, Int32, UVFSCallback) -> Int32
public let UVFSOpen: UVFSOpenOperation = uv_fs_open
