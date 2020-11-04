import Foundation

extension Board {
    struct Point: Hashable {
        let x: Int
        let y: Int
        
        func hash(into: inout Hasher) {
            into.combine(x)
            into.combine(y)
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.x == rhs.x && lhs.y == rhs.y
        }
    }
}
