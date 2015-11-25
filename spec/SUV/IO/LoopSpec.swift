import SUV
import SwiftestClient

describe("Loop") {
  describe("defaultLoop") {
    it("successfully initializes the defaultLoop") {
      let loop = Loop.defaultLoop
      expect(loop.status).to.equal(.OK)
    }

    it("defaultLoop is a singleton") {
      expect(Loop.defaultLoop).to.equal(Loop.defaultLoop)
    }
  }

  describe("new loop") {
    it("successfully initializes a new loop") {
      let loop = Loop()
      expect(loop.status).to.equal(.OK)
    }
  }
}
