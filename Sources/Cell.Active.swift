import Foundation

extension Cell {
    public struct Active {
        public internal(set) var player: Player.Mode
        public let bead: Bead
    }
}
