extension Loop: Equatable {
}

public func ==(l: Loop, r: Loop) -> Bool {
  return l.pointer == r.pointer
}
