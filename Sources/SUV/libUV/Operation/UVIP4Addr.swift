import libUV

public typealias UVIP4AddrOperation = (UnsafePointer<Int8>, Int32, UnsafeMutablePointer<SockAddrIn>) -> Int32
public let UVIP4Addr: UVIP4AddrOperation = uv_ip4_addr
