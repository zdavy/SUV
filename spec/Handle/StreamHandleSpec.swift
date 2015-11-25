import SUV
import SwiftestClient
import Darwin


public class Handle {
}


public class StreamHandle {
  public init(_ handle: HandleType) {
  }

  public func listen(backlog: Backlog = .Max, callback: (StreamHandle, SUV.Status) -> Void) {
  }

  public func close(callback: (Handle) -> Void) {
  }
}

describe("StreamHandle") {
  describe("listen") {
    it("listens for a request") {
      var connectionCallback = false;

      let server = TCPHandle(Loop.defaultLoop)
      server.bind(Addr(AddrIn("0.0.0.0", 8000)))

      let stream = StreamHandle(server)
      stream.listen(.Max) { stream, status in
        expect(status).to.equal(.OK)
        stream.close { handle in
          expect(handle != nil).to.equal(true)
        }
      }

      let addr = Addr(AddrIn("0.0.0.0", 8000))
      let client = TCPHandle(Loop.defaultLoop)

      client.connect(addr) { connection, status in
        expect(status).to.equal(.OK)
        connection.free()
        client.close { _ in }
        connectionCallback = true;
      }

      Loop.defaultLoop.run(.Default)

      expect(connectionCallback).to.equal(true)
    }
  }
}
