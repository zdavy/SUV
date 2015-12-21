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
      it("yields the handle pointer to the closeCallback") {
        let handle = Handle(MockHandleType())

        Close = { handlePointer, callback in
          expect(handlePointer).to.equal(handle.pointer)
        }

        handle.close { _ in }
      }

      it("executes the provided callback in the closeCallback") {
        let handle = Handle(MockHandleType())

        Close = { handlePointer, callback in
          callback(handlePointer)
        }

        var closeCallbackExecuted = false

        handle.close { _ in
          closeCallbackExecuted = true
        }

        expect(closeCallbackExecuted).to.equal(true)
      }
    }
  }
}
