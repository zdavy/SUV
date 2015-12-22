#if os(OSX)
  @_exported import Darwin
  public typealias SockAddrIn = sockaddr_in
#else
  @_exported import Glibc
  public typealias SockAddrIn = sockaddr_in
#endif
