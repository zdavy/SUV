public class FS {
  public typealias Pointer = UnsafeMutablePointer<UVFSType>

  public let loop: Loop
  public let pointer: Pointer

  public init(_ loop: Loop) {
    self.loop = loop
    self.pointer = Pointer.alloc(sizeof(UVFSType))
  }

  public func open(filepath: String, _ access: Access, _ mode: Mode, uv_fs_open: FSOpen = UVFSOpen, _ callback: (FSRequest) -> Void) -> Status {
    pointer.memory.data = Cast.toVoid(callback)

    return Status(uv_fs_open(loop.pointer, self.pointer, filepath, access.flag, mode.flag) { request in
      let callback: (FSRequest) -> Void = Cast.fromVoid(request.memory.data)!
      callback(FSRequest(request))
    })
  }

  public func read(file: File, _ buffer: Buffer, _ size: Int, uv_fs_read: FSRead = UVFSRead, offset: Int = -1, _ callback: (FSRequest) -> Void) -> Status {
    pointer.memory.data = Cast.toVoid(callback)

    buffer.pointer.memory.len = size

    return Status(uv_fs_read(loop.pointer, self.pointer, file.ref, buffer.pointer, UInt32(size), Int64(offset)) { request in
      let callback: (FSRequest) -> Void = Cast.fromVoid(request.memory.data)!
      callback(FSRequest(request))
    })
  }

  public func write(output: FileDescriptor, _ buffer: Buffer, _ size: Int, uv_fs_write: FSWrite = UVFSWrite, offset: Int = -1, _ callback: (FSRequest) -> Void) -> Status {
    pointer.memory.data = Cast.toVoid(callback)

    buffer.pointer.memory.len = size

    return Status(uv_fs_write(loop.pointer, self.pointer, output.flag, buffer.pointer, UInt32(size), Int64(offset)) { request in
      let callback: (FSRequest) -> Void = Cast.fromVoid(request.memory.data)!
      callback(FSRequest(request))
    })
  }
}
