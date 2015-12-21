import libUV

public typealias UVIsClosingFn = UnsafePointer<UVHandleType> -> Int32
public let UVIsClosing: UVIsClosingFn = uv_is_closing
