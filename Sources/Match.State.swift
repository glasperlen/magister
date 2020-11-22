import Foundation

extension Match {
    public enum State: UInt8, Codable {
        case
        matching,
        playing,
        prize,
        finished
    }
}
