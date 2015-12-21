import SUV
import Swiftest

class CastSpec: Spec {
    let spec = describe("Cast") {
    describe("toVoid") {
      it("casts and uncasts any type to a Void pointer") {
        let wat = "Hello world"
        let void = Cast.toVoid(wat)

        expect(wat).to.equal(Cast.fromVoid(void)!)
      }
    }
  }
}
