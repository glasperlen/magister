import Foundation

extension Match {
    enum Compare {
        case
        top(Bead, Int, Int),
        bottom(Bead, Int, Int),
        left(Bead, Int, Int),
        right(Bead, Int, Int)
        
        static func make(bead: Bead, x: Int, y: Int) -> [Self] {
            var array = [Self]()
            if x > 0 {
                array.append(.left(bead, x, y))
            }
            if x < 2 {
                array.append(.right(bead, x, y))
            }
            if y > 0 {
                array.append(.top(bead, x, y))
            }
            if y < 2 {
                array.append(.bottom(bead, x, y))
            }
            return array
        }
        
        var compareX: Int {
            switch self {
            case let .top(_, x, _): return x
            case let .bottom(_, x, _): return x
            case let .left(_, x, _): return x - 1
            case let .right(_, x, _): return x + 1
            }
        }
        
        var compareY: Int {
            switch self {
            case let .top(_, _, y): return y - 1
            case let .bottom(_, _, y): return y + 1
            case let .left(_, _, y): return y
            case let .right(_, _, y): return y
            }
        }
        
        func defeat(_ vs: Bead) -> Bool {
            switch self {
            case let .top(bead, _, _): return bead.points.top > vs.points.bottom
            case let .bottom(bead, _, _): return bead.points.bottom > vs.points.top
            case let .left(bead, _, _): return bead.points.left > vs.points.right
            case let .right(bead, _, _): return bead.points.right > vs.points.left
            }
        }
    }
}
