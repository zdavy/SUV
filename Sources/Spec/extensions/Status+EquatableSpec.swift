import SUV
import Swiftest

class StatusEquatableSpec: Spec {
    let spec = describe("Status :: Equatable") {
    describe("OK") {
      it("always equal") {
        expect(Status.OK).to.equal(.OK)
      }
    }

    describe("Fail") {
      it("equal when codes match") {
        let code: Int32 = -1
        expect(Status.Fail(code)).to.equal(.Fail(code))
      }

      it("not equal when codes don't match") {
        expect(Status.Fail(-1)).notTo.equal(.Fail(-2))
      }
    }
  }
}
