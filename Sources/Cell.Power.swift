import Foundation

extension Cell {
    public enum Power: Codable {
        case
        none,
        number(Int),
        color(Bead.Color)
        
        public init(from: Decoder) throws {
            self = try {
                if let number = try $0.decodeIfPresent(Int.self, forKey: .number) {
                    return .number(number)
                }
                if let color = try $0.decodeIfPresent(Bead.Color.self, forKey: .color) {
                    return .color(color)
                }
                return .none
            } (from.container(keyedBy: Key.self))
        }
        
        public func encode(to: Encoder) throws {
            var container = to.container(keyedBy: Key.self)
            switch self {
            case .none: try container.encode(Key.none, forKey: .none)
            case let .number(number): try container.encode(number, forKey: .number)
            case let .color(color): try container.encode(color, forKey: .color)
            }
        }
        
        private enum Key: String, Codable, CodingKey {
            case
            none,
            number,
            color
        }
    }
}
