import SUV
import Swiftest

class AddrInSpec: Spec {
    let spec = describe("AddrIn") {
    it("successfully initalizes the AddrIn") {
      let addr = AddrIn("0.0.0.0", 8000)
      expect(addr.status).to.equal(.OK)
    }
  }
}
