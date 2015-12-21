import SUV

class MockHandleType: HandleType {
  typealias Pointer = UnsafeMutablePointer<Void>

  let loop: Loop
  let pointer: Pointer

  init() {
    loop = Loop.defaultLoop
    pointer = UnsafeMutablePointer.alloc(sizeof(Pointer))
  }
}
