import SUV
import Swiftest

class LoopSpec: Spec {
    let spec = describe("Loop") {
    describe("defaultLoop") {
      it("defaultLoop is a singleton") {
        expect(Loop.defaultLoop).to.equal(Loop.defaultLoop)
      }
    }

    describe("run") {
      it("sucessfully runs the loop") {
        let loop = Loop()
        expect(loop.run(.Default)).to.equal(.OK)
      }
    }
  }
}
