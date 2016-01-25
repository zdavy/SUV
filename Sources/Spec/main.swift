import Swiftest

Swiftest.register([
    HandleSpec.self,
    IdleHandleSpec.self,
    StreamHandleSpec.self,
    TCPHandleSpec.self,
    CastSpec.self,
    LoopSpec.self,
    RunModeSpec.self,
    FSRequestSpec.self,
    FSSpec.self,
    WriteRequestSpec.self,
    AddrInSpec.self,
    AddrSpec.self,
    BacklogSpec.self,
    INetSpec.self,
    StatusSpec.self,
    BufferSpec.self,
    HandleEquatableSpec.self,
    StatusEquatableSpec.self,
    LoopEquatableSpec.self
])

try Swiftest.run()
