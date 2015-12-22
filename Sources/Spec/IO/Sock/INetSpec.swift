import UV
import SUV
import Swiftest

class INetSpec: Spec {
    let spec = describe("INet") {
    describe("family") {
      it("returns INetAF for AF") {
        expect(INet.AF.family).to.equal(INetAF)
      }

      it("returns INetPF for PF") {
        expect(INet.PF.family).to.equal(INetPF)
      }
    }
  }
}
