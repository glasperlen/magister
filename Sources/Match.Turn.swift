import Foundation

extension Match {
    public enum Turn: Int, Codable, CaseIterable {
        case
        first,
        second
        
        public var negative: Self {
            switch self {
            case .first: return .second
            case .second: return .first
            }
        }
    }
}
