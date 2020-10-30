import Foundation

public struct Bead: Codable, Hashable {
    public var tier: Int { points.sum }
    public let color: Color
    public let points: Points
    public let id: UUID

    init(_ color: Color, _ points: Points) {
        self.color = color
        self.points = points
        id = .init()
    }
    
    public func hash(into: inout Hasher) {
        into.combine(id)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
