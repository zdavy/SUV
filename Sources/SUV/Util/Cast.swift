public struct Cast {
    public typealias VoidType = UnsafeMutablePointer<Void>

    public static func toVoid<Anything>(anything: Anything?) -> VoidType {
        guard let data = anything else { return VoidType() }
        return VoidType(Unmanaged.passRetained(VoidBox(data)).toOpaque())
    }

    public static func fromVoid<Something>(data: VoidType) -> Something? {
        return Unmanaged<VoidBox<Something>>.fromOpaque(COpaquePointer(data)).takeUnretainedValue().data
    }
}
