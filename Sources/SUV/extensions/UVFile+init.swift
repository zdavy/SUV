public extension UVFile {
  init(_ descriptor: FileDescriptor) {
    switch descriptor {
      case .In: self.init(0)
      case .Out: self.init(1)
      case .Err: self.init(2)
      case .File(let file): self.init(file)
    }
  }
}
