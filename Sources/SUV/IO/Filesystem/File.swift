public class File {
  public let ref: UVFile

  public var size: Int {
    return Int(ref)
  }

  public init(_ ref: UVFile) {
    self.ref = ref
  }
}
