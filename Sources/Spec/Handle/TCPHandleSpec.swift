import SUV
import Swiftest

class TCPHandleSpec: Spec {
    let spec = describe("TCPHandle") {
    it("successfully initializes a tcp handle") {
      let handle = TCPHandle(Loop.defaultLoop)
      expect(handle.status).to.equal(.OK)
    }

    it("successfully binds a tcp handle with an address and address family") {
      let handle = TCPHandle(Loop.defaultLoop)
      let addr = Addr(AddrIn("0.0.0.0", 8000))

      expect(handle.bind(addr, .AF)).to.equal(.OK)

      handle.close { $0.free() }
    }

    describe("connect") {
      it("successfully creates a connection on an address") {
        let addr = Addr(AddrIn("0.0.0.0", 8000))
        let handle = TCPHandle(Loop.defaultLoop)

        expect(handle.connect(addr) { _,_ in}).to.equal(.OK)
      }

      it("executes callback when connected") {
        var connectionCallback = false

        let handle = TCPHandle(Loop.defaultLoop)
        let addr = Addr(AddrIn("0.0.0.0", 8000))

        let server = TCPHandle(Loop.defaultLoop)
        server.bind(addr)
        StreamHandle(server).listen(.Max) { _,_ in }

        handle.connect(addr) { _,_ in connectionCallback = true }

        server.close { $0.free() }
        handle.close { $0.free() }

        Loop.defaultLoop.run(.Default)
        expect(connectionCallback).to.equal(true)
      }
    }
  }
}
