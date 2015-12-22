import UV
import SUV
import Swiftest

class WriteRequestSpec: Spec {
    let spec = describe("WriteRequest") {
      describe("initialize") {
        it("can be initialized with a pointer") {
          let pointer = UnsafeMutablePointer<UVWriteType>.alloc(sizeof(UVWriteType))
          let writeRequest = WriteRequest(pointer)

          expect(writeRequest.pointer).to.equal(pointer)
        }
      }

      describe("write") {
        it("passes the pointer and provided stream & buffer to Write") {
          let writeRequest = WriteRequest()
          let stream = StreamHandle(MockHandleType())
          let buffer = Buffer()

          let write = Write.Custom({ writeRequestPointer, streamPointer, bufferPointer, _, _ in
            expect(writeRequestPointer).to.equal(writeRequest.pointer)
            expect(streamPointer).to.equal(stream.pointer)
            expect(bufferPointer).to.equal(buffer.pointer)
            return 0
          })

          writeRequest.write(stream, buffer, write) { _,_ in }
        }

        it("returns .OK if Write is successful") {
          let writeRequest = WriteRequest()
          let stream = StreamHandle(MockHandleType())
          let buffer = Buffer()

          let write = Write.Custom({ _, _, _, _, _ in
            return 0
          })

          expect(writeRequest.write(stream, buffer, write) { _,_ in }).to.equal(.OK)
        }

        it("returns .Fail with code if Write is not successful") {
          let code: Int32 = -1
          let writeRequest = WriteRequest()
          let stream = StreamHandle(MockHandleType())
          let buffer = Buffer()

          let write = Write.Custom({ _, _, _, _, _ in
            return code
          })

          expect(writeRequest.write(stream, buffer, write) { _,_ in }).to.equal(.Fail(code))
        }

        it("executes the provided callback in the WriteCallback") {
          let writeRequest = WriteRequest()
          let stream = StreamHandle(MockHandleType())
          let buffer = Buffer()

          let write = Write.Custom({ pointer, _, _, _, writeCallback in
            writeCallback(pointer, 0)
            return 0
          })

          var closeCallbackExecuted = false

          writeRequest.write(stream, buffer, write) { _, _ in
            closeCallbackExecuted = true
          }

          expect(closeCallbackExecuted).to.equal(true)
        }
      }
    }
}
