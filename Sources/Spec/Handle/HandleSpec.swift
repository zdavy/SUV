import UV
import SUV
import Swiftest

class HandleSpec: Spec {
  let spec = describe("Handle") {
    describe("initialize") {
      it("can be initialized from a HandleType") {
        let handleType = MockHandleType()

        let handle = Handle(handleType)

        expect(handle.loop).to.equal(handleType.loop)
        expect(handle.pointer).to.equal(handleType.pointer)
      }

      it("can be initialized from a Handle pointer") {
        let pointer = UnsafeMutablePointer<UVHandleType>.alloc(sizeof(UVHandleType))
        pointer.memory.loop = Loop.defaultLoop.pointer

        let handle = Handle(pointer)

        expect(handle.loop).to.equal(Loop.defaultLoop)
        expect(handle.pointer).to.equal(pointer)
      }
    }

    describe("close") {
      it("yields the handle pointer to the Close function") {
        let handle = Handle(MockHandleType())

        let callback = Close.Custom({ handlePointer, callback in
          expect(handlePointer).to.equal(handle.pointer)
        })

        handle.close(callback) { _ in }
      }

      it("executes the provided callback in the closeCallback") {
        let handle = Handle(MockHandleType())

        let callback = Close.Custom({ handlePointer, callback in
          callback(handlePointer)
        })

        var closeCallbackExecuted = false

        handle.close(callback) { _ in
          closeCallbackExecuted = true
        }

        expect(closeCallbackExecuted).to.equal(true)
      }
    }
  }
}
