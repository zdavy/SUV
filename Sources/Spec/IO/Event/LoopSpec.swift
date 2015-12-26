import SUV
import Swiftest

class LoopSpec: Spec {
    let spec = describe("Loop") {
    describe("initialize") {
      describe("inialized without a pointer") {
        it("initializes an event loop via LoopInit") {
          var pointer: UnsafeMutablePointer<UVLoopType>! = nil

          let loopInit: LoopInit = { loopPointer in
            pointer = loopPointer
            return 0
          }

          let loop = Loop(uv_loop_init: loopInit)
          expect(pointer).to.equal(loop.pointer)
        }

        it("status is .OK if LoopInit is successful") {
          let loopInit: LoopInit = { _ in
            return 0
          }

          expect(Loop(uv_loop_init: loopInit).status).to.equal(.OK)
        }

        it("status is .Fail with code if LoopInit is not successful") {
          let code: Int32 = -1

          let loopInit: LoopInit = { _ in
            return code
          }

          expect(Loop(uv_loop_init: loopInit).status).to.equal(.Fail(code))
        }
      }

      describe("initialized with a pointer") {
        it("des not call LoopInit") {
          var loopInitCalled = false
          let pointer = UnsafeMutablePointer<UVLoopType>.alloc(sizeof(UVLoopType))

          let _ = Loop(pointer)
          expect(loopInitCalled).to.equal(false)
        }

        it("assigns the pointer and sets the status to ok") {
          let pointer = UnsafeMutablePointer<UVLoopType>.alloc(sizeof(UVLoopType))
          let loop = Loop(pointer)

          expect(loop.pointer).to.equal(pointer)
          expect(loop.status).to.equal(.OK)
        }
      }
    }

    describe("defaultLoop") {
      it("defaultLoop is a singleton") {
        expect(Loop.defaultLoop).to.equal(Loop.defaultLoop)
      }

      it("status is .OK") {
        expect(Loop.defaultLoop.status).to.equal(.OK)
      }
    }

    describe("run") {
      it("executes the run function with the loop pointer and provided mode") {
        let loop = Loop.defaultLoop
        let mode: RunMode = .Default

        let run: Run = { loopPointer, modeValue in
          expect(loopPointer).to.equal(loop.pointer)
          expect(modeValue).to.equal(mode.value)
          return 0
        }

        loop.run(mode, uv_run: run)
      }

      it("returns .OK when Run is successful") {
        let run: Run = { _, _ in
          return 0
        }

        expect(Loop.defaultLoop.run(.Default, uv_run: run)).to.equal(.OK)
      }

      it("returns .Fail with code when Run is not successful") {
        let code: Int32 = -1

        let run: Run = { _, _ in
          return code
        }

        expect(Loop.defaultLoop.run(.Default, uv_run: run)).to.equal(.Fail(code))
      }
    }
  }
}
