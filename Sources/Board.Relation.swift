import Foundation

extension Board {
    public enum Relation: String, Codable, Hashable {
        case
        top,
        bottom,
        left,
        right
    }
}
