import Foundation

public struct Cell: Hashable {
    public internal(set) var state: Match.State
    public let bead: Bead
    let point: Point
    
    func join(transform: (Point) -> Self?) -> [Point] {
        point.relations.compactMap { relation in
            transform(point[relation]).map { cell in
                (relation, cell)
            }
        }.filter {
            $1.state != state
        }.filter { relation, cell in
            {
                switch relation {
                case .top: return $0 > cell.bead[.bottom]
                case .bottom: return $0 > cell.bead[.top]
                case .left: return $0 > cell.bead[.right]
                case .right: return $0 > cell.bead[.left]
                }
            } (bead[relation])
        }.map(\.1.point)
    }
    
    public func hash(into: inout Hasher) {
        into.combine(point)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.point == rhs.point
    }
}
