import Foundation

public struct Player {
    static func robot(deck: [Bead], name: String) -> Self {
        .init(deck: deck, mode: .oponent, name: name)
    }
    
    static func user(deck: [Bead]) -> Self {
        .init(deck: deck, mode: .user, name: "")
    }
    
    public static let none = Self(deck: [], mode: .oponent, name: "")
    public internal(set) var score = 0
    public internal(set) var deck: [Bead]
    public let mode: Mode
    public let name: String
}
