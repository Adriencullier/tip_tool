import SwiftUICore

/// Aims define a tip
public protocol TipProtocol: RawRepresentable where Self.RawValue == String {
    /// Title of the tip
    var title: String { get }
    /// Message of the tip
    var message: String? { get }
    /// Image of the tip
    var image: Image? { get }
    /// Rules related of the tip
    var rules: [TipRule] { get }
}
