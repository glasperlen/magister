import Foundation

extension Match {
    public struct Result: Codable, Equatable {
        public let turn: Turn
        public let bead: Bead
    }
}
