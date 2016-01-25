public class PipeHandle: HandleType {
  public typealias Pointer = UnsafeMutablePointer<UVPipeType>

  public let pointer: Pointer
  public let loop: Loop
  public let status: Status

  public init(_ loop: Loop, uv_pipe_init: PipeInit = UVPipeInit, interprocessCommuncation: Bool = false) {
    self.pointer = Pointer.alloc(sizeof(UVPipeType))
    self.loop = loop

    self.status = Status(uv_pipe_init(self.loop.pointer, self.pointer, interprocessCommuncation ? 1 : 0))
  }

  public func open(output: FileDescriptor, uv_pipe_open: PipeOpen = UVPipeOpen) {
    uv_pipe_open(self.pointer, UVFile(output))
  }

  public func close(uv_close uv_close: Close = UVClose, _ callback: (Handle -> Void)? = nil) {
    if let cb = callback {
      Handle(self).close(uv_close: uv_close) { cb($0) }
    } else {
      Handle(self).close(uv_close: uv_close)
    }
  }
}
