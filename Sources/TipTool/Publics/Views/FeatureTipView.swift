import SwiftUI
import TipKit

/// Aims to define a view which handle the TipView display
public struct FeatureTipView<Content: View>: View {
    // MARK: - Properties
    @EnvironmentObject var tipTool: TipTool
    
    let featureId: String
    let viewMode: TipViewMode
    let content: Content
    
    // MARK: - Init
    public init(featureId: String,
                viewMode: TipViewMode = .popover(),
                content: () -> Content) {
        self.featureId = featureId
        self.viewMode = viewMode
        self.content = content()
    }
    
    // MARK: - Body
    public var body: some View {
        switch self.viewMode {
        case .inline(let arrowEdge):
            VStack {
                TipView(
                    self.tipTool.getTip(self.featureId),
                    arrowEdge: arrowEdge
                )
                content
            }
        case .popover(let arrowEdge):
            content
                .popoverTip(
                    self.tipTool.getTip(self.featureId),
                    arrowEdge: arrowEdge
                )
        }
    }
}
