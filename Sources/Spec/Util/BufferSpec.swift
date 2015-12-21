import SUV
import Swiftest

class BufferSpec: Spec {
    let spec = describe("Buffer") {
      describe("initialize") {
        it("can take a reference and size and passes it to BufferInit") {
          let ref = UnsafePointer<UVBufferType>(UnsafeMutablePointer<UVBufferType>.alloc(sizeof(UVBufferType)))
          let size = 10

          BufferInit = { buffer, size in
            expect(buffer).to.equal(ref.memory.base)
            expect(size).to.equal(size)
            return UVBufferType()
          }

          let _ = Buffer(ref, size)
        }

        it("can initialize without any parameters") {
          let bufSize = sizeof(CChar)
          let pointer = UnsafeMutablePointer<CChar>.alloc(bufSize)

          BufferInit = { buffer, size in
            expect(size).to.equal(UInt32(bufSize))
            expect(buffer.memory).to.equal(pointer.memory)
            return UVBufferType()
          }

          let _ = Buffer()
        }
      }
    }
}
