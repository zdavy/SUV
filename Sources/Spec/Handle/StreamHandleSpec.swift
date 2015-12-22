import SUV
import Swiftest

class StreamHandleSpec: Spec {
    let spec = describe("StreamHandle") {
      describe("initialize") {
        it("can be initialized from a HandleType") {
          let handleType = MockHandleType()

          let streamHandle = StreamHandle(handleType)

          expect(streamHandle.loop).to.equal(handleType.loop)
          expect(streamHandle.pointer).to.equal(handleType.pointer)
        }

        it("can be initialized from a Handle pointer") {
          let pointer = UnsafeMutablePointer<UVStreamType>.alloc(sizeof(UVStreamType))
          pointer.memory.loop = Loop.defaultLoop.pointer

          let streamHandle = StreamHandle(pointer)

          expect(streamHandle.loop).to.equal(Loop.defaultLoop)
          expect(streamHandle.pointer).to.equal(pointer)
        }
      }

      describe("listen") {
        it("yields the stream-handle pointer to the Listen function") {
          let streamHandle = StreamHandle(MockHandleType())

          let listen = Listen.Custom({ streamHandlePointer, backlog, onConnection in
            expect(streamHandlePointer).to.equal(streamHandle.pointer)
            return 0
          })

          streamHandle.listen(listen) { _, _ in }
        }

        it("yields the max number of connections by default") {
          let streamHandle = StreamHandle(MockHandleType())

          let listen = Listen.Custom({ streamHandlePointer, backlog, onConnection in
            expect(backlog).to.equal(Backlog.Max.amount)
            return 0
          })

          streamHandle.listen(listen) { _, _ in }
        }

        it("yields the number of connections when provided") {
          let streamHandle = StreamHandle(MockHandleType())
          let amount: Int32 = 10

          let listen = Listen.Custom({ streamHandlePointer, backlog, onConnection in
            expect(backlog).to.equal(amount)
            return 0
          })

          streamHandle.listen(listen, .Exactly(amount)) { _, _ in }
        }

        it("executes the provided callback in the ConnectionCallback") {
          let streamHandle = StreamHandle(MockHandleType())

          let listen = Listen.Custom({ streamHandlePointer, backlog, onConnection in
            onConnection(streamHandlePointer, 0)
            return 0
          })

          var closeCallbackExecuted = false

          streamHandle.listen(listen) { _, _ in
            closeCallbackExecuted = true
          }

          expect(closeCallbackExecuted).to.equal(true)
        }

        it("return .OK when listen is successful") {
          let streamHandle = StreamHandle(MockHandleType())

          let listen = Listen.Custom({ streamHandlePointer, backlog, onConnection in
            onConnection(streamHandlePointer, 0)
            return 0
          })

          expect(streamHandle.listen(listen) { _,_ in }).to.equal(.OK)
        }

        it("return .Fail with code when listen is not successful") {
          let streamHandle = StreamHandle(MockHandleType())
          let code: Int32 = -1

          let listen = Listen.Custom({ streamHandlePointer, backlog, onConnection in
            onConnection(streamHandlePointer, 0)
            return code
          })

          expect(streamHandle.listen(listen) { _,_ in }).to.equal(.Fail(code))
        }
      }

      describe("accept") {
        it("try to accept a connection with the provided stream") {
          let streamHandle = StreamHandle(MockHandleType())
          let connection = StreamHandle(MockHandleType())

          let accept = Accept.Custom({ connectionPointer, streamHandlePointer in
            expect(connectionPointer).to.equal(connection.pointer)
            expect(streamHandlePointer).to.equal(streamHandle.pointer)
            return 0
          })

          streamHandle.accept(connection, accept)
        }

        it("return .OK when accept is successful") {
          let streamHandle = StreamHandle(MockHandleType())
          let connection = StreamHandle(MockHandleType())

          let accept = Accept.Custom({ connectionPointer, streamHandlePointer in
            return 0
          })

          expect(streamHandle.accept(connection, accept)).to.equal(.OK)
        }

        it("return .Fail with code when listen is not successful") {
          let streamHandle = StreamHandle(MockHandleType())
          let connection = StreamHandle(MockHandleType())
          let code: Int32 = -1

          let accept = Accept.Custom({ connectionPointer, streamHandlePointer in
            return code
          })

          expect(streamHandle.accept(connection, accept)).to.equal(.Fail(code))
        }
      }

      describe("read") {
        it("yields the stream-handle pointer to the Listen function") {
          let streamHandle = StreamHandle(MockHandleType())

          let readStart = ReadStart.Custom({ streamHandlePointer, onAlloc, onRead in
            expect(streamHandlePointer).to.equal(streamHandle.pointer)
            return 0
          })

          streamHandle.read(readStart) { _,_,_ in }
        }

        it("executes the provided callback in the onRead function") {
          let streamHandle = StreamHandle(MockHandleType())

          let readStart = ReadStart.Custom({ streamHandlePointer, onAlloc, onRead in
            onRead(streamHandlePointer, 0, UnsafeMutablePointer<UVBufferType>.alloc(sizeof(UVBufferType)))
            return 0
          })

          var closeCallbackExecuted = false

          streamHandle.read(readStart) { _,_,_ in
            closeCallbackExecuted = true
          }

          expect(closeCallbackExecuted).to.equal(true)
        }


        it("return .OK when read is successful") {
          let streamHandle = StreamHandle(MockHandleType())

          let readStart = ReadStart.Custom({ _,_,_ in
            return 0
          })

          expect(streamHandle.read(readStart) { _,_,_ in }).to.equal(.OK)
        }

        it("return .Fail with code when listen is not successful") {
          let streamHandle = StreamHandle(MockHandleType())
          let code: Int32 = -1

          let readStart = ReadStart.Custom({ _,_,_ in
            return code
          })

          expect(streamHandle.read(readStart) { _,_,_ in }).to.equal(.Fail(code))
        }
      }

      describe("close") {
        it("creates a handle from itself and executes close") {
          let streamHandle = StreamHandle(MockHandleType())

          let callback = Close.Custom({ handlePointer, _ in
            expect(handlePointer).to.equal(Handle(streamHandle).pointer)
          })

          streamHandle.close(callback) { _ in }
        }

        it("executes the provided callback in the Close function") {
          let streamHandle = StreamHandle(MockHandleType())

          let callback = Close.Custom({ handlePointer, closeCallback in
            closeCallback(handlePointer)
          })

          var closeCallbackExecuted = false

          streamHandle.close(callback) { _ in
            closeCallbackExecuted = true
          }

          expect(closeCallbackExecuted).to.equal(true)
        }
      }
    }
}
