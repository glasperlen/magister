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
        get { fatalError() }
        set {
            board[x, y] = .init(player: turn, bead: newValue)
            Compare.make(bead: newValue, x: x, y: y).forEach {
                guard
                    let active = board[$0.compareX, $0.compareY],
                    active.player != turn,
                    $0.defeat(active.bead)
                else { return }
                self[turn] += 1
                self[turn.next] -= 1
                board[$0.compareX, $0.compareY]!.player = turn
            }
            turn = turn.next
        }
    }
}
