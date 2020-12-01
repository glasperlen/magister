import Foundation

extension Match {
    public struct Result: Codable, Equatable {
        public let winner: Turn
        public let bead: Bead
    }
}
