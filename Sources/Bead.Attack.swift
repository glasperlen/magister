import Foundation

extension Bead {
    struct Attack: Hashable {
        let bead: Bead
        let point: Board.Point
        let relation: Board.Relation
        
        func defense(_ with: Bead) -> Bool {
            switch relation {
            case .top: return bead.points.top > with.points.bottom
            case .bottom: return bead.points.bottom > with.points.top
            case .left: return bead.points.left > with.points.right
            case .right: return bead.points.right > with.points.left
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
