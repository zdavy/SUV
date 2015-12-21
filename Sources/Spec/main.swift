import Swiftest

Swiftest.register([
    HandleSpec.self,
    StreamHandleSpec.self,
    TCPHandleSpec.self,
    HandleEquatableSpec.self,
    StatusEquatableSpec.self,
    LoopEquatableSpec.self
])

try Swiftest.run()
