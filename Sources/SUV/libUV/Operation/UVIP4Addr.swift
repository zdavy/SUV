import libUV

public typealias UVIP4AddrFn = (UnsafePointer<Int8>, Int32, UnsafeMutablePointer<SockAddrIn>) -> Int32
public let UVIP4Addr: UVIP4AddrFn = uv_ip4_addr
