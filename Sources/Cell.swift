import Foundation

public struct Cell: Hashable {
    public var active: Active?
    let point: Board.Point
    
    public func hash(into: inout Hasher) {
        into.combine(point)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.point == rhs.point
    }
}
