public class Handle: HandleType {
  public typealias Pointer = UnsafeMutablePointer<UVHandleType>

  public let pointer: Pointer
  public let loop: Loop

  public var isClosing: Bool {
    return IsClosing(self.pointer) == 1
  }

  public init<T: HandleType>(_ handle: T) {
    self.pointer = Pointer(handle.pointer)
    self.loop = handle.loop
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
    self.loop = Loop(pointer.memory.loop)
  }

  public func close(callback: (Handle) -> Void) {
    self.pointer.memory.data = Cast.toVoid(callback)

    Close(self.pointer) { handle in
      let callback: (Handle) -> Void = Cast.fromVoid(handle.memory.data)!
      callback(Handle(handle))
    }
  }

  public func free() {
    self.pointer.dealloc(sizeofValue(self.pointer))
  }
}
