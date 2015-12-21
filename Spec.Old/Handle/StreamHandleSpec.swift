import SUV
import Swiftest

class StreamHandleSpec: Spec {
  let spec = describe("StreamHandle") {
    describe("close") {
      it("closes a stream") {
        var closed = false
        let stream = StreamHandle(TCPHandle(Loop.defaultLoop))

        stream.close { _ in closed = true }

        Loop.defaultLoop.run(.Default)
        expect(closed).to.equal(true)
      }
    }

  // describe("listen") {
  //   it("successfully listens for a connection") {
  //     let server = TCPHandle(Loop.defaultLoop)
  //     let client = TCPHandle(Loop.defaultLoop)
  //     let addr = Addr(AddrIn("0.0.0.0", 8000))
  //
  //     server.bind(addr)
  //     client.connect(addr) { _,_ in }
  //
  //     let stream = StreamHandle(server)
  //     expect(stream.listen(.Max) { $0.0.close { $0.free() }}).to.equal(.OK)
  //
  //     Loop.defaultLoop.run(.Default)
  //   }
  //
  //   it("executes callback on listen") {
  //     var listened = false
  //
  //     let server = TCPHandle(Loop.defaultLoop)
  //     let client = TCPHandle(Loop.defaultLoop)
  //     let addr = Addr(AddrIn("0.0.0.0", 8000))
  //
  //     server.bind(addr)
  //     client.connect(addr) { _,_ in }
  //
  //     let stream = StreamHandle(server)
  //
  //     stream.listen(.Max) { stream, status in
  //       listened = true
  //       expect(status).to.equal(.OK)
  //
  //       stream.close { $0.free() }
  //     }
  //
  //     Loop.defaultLoop.run(.Default)
  //     expect(listened).to.equal(true)
  //   }
  // }
  }
}
