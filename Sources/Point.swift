import Foundation

public struct Point: Codable, Hashable {
    static let all = Set((0 ..< 3).flatMap { x in
        (0 ..< 3).map { y in
            Self(x, y)
        }
    })
    
    public let x: Int
    public let y: Int
    
    var relations: Set<Relation> {
        var list = Set<Relation>()
        if x > 0 {
            list.insert(.left)
        }
        if x < 2 {
            list.insert(.right)
        }
        if y > 0 {
            list.insert(.top)
        }
        if y < 2 {
            list.insert(.bottom)
        }
        return list
    }
    
    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    subscript(_ relation: Relation) -> Point {
        switch relation {
        case .top: return .init(x, y - 1)
        case .bottom: return .init(x, y + 1)
        case .left: return .init(x - 1, y)
        case .right: return .init(x + 1, y)
        }
    }
    
    public func hash(into: inout Hasher) {
        into.combine(x)
        into.combine(y)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}
