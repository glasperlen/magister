import Foundation

extension Match {
    public struct Wait: Codable, Equatable {
        public let player: Turn
        public let timeout: Date
        
        init(_ player: Turn) {
            self.player = player
            timeout = Calendar.current.date(byAdding: .minute, value: 1, to: .init())!
        }
    }
}
