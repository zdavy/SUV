public protocol AddrType {
  typealias Type
  var pointer: UnsafeMutablePointer<Type> { get }
}
