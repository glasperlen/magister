import Foundation

public struct Player: Equatable {
    static func robot(_ deck: [Bead], _ name: String) -> Self {
        .init(deck, .oponent, name)
    }
    
    static func user(_ deck: [Bead]) -> Self {
        .init(deck, .user)
    }
    
    public static let none = Self()
    public internal(set) var score = 0
    public internal(set) var deck: [Item]
    public let name: String
    public let mode: Mode
    
    private init(_ deck: [Bead] = [], _ mode: Mode = .none, _ name: String = "") {
        self.deck = deck.map(Item.init)
        self.mode = mode
        self.name = name
    }
    
    public subscript(_ index: Int) -> Item {
        deck[index]
    }
    
    mutating func play(_ index: Int) -> Bead {
        deck[index].state = .played
        return deck[index].bead
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.mode == rhs.mode && lhs.score == rhs.score && lhs.deck == rhs.deck && lhs.name == rhs.name
    }
}
