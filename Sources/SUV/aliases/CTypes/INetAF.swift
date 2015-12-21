#if os(OSX)
  @_exported import Darwin
  public let INetAF = UInt32(AF_INET)
#else
  @_exported import Glibc
  public let INetAF = UInt32(2)
#endif
