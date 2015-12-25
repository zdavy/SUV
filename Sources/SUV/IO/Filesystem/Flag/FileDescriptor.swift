public enum FileDescriptor {
  public static let StdIn: Int32 = 0
  public static let StdOut: Int32 = 1
  public static let StdErr: Int32 = 2

  case STDIN
  case STDOUT
  case STDERR
  case FILE(File)

  public var flag: Int32 {
    switch self {
      case STDIN: return FileDescriptor.StdIn
      case STDOUT: return FileDescriptor.StdOut
      case STDERR: return FileDescriptor.StdErr
      case FILE(let file): return file.ref
    }
  }
}
