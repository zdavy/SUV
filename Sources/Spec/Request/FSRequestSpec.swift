import SUV
import Swiftest

class FSRequestSpec: Spec {
    let spec = describe("FSRequest") {
      describe("initialize") {
        it("is initialized with a UVFSType pointer") {
          let pointer = UnsafeMutablePointer<UVFSType>.alloc(sizeof(UVFSType))
          let request = FSRequest(pointer)

          expect(request.pointer).to.equal(pointer)
          expect(request.loop).to.equal(Loop(pointer.memory.loop))
        }
      }

      describe("cleanup") {
        it("passses the pointer to uv_fs_req_cleanup") {
          let pointer = UnsafeMutablePointer<UVFSType>.alloc(sizeof(UVFSType))
          let request = FSRequest(pointer)

          let cleanup: UVFSRequestCleanupOperation = { request in
            expect(request).to.equal(pointer)
          }

          request.cleanup(cleanup)
        }
      }

      describe("result") {
        it("gets the result File from the pointer") {
          let pointer = UnsafeMutablePointer<UVFSType>.alloc(sizeof(UVFSType))
          let request = FSRequest(pointer)

          expect(request.result).to.equal(File(UVFile(pointer.memory.result)))
        }
      }

      describe("close") {
        it("passses the requests loop, a new pointer,  to uv_fs_req_close") {
          let pointer = UnsafeMutablePointer<UVFSType>.alloc(sizeof(UVFSType))
          let request = FSRequest(pointer)

          let close: UVFSCloseOperation = { loop, closeRequest, file, _ in
            expect(closeRequest).notTo.equal(pointer)
            expect(loop).to.equal(request.loop.pointer)
            expect(file).to.equal(request.result.ref)

            return 0
          }

          request.close(close)
        }

        it("passes nil as the close callback by default") {
          let pointer = UnsafeMutablePointer<UVFSType>.alloc(sizeof(UVFSType))
          let request = FSRequest(pointer)

          let close: UVFSCloseOperation = { _,_,_, callback in
            expect(callback == nil).to.equal(true)

            return 0
          }

          request.close(close)
        }

        it("executes the callback in the callback-hook if there is a callback provided") {
          let pointer = UnsafeMutablePointer<UVFSType>.alloc(sizeof(UVFSType))
          let request = FSRequest(pointer)

          let close: UVFSCloseOperation = { _,request,_, callback in
            callback(request)

            return 0
          }

          var callbackCalled = false

          request.close(close) { _ in
            callbackCalled = true
          }

          expect(callbackCalled).to.equal(true)
        }

        it("returns .OK if uv_fs_close is successful") {
          let request = FSRequest(UnsafeMutablePointer<UVFSType>.alloc(sizeof(UVFSType)))

          let close: UVFSCloseOperation = { _,_,_,_ in
            return 0
          }

          expect(request.close(close)).to.equal(.OK)
        }

        it("returns .Fail with the code if uv_fs_close is not successful") {
          let code: Int32 = -1
          let request = FSRequest(UnsafeMutablePointer<UVFSType>.alloc(sizeof(UVFSType)))

          let close: UVFSCloseOperation = { _,_,_,_ in
            return code
          }

          expect(request.close(close)).to.equal(.Fail(code))
        }

        it("returns .OK if uv_fs_close is successful and there is a callback provided") {
          let request = FSRequest(UnsafeMutablePointer<UVFSType>.alloc(sizeof(UVFSType)))

          let close: UVFSCloseOperation = { _,_,_,_ in
            return 0
          }

          expect(request.close(close) { _ in }).to.equal(.OK)
        }

        it("returns .Fail with the code if uv_fs_close is not successful and there is a callback provided") {
          let code: Int32 = -1
          let request = FSRequest(UnsafeMutablePointer<UVFSType>.alloc(sizeof(UVFSType)))

          let close: UVFSCloseOperation = { _,_,_,_ in
            return code
          }

          expect(request.close(close) { _ in }).to.equal(.Fail(code))
        }
      }
    }
}
