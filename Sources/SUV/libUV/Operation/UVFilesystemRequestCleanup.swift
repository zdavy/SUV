import libUV

public typealias UVFilesystemRequestCleanupOperation = (UnsafeMutablePointer<UVFilesystemType>) -> Void
public let UVFilesystemRequestCleanup: UVFilesystemRequestCleanupOperation = uv_fs_req_cleanup
