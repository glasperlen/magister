import Foundation

extension Match {
    enum Compare {
        case
        top(Bead, Board.Point),
        bottom(Bead, Board.Point),
        left(Bead, Board.Point),
        right(Bead, Board.Point)
        
        static func make(_ bead: Bead, _ point: Board.Point) -> [Self] {
            var array = [Self]()
            if point.x > 0 {
                array.append(.left(bead, point))
            }
            if point.x < 2 {
                array.append(.right(bead, point))
            }
            if point.y > 0 {
                array.append(.top(bead, point))
            }
            if point.y < 2 {
                array.append(.bottom(bead, point))
            }
            return array
        }
        
        var compare: Board.Point {
            switch self {
            case let .top(_, point): return .init(x: point.x, y: point.y - 1)
            case let .bottom(_, point): return .init(x: point.x, y: point.y + 1)
            case let .left(_, point): return .init(x: point.x - 1, y: point.y)
            case let .right(_, point): return .init(x: point.x + 1, y: point.y)
            }
        }
        
        func defeat(_ vs: Bead) -> Bool {
            switch self {
            case let .top(bead, _): return bead.points.top > vs.points.bottom
            case let .bottom(bead, _): return bead.points.bottom > vs.points.top
            case let .left(bead, _): return bead.points.left > vs.points.right
            case let .right(bead, _): return bead.points.right > vs.points.left
            }
        }
    }
}
