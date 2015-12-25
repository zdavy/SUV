import SUV
import Swiftest

class FileEquatableSpec: Spec {
    let spec = describe("File :: Equatable") {
    it("equal when the refs are the same value") {
      let ref1 = UVFile(1)
      let ref2 = UVFile(1)
      expect(File(ref1)).to.equal(File(ref2))
    }

    it("unequal when the refs are different values") {
      let ref1 = UVFile(1)
      let ref2 = UVFile(2)
      expect(File(ref1)).notTo.equal(File(ref2))
    }
  }
}
