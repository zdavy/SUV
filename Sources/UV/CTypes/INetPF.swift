#if os(OSX)
  @_exported import Darwin
  public let INetPF = UInt32(PF_INET)
#else
  @_exported import Glibc
  public let INetPF = UInt32(2)
#endif
