import libUV

public typealias UVRunOperation = (UnsafeMutablePointer<UVLoopType>, UVRunModeType) -> Int32
public let UVRun: UVRunOperation = uv_run
