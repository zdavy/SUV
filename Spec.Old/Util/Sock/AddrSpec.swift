import SUV
import Swiftest

class AddrSpec: Spec {
    let spec = describe("Addr") {
    it("casts a sockaddr type to a sockaddr constant") {
      let addrIn = AddrIn("0.0.0.0", 8000)
      let addr = Addr(addrIn)
      expect(addr.pointer).to.equal(UnsafePointer<SockAddr>(addrIn.pointer))
    }
  }
}
