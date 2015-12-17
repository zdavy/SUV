import SUV
import Swiftest

class HandleEquatableSpec: Spec {
    let spec = describe("Handle :: Equatable") {
    it("equal when the pointers are the same") {
      let pointer = UnsafeMutablePointer<UVHandle>.alloc(sizeof(UVHandle))
      expect(Handle(pointer)).to.equal(Handle(pointer))
    }

    it("unequal when the pointers are different") {
      let pointer1 = UnsafeMutablePointer<UVHandle>.alloc(sizeof(UVHandle))
      let pointer2 = UnsafeMutablePointer<UVHandle>.alloc(sizeof(UVHandle))
      expect(Handle(pointer1)).notTo.equal(Handle(pointer2))
    }
  }
}
