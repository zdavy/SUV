import SUV
import SwiftestClient

describe("AddrIn") {
  it("successfully initalizes the AddrIn") {
    let addr = AddrIn("0.0.0.0", 8000)
    expect(addr.status).to.equal(.OK)
  }
}
