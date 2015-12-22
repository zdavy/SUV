import UV
import SUV
import Swiftest

class AddrSpec: Spec {
    let spec = describe("Addr") {
      describe("initialize") {
        it("converts provided addr-type to addr constant") {
          let addrType = MockAddrType()
          let addr = Addr(addrType)

          expect(addr.pointer).to.equal(UnsafePointer<SockAddr>(addrType.pointer))
        }
      }
    }
}
