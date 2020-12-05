import Foundation

public struct Cell: Codable, Hashable {
    public private(set) var item: Item?
    public let point: Point
    public let power: Power
    
    init(_ point: Point, _ power: Power = .none) {
        self.point = point
        self.power = power
    }
    
    subscript(_ item: Item) -> Self {
        get {
            var cell = self
            cell.item = item
            return cell
        }
        set {
            self.item = item
        }
    }
    
    subscript(_ player: Match.Turn) -> Self {
        var cell = self
        cell.item!.player = player
        return cell
    }
    
    func join(_ transform: (Point) -> Self?) -> [Point] {
        point.relations.compactMap { relation in
            transform(point[relation]).map { cell in
                (relation, cell)
            }
        }.filter {
            $1.item != nil
        }.filter {
            $1.item!.player != item!.player
        }.filter { relation, cell in
            {
                switch relation {
                case .top: return $0 > cell.item!.bead[.bottom]
                case .bottom: return $0 > cell.item!.bead[.top]
                case .left: return $0 > cell.item!.bead[.right]
                case .right: return $0 > cell.item!.bead[.left]
                }
            } (item!.bead[relation])
        }.map(\.1.point)
    }
    
    public func hash(into: inout Hasher) {
        into.combine(point)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.point == rhs.point
    }
}
