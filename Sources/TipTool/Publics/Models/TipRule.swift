import Foundation

/// Aims to define a Tip Rule
public struct TipRule {
    // MARK: - Properties
    /// Id of the event related to the rule
    var eventId: String
    /// The rule condition will be reach if the event donations is >= that value
    var triggerCount: Int
    
    // MARK: - Init
    public init(eventId: String, triggerCount: Int) {
        self.eventId = eventId
        self.triggerCount = triggerCount
    }
}
