import SUV
import Swiftest

class StatusSpec: Spec {
    let spec = describe("Status") {
    it("OK when code equals 0") {
      let status = Status(0)
      expect(status).to.equal(.OK)
    }

    it("Fail when code is not equal to 0") {
      let code: Int32 = -1
      let status = Status(code)
      expect(status).to.equal(.Fail(code))
    }
  }
}
