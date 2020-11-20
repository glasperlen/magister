import Foundation

public enum Player: CaseIterable {
    case
    user,
    opponent
    
    var next: Self {
        switch self {
        case .user: return .opponent
        case .opponent: return .user
        }
    }
}
