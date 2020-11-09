import Foundation

extension Player {
    public struct Item: Equatable {
        public internal(set) var state = State.waiting
        public let bead: Bead
        
        init(_ bead: Bead) {
            self.bead = bead
        }
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.bead.id == rhs.bead.id && lhs.state == rhs.state
        }
    }
}
