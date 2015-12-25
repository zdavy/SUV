public class FilesystemRequest {
  public typealias Pointer = UnsafeMutablePointer<UVFilesystemType>

  public let pointer: Pointer
  public let loop: Loop

  public var result: File {
    return File(UVFile(pointer.memory.result))
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
    self.loop = Loop(pointer.memory.loop)
  }

  public func cleanup(uv_fs_req_cleanup: FilesystemRequestCleanup = .UV) {
    uv_fs_req_cleanup.call(self.pointer)
  }

  public func close(uv_fs_close: FilesystemClose = .UV, _ callback: ((FilesystemRequest) -> Void)? = nil) -> Status {
    let closeRequest = UnsafeMutablePointer<UVFilesystemType>.alloc(sizeof(UVFilesystemType))

    if let cb = callback {
      closeRequest.memory.data = Cast.toVoid(cb)

      return Status(uv_fs_close.call(loop.pointer, closeRequest, result.ref) { request in
        let callback: (FilesystemRequest) -> Void = Cast.fromVoid(request.memory.data)!
        callback(FilesystemRequest(request))
      })
    } else {
      return Status(uv_fs_close.call(loop.pointer, closeRequest, result.ref, nil))
    }
  }
}

