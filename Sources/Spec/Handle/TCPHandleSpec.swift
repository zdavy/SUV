import Swiftest
import SUV

class TCPHandleSpec: Spec {
    let spec = describe("TCPHandle") {
      describe("initialize") {
        it("executes TCPInit with the pointer and provided loop") {
          var loop: UnsafeMutablePointer<UVLoopType>! = nil
          var tcp: UnsafeMutablePointer<UVTCPType>! = nil

          TCPInit = { loopPointer, tcpPointer in
            loop = loopPointer
            tcp = tcpPointer
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop)

          expect(loop).to.equal(Loop.defaultLoop.pointer)
          expect(tcp).to.equal(tcpHandle.pointer)
        }

        it("sets status to .OK if TCPInit is successful") {
          TCPInit = { _, _ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop)
          expect(tcpHandle.status).to.equal(.OK)
        }

        it("sets status to .Fail with code if TCPInit is not successful") {
          let code: Int32 = -1

          TCPInit = { _, _ in
            return code
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop)
          expect(tcpHandle.status).to.equal(.Fail(code))
        }
      }

      describe("bind") {
        it("passes the pointer and the provided addr to TCPBind") {
          TCPInit = { _,_ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop)
          let addr = Addr(AddrIn("0.0.0.0", 9999))

          TCPBind = { tcpHandlePointer, addrPointer, _ in
            expect(tcpHandlePointer).to.equal(tcpHandle.pointer)
            expect(addrPointer).to.equal(addr.pointer)
            return 0
          }

          tcpHandle.bind(addr)
        }

        it("passes the .AF address family by default") {
          TCPInit = { _,_ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop)
          let addr = Addr(AddrIn("0.0.0.0", 9999))

          TCPBind = { _, _, addressFamily in
            expect(addressFamily).to.equal(INet.AF.family)
            return 0
          }

          tcpHandle.bind(addr)
        }

        it("passes the provided address family") {
          TCPInit = { _,_ in
            return 0
          }

          let providedAddressFamily: INet = .PF

          let tcpHandle = TCPHandle(Loop.defaultLoop)
          let addr = Addr(AddrIn("0.0.0.0", 9999))

          TCPBind = {_, _, addressFamily in
            expect(addressFamily).to.equal(providedAddressFamily.family)
            return 0
          }

          tcpHandle.bind(addr, providedAddressFamily)
        }

        it("returns .OK if the TCPBind is sucessful") {
          TCPInit = { _,_ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop)
          let addr = Addr(AddrIn("0.0.0.0", 9999))

          TCPBind = {_,_,_ in
            return 0
          }

          expect(tcpHandle.bind(addr)).to.equal(.OK)
        }

        it("returns .Fail with the status code if the TCPBind is not sucessful") {
          let code: Int32 = -1

          TCPInit = { _,_ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop)
          let addr = Addr(AddrIn("0.0.0.0", 9999))

          TCPBind = {_,_,_ in
            return code
          }

          expect(tcpHandle.bind(addr)).to.equal(.Fail(code))
        }
      }

      describe("close") {
        it("creates a handle from itself and executes close") {
          TCPInit = { _,_ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop)

          Close = { handlePointer, _ in
            expect(handlePointer).to.equal(Handle(tcpHandle).pointer)
          }

          tcpHandle.close { _ in }
        }

        it("executes the provided callback in the Close function") {
          TCPInit = { _,_ in
            return 0
          }

          let tcpHandle = TCPHandle(Loop.defaultLoop)

          Close = { handlePointer, closeCallback in
            closeCallback(handlePointer)
          }

          var closeCallbackExecuted = false

          tcpHandle.close { _ in
            closeCallbackExecuted = true
          }

          expect(closeCallbackExecuted).to.equal(true)
        }
      }
    }
}
