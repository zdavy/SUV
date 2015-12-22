#if os(OSX)
  @_exported import Darwin
  public typealias SockAddr = sockaddr
#else
  @_exported import Glibc
  public typealias SockAddr = sockaddr
#endif
