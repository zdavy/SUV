import SUV
import Swiftest

class FileSpec: Spec {
    let spec = describe("File") {
      describe("initalize") {
        it("sets the provided file as the ref") {
          let uvFile = UVFile()
          let file = File(UVFile())

          expect(file.ref).to.equal(uvFile)
        }
      }

      describe("size") {
        it("converts the ref to an Int") {
          let size = 1
          let file = File(UVFile(size))

          expect("\(file.size.dynamicType)").to.equal("Int")
          expect(file.size).to.equal(size)
        }
      }
    }
}
