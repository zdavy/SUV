import libUV

public typealias UVFSRequestCleanupOperation = (UnsafeMutablePointer<UVFSType>) -> Void
public let UVFSRequestCleanup: UVFSRequestCleanupOperation = uv_fs_req_cleanup
