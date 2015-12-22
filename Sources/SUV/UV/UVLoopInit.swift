import libUV

public typealias UVLoopInitFn = (UnsafeMutablePointer<UVLoopType>) -> Int32
public let UVLoopInit: UVLoopInitFn = uv_loop_init
