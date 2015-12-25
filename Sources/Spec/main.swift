import Swiftest

Swiftest.register([
    HandleSpec.self,
    StreamHandleSpec.self,
    TCPHandleSpec.self,
    CastSpec.self,
    LoopSpec.self,
    RunModeSpec.self,
    FilesystemRequestSpec.self,
    FSSpec.self,
    WriteRequestSpec.self,
    AddrInSpec.self,
    AddrSpec.self,
    BacklogSpec.self,
    INetSpec.self,
    StatusSpec.self,
    BufferSpec.self,
    FileSpec.self,
    FileEquatableSpec.self,
    HandleEquatableSpec.self,
    StatusEquatableSpec.self,
    LoopEquatableSpec.self
])

try Swiftest.run()
