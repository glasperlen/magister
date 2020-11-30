import Foundation

extension Match {
    public enum Turn: UInt8, Codable, CaseIterable {
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
