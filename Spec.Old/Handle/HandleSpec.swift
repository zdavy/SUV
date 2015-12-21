import SUV
import Swiftest

class HandleSpec: Spec {
  let spec = describe("Handle") {
    describe("close") {
      it("closes the handle") {
        let handle = Handle(TCPHandle(Loop.defaultLoop))

        expect(handle.isClosing).to.equal(false)

        handle.close { $0.free() }
        Loop.defaultLoop.run(.Default)

        expect(handle.isClosing).to.equal(true)
      }

      it("yields itself in the callback") {
        let handle = Handle(TCPHandle(Loop.defaultLoop))

        handle.close { expect($0).to.equal(handle) }
        Loop.defaultLoop.run(.Default)
      }
    }
  }
}
