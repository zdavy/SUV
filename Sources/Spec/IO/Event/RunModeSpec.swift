import SUV
import Swiftest

class RunModeSpec: Spec {
  let spec = describe("RunMode") {
    describe("value") {
      it("Default return UVRunDefault") {
        expect(RunMode.Default.value).to.equal(UVRunDefault)
      }

      it("Once return UVRunOnce") {
        expect(RunMode.Once.value).to.equal(UVRunOnce)
      }

      it("NoWait return UVRunNoWait") {
        expect(RunMode.NoWait.value).to.equal(UVRunNoWait)
      }
    }
  }
}
