import Foundation

public enum Player: CaseIterable {
    case
    first,
    second
    
    var next: Self {
        switch self {
        case .first: return .second
        case .second: return .first
        }
    }
}
