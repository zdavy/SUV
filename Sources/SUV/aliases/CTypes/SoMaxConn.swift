#if os(OSX)
  @_exported import Darwin
  public let SoMaxConn = SOMAXCONN
#else
  @_exported import Glibc
  public let SoMaxConn = SOMAXCONN
#endif
