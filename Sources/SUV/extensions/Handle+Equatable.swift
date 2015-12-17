extension Handle: Equatable {
}

public func ==(l: Handle, r: Handle) -> Bool {
  return l.pointer == r.pointer
}
