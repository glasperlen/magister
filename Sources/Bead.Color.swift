import Foundation

extension Bead {
    public enum Color: UInt8, Codable, CaseIterable {
        case
        blue,
        pink,
        red,
        orange,
        green,
        yellow,
        teal,
        purple,
        indigo
    }
}
