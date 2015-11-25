import SUV

let server = TCPHandle(Loop.defaultLoop)
server.bind(Addr(AddrIn("0.0.0.0", 8000)))

StreamHandle(server).listen { connection, status in
  let client = StreamHandle(TCPHandle(connection.loop))
  client.read(connection) { stream, result, buffer in
    WriteRequest(stream).write(buffer)
  }
}

Loop.defaultLoop.run(.Default)
