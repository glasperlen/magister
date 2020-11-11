import Foundation

public struct Cell: Hashable {
    public internal(set) var player: Player
    public let bead: Bead
    let point: Point
    
    public func hash(into: inout Hasher) {
        into.combine(point)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.point == rhs.point
    }
}
