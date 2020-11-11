import Foundation

public enum Player: CaseIterable {
    case
    user,
    oponent
    
    var next: Self {
        switch self {
        case .user: return .oponent
        case .oponent: return .user
        }
    }
}
