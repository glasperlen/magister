import Foundation

extension Match {
    public enum State: UInt8, Codable {
        case
        new,
        matching,
        first,
        second,
        prizeRobot,
        prizeFirst,
        prizeSecond,
        remove,
        end
        
        var next: Self {
            switch self {
            case .first: return .second
            case .second: return .first
            default: return [.first, .second].randomElement()!
            }
        }
    }
}
