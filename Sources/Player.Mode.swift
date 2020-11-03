import Foundation

extension Player {
    public enum Mode: CaseIterable {
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
}
