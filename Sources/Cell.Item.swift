import Foundation

extension Cell {
    public struct Item: Codable {
        public internal(set) var player: Match.Turn
        public let bead: Bead
    }
}
