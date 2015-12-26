import SUV
import Swiftest

class IdleHandleSpec: Spec {
  let spec = describe("IdleHandle") {
    describe("initialize") {
      describe("when initialized with a loop") {
        it("assigns the loop") {
          let idleHandle = IdleHandle(Loop.defaultLoop)
          expect(idleHandle.loop).to.equal(Loop.defaultLoop)
        }

        it("passes the loop's pointer and the pointer to the 'uv_idle_init' method") {
          var idlePointer: UnsafeMutablePointer<UVIdleType>!
          let uv_idle_init: IdleInit = { loop, pointer in
            expect(loop).to.equal(Loop.defaultLoop.pointer)
            idlePointer = pointer

            return 0
          }

          let idleHandle = IdleHandle(Loop.defaultLoop, uv_idle_init: uv_idle_init)
          expect(idlePointer).to.equal(idleHandle.pointer)
        }

        it("sets status as .OK if 'uv_idle_init' is successful") {
          let uv_idle_init: IdleInit = { _,_ in
            return 0
          }

          let idleHandle = IdleHandle(Loop.defaultLoop, uv_idle_init: uv_idle_init)
          expect(idleHandle.status).to.equal(.OK)
        }

        it("sets status to .Fail with code if 'uv_idle_init' is not successful") {
          let code: Int32 = -1
          let uv_idle_init: IdleInit = { _,_ in
            return code
          }

          let idleHandle = IdleHandle(Loop.defaultLoop, uv_idle_init: uv_idle_init)
          expect(idleHandle.status).to.equal(.Fail(code))
        }
      }

      describe("when initialzed with a pointer") {
        it("assigns the pointer, and gets the loop from the provided pointer") {
          let pointer = UnsafeMutablePointer<UVIdleType>.alloc(sizeof(UVIdleType))
          let idleHandle = IdleHandle(pointer)

          expect(idleHandle.pointer).to.equal(pointer)
          expect(idleHandle.loop).to.equal(Loop(pointer.memory.loop))
        }

        it("sets the status as .OK") {
          let pointer = UnsafeMutablePointer<UVIdleType>.alloc(sizeof(UVIdleType))
          let idleHandle = IdleHandle(pointer)

          expect(idleHandle.status).to.equal(.OK)
        }
      }
    }
    describe("start") {
      it("passes the pointer to the 'uv_idle_start' method") {
        let idleHandle = IdleHandle(Loop.defaultLoop)

        let uv_idle_start: IdleStart = { idle,_ in
          expect(idle).to.equal(idleHandle.pointer)

          return 0
        }

        idleHandle.start(uv_idle_start: uv_idle_start) { _ in }
      }

      it("executes the provided callback in the callback-hook") {
        let idleHandle = IdleHandle(Loop.defaultLoop)

        let uv_idle_start: IdleStart = { idle,callback in
          callback(idle)
          return 0
        }

        var callbackCalled = false

        idleHandle.start(uv_idle_start: uv_idle_start) { _ in
          callbackCalled = true
        }

        expect(callbackCalled).to.equal(true)
      }

      it("returns status as .OK if 'uv_idle_start' is successful") {
        let idleHandle = IdleHandle(Loop.defaultLoop)

        let uv_idle_start: IdleStart = { _,_ in
          return 0
        }

        expect(idleHandle.start(uv_idle_start: uv_idle_start) { _ in }).to.equal(.OK)
      }

      it("returns status to .Fail with code if 'uv_idle_start' is not successful") {
        let code: Int32 = -1
        let idleHandle = IdleHandle(Loop.defaultLoop)

        let uv_idle_start: IdleStart = { _,_ in
          return code
        }

        expect(idleHandle.start(uv_idle_start: uv_idle_start) { _ in }).to.equal(.Fail(code))
      }
    }

    describe("stop") {
      it("passes the pointer to the 'uv_idle_stop' method") {
        let idleHandle = IdleHandle(Loop.defaultLoop)

        let uv_idle_stop: IdleStop = { idle in
          expect(idle).to.equal(idleHandle.pointer)

          return 0
        }

        idleHandle.stop(uv_idle_stop: uv_idle_stop)
      }

      it("returns status as .OK if 'uv_idle_stop' is successful") {
        let idleHandle = IdleHandle(Loop.defaultLoop)

        let uv_idle_stop: IdleStop = { _ in
          return 0
        }

        expect(idleHandle.stop(uv_idle_stop: uv_idle_stop)).to.equal(.OK)
      }

      it("returns status to .Fail with code if 'uv_idle_stop' is not successful") {
        let code: Int32 = -1
        let idleHandle = IdleHandle(Loop.defaultLoop)

        let uv_idle_stop: IdleStop = { _ in
          return code
        }

        expect(idleHandle.stop(uv_idle_stop: uv_idle_stop)).to.equal(.Fail(code))
      }
    }
  }
}
