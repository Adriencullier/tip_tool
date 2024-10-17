import SwiftUICore

/// Aims to list all the possible tip view modes
public enum TipViewMode {
    /// The tip is displayed on top of the view (in a VStack)
    case inline(arrowEdge: Edge? = nil)
    /// The tip is displayed as a popover
    case popover(arrowEdge: Edge = .top)
}
