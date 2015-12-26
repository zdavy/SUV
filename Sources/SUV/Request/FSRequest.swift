public class FSRequest {
  public typealias Pointer = UnsafeMutablePointer<UVFSType>

  public let pointer: Pointer
  public let loop: Loop

  public var result: File {
    return File(UVFile(pointer.memory.result))
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
    self.loop = Loop(pointer.memory.loop)
  }

  public func cleanup(uv_fs_req_cleanup: UVFSRequestCleanupOperation = UVFSRequestCleanup) {
    uv_fs_req_cleanup(self.pointer)
  }

  public func close(uv_fs_close: UVFSCloseOperation = UVFSClose, _ callback: ((FSRequest) -> Void)? = nil) -> Status {
    let closeRequest = UnsafeMutablePointer<UVFSType>.alloc(sizeof(UVFSType))

    if let cb = callback {
      closeRequest.memory.data = Cast.toVoid(cb)

      return Status(uv_fs_close(loop.pointer, closeRequest, result.ref) { request in
        let callback: (FSRequest) -> Void = Cast.fromVoid(request.memory.data)!
        callback(FSRequest(request))
      })
    } else {
      return Status(uv_fs_close(loop.pointer, closeRequest, result.ref, nil))
    }
  }
}

