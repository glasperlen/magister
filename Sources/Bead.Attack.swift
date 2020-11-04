import Foundation

extension Bead {
    struct Attack: Hashable {
        let bead: Bead
        let point: Board.Point
        let relation: Board.Relation
        
        func defense(_ with: Bead) -> Bool {
            switch relation {
            case .top: return bead[.top] > with[.bottom]
            case .bottom: return bead[.bottom] > with[.top]
            case .left: return bead[.left] > with[.right]
            case .right: return bead[.right] > with[.left]
            }
        }
        
        func hash(into: inout Hasher) {
            into.combine(point)
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.point == rhs.point  
        }
    }
}
