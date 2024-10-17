import TipKit

@MainActor
public final class TipTool: ObservableObject {
    // MARK: - Properties
    /// Store all the Tips of the app
    private let tips: [FeatureTip]
    
    // MARK: - Init
    /// TipManager init
    /// - Parameters:
    ///   - eventIds: ids used to register each event at app launch
    ///   - tips: all the tips information used to create tips
    public init(eventIds: [String], tips: [any TipProtocol]) {
        do {
            try Tips.resetDatastore()
            // Tips congiguration
            try Tips.configure()
        } catch {
            print(error.localizedDescription)
        }
        self.tips = tips.map({ FeatureTip(tip: $0) })
        self.registerEvents(eventIds)
    }
    
    // MARK: - Public static functions
    /// Aims to trigger a event on Tips Event related to eventId
    /// - Parameter eventId: Event's eventId
    public static func trigger(_ eventId: String) {
        Task {
            await Tips.Event(id: eventId).donate()
        }
    }
    
    // MARK: - Internal functions
    /// Aims to get Tip according to a feature tip Id
    /// - Parameter featureId: id of the feature tip
    /// - Returns: FeatureTip
    func getTip(_ featureId: String) -> FeatureTip {
        guard let tip = self.tips.first(where: { $0.featureId == featureId }) else {
            fatalError("This case shouldn't happen")
        }
        return tip
    }
    
    // MARK: - Private functions
    /// Aims to register tips events according to an array of events ids
    /// - Parameter eventsIds: array of event ids to register
    private func registerEvents(_ eventsIds: [String]) {
        _ = eventsIds.map({
            Tips.Event(id: $0)
        })
    }
}
