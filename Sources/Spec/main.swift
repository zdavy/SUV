import Swiftest

Swiftest.register([
    HandleSpec.self,
    StreamHandleSpec.self,
    TCPHandleSpec.self,
    CastSpec.self,
    LoopSpec.self,
    RunModeSpec.self,
    AddrInSpec.self,
    AddrSpec.self,
    BacklogSpec.self,
    INetSpec.self,
    StatusSpec.self,
    HandleEquatableSpec.self,
    LoopEquatableSpec.self,
    StatusEquatableSpec.self
])

try Swiftest.run()
