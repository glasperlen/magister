import Foundation

public struct Bead: Codable, Identifiable, Hashable {
    public var tier: Int { self[.top] + self[.bottom] + self[.left] + self[.right] }
    public let id: UUID
    public let color: Color
    private let relations: [Board.Relation : Int]
    
    init(color: Color = .random, top: Int = 0, bottom: Int = 0, left: Int = 0, right: Int = 0) {
        self.color = color
        relations = [.top: top, .bottom: bottom, .left: left, .right: right]
        id = .init()
    }
    
    public subscript(_ relation: Board.Relation) -> Int {
        relations[relation]!
    }
    
    public func hash(into: inout Hasher) {
        into.combine(id)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
