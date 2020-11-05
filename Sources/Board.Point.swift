import Foundation

extension Board {
    public struct Point: Hashable {
        public let x: Int
        public let y: Int
        private var top: Self { .init(x, y - 1) }
        private var bottom: Self { .init(x, y + 1) }
        private var left: Self { .init(x - 1, y) }
        private var right: Self { .init(x + 1, y) }
        
        public init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }
        
        func attacks(_ with: Bead) -> Set<Bead.Attack> {
            var list = Set<Bead.Attack>()
            if x > 0 {
                list.insert(.init(bead: with, point: left, relation: .left))
            }
            if x < 2 {
                list.insert(.init(bead: with, point: right, relation: .right))
            }
            if y > 0 {
                list.insert(.init(bead: with, point: top, relation: .top))
            }
            if y < 2 {
                list.insert(.init(bead: with, point: bottom, relation: .bottom))
            }
            return list
        }
        
        public func hash(into: inout Hasher) {
            into.combine(x)
            into.combine(y)
        }
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.x == rhs.x && lhs.y == rhs.y
        }
    }
}
