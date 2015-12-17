extension Status: Equatable {
}

public func ==(l: Status, r: Status) -> Bool {
  switch (l, r) {
    case (.OK, .OK): return true
    case (let .Fail(code1), let .Fail(code2)): return code1 == code2
    default: return false
  }
}
