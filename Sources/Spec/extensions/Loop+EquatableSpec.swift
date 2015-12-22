import UV
import SUV
import Swiftest

class LoopEquatableSpec: Spec {
    let spec = describe("Loop :: Equatable") {
    it("equal when the pointers are the same") {
      let pointer = UnsafeMutablePointer<UVLoopType>.alloc(sizeof(UVLoopType))
      expect(Loop(pointer)).to.equal(Loop(pointer))
    }

    it("unequal when the pointers are different") {
      let pointer1 = UnsafeMutablePointer<UVLoopType>.alloc(sizeof(UVLoopType))
      let pointer2 = UnsafeMutablePointer<UVLoopType>.alloc(sizeof(UVLoopType))
      expect(Loop(pointer1)).notTo.equal(Loop(pointer2))
    }
  }
}
