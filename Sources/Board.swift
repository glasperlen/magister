import Foundation

public struct Board {
    private(set) var players = Set([Player(order: .first), .init(order: .second)])
    private var cells = Array(repeating: Cell(), count: 9)
    
    public init() { }
    
    subscript(_ x: Int, _ y: Int) -> Cell.Active? {
        get {
            cells[x * 3 + y].active
        }
        set {
            cells[x * 3 + y].active = newValue
            if x > 0 {
                self[.first].score -= 1
                self[.second].score += 1
            }
        }
    }
    
    subscript(_ order: Player.Order) -> Player {
        get {
            players.first { $0.order == order }!
        }
        set {
            players.remove(newValue)
            players.insert(newValue)
        }
    }
}
