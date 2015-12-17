public protocol HandleType {
  typealias Type
  var pointer: UnsafeMutablePointer<Type> { get }
  var loop: Loop { get }
}
