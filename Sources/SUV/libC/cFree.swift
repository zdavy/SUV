#if os(OSX)
  @_exported import Darwin
  public let cFree = Darwin.free
#else
  @_exported import Glibc
  public let cFree = Glibc.free
#endif
