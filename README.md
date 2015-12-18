## SUV

_depends on libuv version 1.7.5r1_

libUV bindings for swift. This is still very much a Work-In-Progress, meaning
and a lot might (and very likely will) change. Stay tuned.

### Installation using Swift Package Manager

Add this line to your `Package.swift` file.

  ```swift
  .Package(url: "https://github.com/zachmokahn/SUV.git", Version(0,0,1))
  ```

## Use

Import SUV, write some code, and start the event loop.

  ```swift
    /* /project/path/Sources/EchoSerer/main.swift */

    import SUV

    let server = TCPHandle(Loop.defaultLoop)
    server.bind(Addr(AddrIn("0.0.0.0", 8000)))

    StreamHandle(server).listen { connection, status in
      let client = StreamHandle(TCPHandle(connection.loop))
      client.read(connection) { stream, result, buffer in
        WriteRequest().write(stream, buffer) { request, status in
          request.free()
          client.close { $0.free() }
        }
      }
    }

    Loop.defaultLoop.run(.Default)
  ```

More Examples Can be found at the
[SUVExamples](https://github.com/zachmokahn/SUVExamples) repo