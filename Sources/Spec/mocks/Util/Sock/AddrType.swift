import SUV

class MockAddrType: AddrType {
  typealias Pointer = UnsafeMutablePointer<Void>
  let pointer: Pointer

  init() {
    self.pointer = Pointer.alloc(sizeof(Void))
  }
}
