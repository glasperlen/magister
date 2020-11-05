import Foundation

extension Player {
    public enum Mode: CaseIterable {
        case
        user,
        oponent,
        none
        
        static var random: Self {
            [.user, .oponent].randomElement()!
        }
        
        var next: Self {
            switch self {
            case .user: return .oponent
            case .oponent: return .user
            case .none: return .none
            }
        }
    }
}
