import UV
import SUV
import Swiftest

class BufferSpec: Spec {
    let spec = describe("Buffer") {
      describe("initialize") {
        it("can take a reference and size and passes it to BufferInit") {
          let ref = UnsafePointer<UVBufferType>(UnsafeMutablePointer<UVBufferType>.alloc(sizeof(UVBufferType)))
          let size = 10

          let bufferInit = BufferInit.Custom({ buffer, size in
            expect(buffer).to.equal(ref.memory.base)
            expect(size).to.equal(size)
            return UVBufferType()
          })

          let _ = Buffer(bufferInit, ref, size)
        }

        it("calls buffer init with newly alloc'd pointer") {
          let bufferInit = BufferInit.Custom({ buffer, size in
            expect(size).to.equal(UInt32(sizeof(Int8)))
            expect(buffer.memory).to.equal(UnsafeMutablePointer<Int8>.alloc(sizeof(Int8)).memory)
            return UVBufferType()
          })

          let _ = Buffer(bufferInit)
        }
      }
    }
}
