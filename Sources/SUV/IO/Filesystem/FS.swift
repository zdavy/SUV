public class FS {
  public typealias Pointer = UnsafeMutablePointer<UVFilesystemType>

  public let loop: Loop
  public let pointer: Pointer

  public init(_ loop: Loop) {
    self.loop = loop
    self.pointer = Pointer.alloc(sizeof(UVFilesystemType))
  }

  public func open(filepath: String, _ access: Access, _ mode: Mode, _ uv_fs_open: FilesystemOpen = .UV, _ callback: (FilesystemRequest) -> Void) -> Status {
    pointer.memory.data = Cast.toVoid(callback)

    return Status(uv_fs_open.call(loop.pointer, self.pointer, filepath, access.flag, mode.flag) { request in
      let callback: (FilesystemRequest) -> Void = Cast.fromVoid(request.memory.data)!
      callback(FilesystemRequest(request))
    })
  }

  public func read(file: File, _ buffer: Buffer, _ size: Int, _ uv_fs_read: FilesystemRead = .UV, offset: Int = -1, _ callback: (FilesystemRequest) -> Void) -> Status {
    pointer.memory.data = Cast.toVoid(callback)

    buffer.pointer.memory.len = size

    return Status(uv_fs_read.call(loop.pointer, self.pointer, file.ref, buffer.pointer, UInt32(size), Int64(offset)) { request in
      let callback: (FilesystemRequest) -> Void = Cast.fromVoid(request.memory.data)!
      callback(FilesystemRequest(request))
    })
  }

  public func write(output: FileDescriptor, _ buffer: Buffer, _ size: Int, _ uv_fs_write: FilesystemWrite = .UV, offset: Int = -1, _ callback: (FilesystemRequest) -> Void) -> Status {
    pointer.memory.data = Cast.toVoid(callback)

    buffer.pointer.memory.len = size

    return Status(uv_fs_write.call(loop.pointer, self.pointer, output.flag, buffer.pointer, UInt32(size), Int64(offset)) { request in
      let callback: (FilesystemRequest) -> Void = Cast.fromVoid(request.memory.data)!
      callback(FilesystemRequest(request))
    })
  }
}
