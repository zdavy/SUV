extension File: Equatable {
}

public func ==(l: File, r: File) -> Bool {
  return l.ref == r.ref
}
