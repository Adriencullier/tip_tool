import TipKit

/// Aims to define a Tip intializable with a FeatureTipProtocol
struct FeatureTip: Tip {
    // MARK: - Properties
    /// Feature id related to the feature tip
    let featureId: String
    /// Title of the tip
    let title: Text
    /// Message of the tip
    var message: Text?
    /// Message of the tip
    let image: Image?
    /// Rules of the tip
    let rules: [Rule]
    
    // MARK: - Init
    init(tip: any TipProtocol) {
        self.featureId = tip.rawValue
        self.title = .init(tip.title)
        if let message = tip.message {
            self.message = .init(message)
        }
        self.image = tip.image
        self.rules = tip.rules.map({ rule in
            Rule(.init(id: rule.eventId)) { don in
                PredicateExpressions.build_Comparison(
                    lhs: PredicateExpressions.build_KeyPath(
                        root: PredicateExpressions.build_KeyPath(
                            root: PredicateExpressions.build_Arg(don),
                            keyPath: \.donations
                        ),
                        keyPath: \.count
                    ),
                    rhs: PredicateExpressions.build_Arg(rule.triggerCount),
                    op: .greaterThanOrEqual
                )
            }
        })
    }
}
