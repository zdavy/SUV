public class FS {
  public typealias Pointer = UnsafeMutablePointer<UVFSType>

  public let loop: Loop
  public let pointer: Pointer

  public init(_ loop: Loop) {
    self.loop = loop
    self.pointer = Pointer.alloc(sizeof(UVFSType))
  }

  public func open(uv_fs_open uv_fs_open: FSOpen = UVFSOpen, _ filepath: String, _ access: Access, _ mode: Mode) -> FileDescriptor {
    return .File(uv_fs_open(loop.pointer, self.pointer, filepath, access.flag, mode.flag, nil))
  }

  public func open(uv_fs_open uv_fs_open: FSOpen = UVFSOpen, _ filepath: String, _ access: Access, _ mode: Mode, _ callback: (FSRequest) -> Void) -> Status {
    pointer.memory.data = Cast.toVoid(callback)

    return Status(uv_fs_open(loop.pointer, self.pointer, filepath, access.flag, mode.flag) { request in
      let callback: (FSRequest) -> Void = Cast.fromVoid(request.memory.data)!
      callback(FSRequest(request))
    })
  }

  public func read(input: FileDescriptor, _ buffer: Buffer, _ size: Int, uv_fs_read: FSRead = UVFSRead, offset: Int = -1, _ callback: (FSRequest) -> Void) -> Status {
    pointer.memory.data = Cast.toVoid(callback)

    buffer.pointer.memory.len = size

    return Status(uv_fs_read(loop.pointer, self.pointer, UVFile(input), buffer.pointer, UInt32(size), Int64(offset)) { request in
      let callback: (FSRequest) -> Void = Cast.fromVoid(request.memory.data)!
      callback(FSRequest(request))
    })
  }

  public func write(output: FileDescriptor, _ buffer: Buffer, _ size: Int, uv_fs_write: FSWrite = UVFSWrite, offset: Int = -1, _ callback: (FSRequest) -> Void) -> Status {
    pointer.memory.data = Cast.toVoid(callback)

    buffer.pointer.memory.len = size

    return Status(uv_fs_write(loop.pointer, self.pointer, UVFile(output), buffer.pointer, UInt32(size), Int64(offset)) { request in
      let callback: (FSRequest) -> Void = Cast.fromVoid(request.memory.data)!
      callback(FSRequest(request))
    })
  }
}
