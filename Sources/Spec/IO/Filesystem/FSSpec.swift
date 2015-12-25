import SUV
import Swiftest

class FSSpec: Spec {
    let spec = describe("FS") {
      describe("initialze") {
        it("is initialzed with a loop") {
          let fs = FS(Loop.defaultLoop)
          expect(fs.loop).to.equal(Loop.defaultLoop)
        }
      }

      describe("open") {
        it("passes the loop and pointer, and provided filepath, access flag, and mode to uv_fs_open") {
          let testPath = "test.txt"
          let fs = FS(Loop.defaultLoop)

          let open = FilesystemOpen.Custom({loop, request, path, access, mode, _ in
              expect(loop).to.equal(Loop.defaultLoop.pointer)
              expect(request).to.equal(fs.pointer)
              expect(String.fromCString(path)).to.equal(testPath)
              expect(access).to.equal(Access.ReadOnly.flag)
              expect(mode).to.equal(Mode.Read(.User).flag)

              return 0
          })

          fs.open("test.txt", .ReadOnly, .Read(.User), open) { _ in }
        }

        it("executes the provided callback in the callback-hook") {
          let fs = FS(Loop.defaultLoop)

          let open = FilesystemOpen.Custom({_, request, _,_,_, callback in
              callback(request)
              return 0
          })

          var callbackCalled = false

          fs.open("test.txt", .ReadOnly, .Read(.User), open) { _ in
            callbackCalled = true
          }

          expect(callbackCalled).to.equal(true)
        }

        it("returns .OK when uv_fs_open is successful") {
          let fs = FS(Loop.defaultLoop)

          let open = FilesystemOpen.Custom({ _,_,_,_,_,_ in
              return 0
          })

          expect(fs.open("test.txt", .ReadOnly, .Read(.User), open) { _ in }).to.equal(.OK)
        }

        it("returns .Fail with code when uv_fs_open is not successful") {
          let code: Int32 = -1
          let fs = FS(Loop.defaultLoop)

          let open = FilesystemOpen.Custom({ _,_,_,_,_,_ in
              return code
          })

          expect(fs.open("test.txt", .ReadOnly, .Read(.User), open) { _ in }).to.equal(.Fail(code))
        }
      }

      describe("read") {
        it("passes the loop and pointer, and the provided file, buffer, and size, to uv_fs_read") {
          let fs = FS(Loop.defaultLoop)
          let testFile = File(UVFile(1))
          let testBuffer = Buffer()
          let testSize = 10

          let read = FilesystemRead.Custom({loop, request, file, buffer, size,_,_ in
              expect(loop).to.equal(Loop.defaultLoop.pointer)
              expect(request).to.equal(fs.pointer)
              expect(file).to.equal(testFile.ref)
              expect(buffer).to.equal(testBuffer.pointer)
              expect(size).to.equal(UInt32(testSize))

              return 0
          })

          fs.read(testFile, testBuffer, testSize, read) { _ in }
        }

        it("defaults the offset to -1 when not provided") {
          let fs = FS(Loop.defaultLoop)

          let read = FilesystemRead.Custom({ _,_,_,_,_, offset,_ in
              expect(offset).to.equal(-1)
              return 0
          })

          fs.read(File(UVFile()), Buffer(), 10, read) { _ in }
        }

        it("uses the given offset when provided") {
          let fs = FS(Loop.defaultLoop)

          let read = FilesystemRead.Custom({ _,_,_,_,_, offset,_ in
              expect(offset).to.equal(5)
              return 0
          })

          fs.read(File(UVFile()), Buffer(), 10, read, offset: 5) { _ in }
        }

        it("executes the provided callback in the callback-hook") {
          let fs = FS(Loop.defaultLoop)

          let read = FilesystemRead.Custom({_,request,_,_,_,_, callback in
              callback(request)
              return 0
          })

          var callbackCalled = false

          fs.read(File(UVFile(1)), Buffer(), 10, read) { _ in
            callbackCalled = true
          }

          expect(callbackCalled).to.equal(true)
        }

        it("returns .OK when uv_fs_read is successful") {
          let fs = FS(Loop.defaultLoop)

          let read = FilesystemRead.Custom({_,_,_,_,_,_,_ in
              return 0
          })

          expect(fs.read(File(UVFile(1)), Buffer(), 10, read) { _ in }).to.equal(.OK)
        }

        it("returns .Fail with code when uv_fs_read is not successful") {
          let code: Int32 = -1
          let fs = FS(Loop.defaultLoop)

          let read = FilesystemRead.Custom({_,_,_,_,_,_,_ in
              return code
          })

          expect(fs.read(File(UVFile(1)), Buffer(), 10, read) { _ in }).to.equal(.Fail(code))
        }
      }

      describe("write") {
        it("passes the loop and pointer, and provided output, buffer, and size to uv_fs_write") {
          let fs = FS(Loop.defaultLoop)
          let testBuffer = Buffer()
          let testSize = 10

          let write = FilesystemWrite.Custom({loop, request, output, buffer, size,_,_ in
              expect(loop).to.equal(Loop.defaultLoop.pointer)
              expect(request).to.equal(fs.pointer)
              expect(output).to.equal(FileDescriptor.STDOUT.flag)
              expect(buffer).to.equal(testBuffer.pointer)
              expect(size).to.equal(UInt32(testSize))
              return 0
          })

          fs.write(.STDOUT, testBuffer, testSize, write) { _ in }
        }

        it("defaults the offset to -1 when not provided") {
          let fs = FS(Loop.defaultLoop)

          let write = FilesystemWrite.Custom({_,_,_,_,_,offset,_ in
              expect(offset).to.equal(-1)
              return 0
          })

          fs.write(.STDOUT, Buffer(), 10, write) { _ in }
        }

        it("uses the given offset when provided") {
          let fs = FS(Loop.defaultLoop)

          let write = FilesystemWrite.Custom({_,_,_,_,_,offset,_ in
              expect(offset).to.equal(5)
              return 0
          })

          fs.write(.STDOUT, Buffer(), 10, write, offset: 5) { _ in }
        }

        it("executes the provided callback in the callback-hook") {
          let fs = FS(Loop.defaultLoop)

          let write = FilesystemWrite.Custom({_,request,_,_,_,_,callback in
              callback(request)
              return 0
          })

          var callbackCalled = false

          fs.write(.STDOUT, Buffer(), 10, write) { _ in
            callbackCalled = true
          }

          expect(callbackCalled).to.equal(true)
        }

        it("returns .OK when uv_fs_open is successful") {
          let fs = FS(Loop.defaultLoop)

          let write = FilesystemWrite.Custom({_,_,_,_,_,_,_ in
              return 0
          })

          expect(fs.write(.STDOUT, Buffer(), 10, write) { _ in }).to.equal(.OK)
        }

        it("returns .Fail with code when uv_fs_open is not successful") {
          let code: Int32 = -1
          let fs = FS(Loop.defaultLoop)

          let write = FilesystemWrite.Custom({_,_,_,_,_,_,_ in
              return code
          })

          expect(fs.write(.STDOUT, Buffer(), 10, write) { _ in }).to.equal(.Fail(code))
        }
      }
    }
}
