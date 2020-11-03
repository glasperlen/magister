import Foundation

public enum Player: CaseIterable {
    case
    user,
    oponent
    
    static var random: Self {
        allCases.randomElement()!
    }
    
    var next: Self {
        switch self {
        case .user: return .oponent
        case .oponent: return .user
        }
    }
}
