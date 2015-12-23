import libUV

public typealias UVLoopInitOperation = (UnsafeMutablePointer<UVLoopType>) -> Int32
public let UVLoopInit: UVLoopInitOperation = uv_loop_init
