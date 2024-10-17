import SwiftUI
import TipKit

/// Aims to define a view which handle the TipView display
public struct FeatureTipView<Content: View>: View {
    // MARK: - Properties
    @EnvironmentObject var tipTool: TipTool
    @Binding private var invalidate: Bool
    let featureId: String
    let viewMode: TipViewMode
    let content: Content
    
    // MARK: - Init
    public init(featureId: String,
                viewMode: TipViewMode = .popover(),
                invalidate: Binding<Bool> = .constant(false),
                content: () -> Content) {
        self.featureId = featureId
        self.viewMode = viewMode
        self._invalidate = invalidate
        self.content = content()
    }
    
    // MARK: - Body
    public var body: some View {
        Group {
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
        .onChange(of: self.invalidate) {
            self.tipTool.invalidateTip(self.featureId)
        }
    }
}
