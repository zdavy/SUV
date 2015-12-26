import SUV
import Swiftest

class TCPHandleSpec: Spec {
    let spec = describe("TCPHandle") {
      describe("initialize") {
        it("executes TCPInit with the pointer and provided loop") {
          var loop: UnsafeMutablePointer<UVLoopType>! = nil
          var tcp: UnsafeMutablePointer<UVTCPType>! = nil

          let tcpInit: UVTCPInitOperation = { loopPointer, tcpPointer in
            loop = loopPointer
            tcp = tcpPointer
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop, tcpInit)

          expect(loop).to.equal(Loop.defaultLoop.pointer)
          expect(tcp).to.equal(tcpHandle.pointer)
        }

        it("sets status to .OK if TCPInit is successful") {
          let tcpInit: UVTCPInitOperation = { _, _ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop, tcpInit)
          expect(tcpHandle.status).to.equal(.OK)
        }

        it("sets status to .Fail with code if TCPInit is not successful") {
          let code: Int32 = -1

          let tcpInit: UVTCPInitOperation = { _, _ in
            return code
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop, tcpInit)
          expect(tcpHandle.status).to.equal(.Fail(code))
        }
      }

      describe("bind") {
        it("passes the pointer and the provided addr to TCPBind") {
          let tcpInit: UVTCPInitOperation = { _,_ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop, tcpInit)
          let addr = Addr(AddrIn("0.0.0.0", 9999))

          let tcpBind: UVTCPBindOperation = { tcpHandlePointer, addrPointer, _ in
            expect(tcpHandlePointer).to.equal(tcpHandle.pointer)
            expect(addrPointer).to.equal(addr.pointer)
            return 0
          }

          tcpHandle.bind(addr, tcpBind)
        }

        it("passes the .AF address family by default") {
          let tcpInit: UVTCPInitOperation = { _,_ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop, tcpInit)
          let addr = Addr(AddrIn("0.0.0.0", 9999))

          let tcpBind: UVTCPBindOperation = { _, _, addressFamily in
            expect(addressFamily).to.equal(INet.AF.family)
            return 0
          }

          tcpHandle.bind(addr, tcpBind)
        }

        it("passes the provided address family") {
          let tcpInit: UVTCPInitOperation = { _,_ in
            return 0
          }

          let providedAddressFamily: INet = .PF

          let tcpHandle = TCPHandle(Loop.defaultLoop, tcpInit)
          let addr = Addr(AddrIn("0.0.0.0", 9999))

          let tcpBind: UVTCPBindOperation = {_, _, addressFamily in
            expect(addressFamily).to.equal(providedAddressFamily.family)
            return 0
          }

          tcpHandle.bind(addr, tcpBind, providedAddressFamily)
        }

        it("returns .OK if the TCPBind is sucessful") {
          let tcpInit: UVTCPInitOperation = { _,_ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop, tcpInit)
          let addr = Addr(AddrIn("0.0.0.0", 9999))

          let tcpBind: UVTCPBindOperation = {_,_,_ in
            return 0
          }

          expect(tcpHandle.bind(addr, tcpBind)).to.equal(.OK)
        }

        it("returns .Fail with the status code if the TCPBind is not sucessful") {
          let code: Int32 = -1

          let tcpInit: UVTCPInitOperation = { _,_ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop, tcpInit)
          let addr = Addr(AddrIn("0.0.0.0", 9999))

          let tcpBind: UVTCPBindOperation = {_,_,_ in
            return code
          }

          expect(tcpHandle.bind(addr, tcpBind)).to.equal(.Fail(code))
        }
      }

      describe("close") {
        it("creates a handle from itself and executes close") {
          let tcpInit: UVTCPInitOperation = { _,_ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop, tcpInit)

          let callback: UVCloseOperation = { handlePointer, _ in
            expect(handlePointer).to.equal(Handle(tcpHandle).pointer)
          }

          tcpHandle.close(callback) { _ in }
        }

        it("executes the provided callback in the Close function") {
          let tcpInit: UVTCPInitOperation = { _,_ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop, tcpInit)

          let callback: UVCloseOperation = { handlePointer, closeCallback in
            closeCallback(handlePointer)
          }

          var closeCallbackExecuted = false

          tcpHandle.close(callback) { _ in
            closeCallbackExecuted = true
          }

          expect(closeCallbackExecuted).to.equal(true)
        }
      }
    }
}
