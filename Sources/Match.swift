import Foundation

public struct Match {
    public private(set) var board = Board()
    public private(set) var turn = Player.random
    private var score = [Player.user : 0, .oponent : 0]
    
    public init() { }
    
    public subscript(_ player: Player) -> Int {
        get {
            score[player]!
        }
        set {
            score[player] = newValue
        }
    }
    
    public subscript(_ x: Int, _ y: Int) -> Bead {
        get {
            board[x, y]!.bead
        }
        set {
            board[x, y] = .init(player: turn, bead: newValue)
            turn = turn.next
        }
    }
}
