import Foundation

public struct Bead: Codable, Hashable {
    let points: Points
    private let id: UUID
    
    init(_ points: Points) {
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
