public protocol FeatureTipProtocol: RawRepresentable where Self.RawValue == String {
    
    var title: String { get }
}
