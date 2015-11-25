import SUV
import SwiftestClient

describe("TCPHandle") {
  it("successfully initializes a tcp handle") {
    let handle = TCPHandle(Loop.defaultLoop)
    expect(handle.status).to.equal(.OK)
  }
}
