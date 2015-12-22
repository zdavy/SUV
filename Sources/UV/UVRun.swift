import libUV

public typealias UVRunFn = (UnsafeMutablePointer<UVLoopType>, UVRunModeType) -> Int32
public let UVRun: UVRunFn = uv_run
