import UV
import SUV
import Swiftest

class BacklogSpec: Spec {
    let spec = describe("Backlog") {
    describe("amount") {
      it("Max returns SoMaxConn") {
        expect(Backlog.Max.amount).to.equal(SoMaxConn)
      }

      it("Exactly returns the amount provided") {
        let amount: Int32 = 10
        expect(Backlog.Exactly(amount).amount).to.equal(amount)
      }
    }
  }
}
