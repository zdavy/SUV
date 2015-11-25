import SUV
import SwiftestClient

describe("TCPHandle") {
  it("successfully initializes a tcp handle") {
    let handle = TCPHandle(Loop.defaultLoop)
    expect(handle.status).to.equal(.OK)
  }

  it("successfully binds a tcp handle with an address and address family") {
    let addr = Addr(AddrIn("0.0.0.0", 8000))
    let handle = TCPHandle(Loop.defaultLoop)
    expect(handle.bind(addr, .AF)).to.equal(.OK)
  }
}
