import Foundation

public struct Match {
    public internal(set) var board = Board()
    public internal(set) var turn = Player.Mode.random
    private var players: [Player.Mode : Player]
    
    public static func robot(_ deck: [Bead]) -> Self {
        .init(players: [.user : .user(deck: deck), .oponent : Factory.robot(deck.max { $0.tier > $1.tier }!.tier)])
    }
    
    public subscript(_ player: Player.Mode) -> Player {
        get {
            players[player]!
        }
        set {
            players[player] = newValue
        }
    }
    
    mutating public func robot() {
        play(index: .random(in: 0 ..< self[turn].deck.count), x: .random(in: 0 ..< 3), y: .random(in: 0 ..< 3))
    }
    
    mutating public func play(index: Int, x: Int, y: Int) {
        let bead = self[turn].deck.remove(at: index)
        board[x, y] = .init(player: turn, bead: bead)
        Compare.make(bead: bead, x: x, y: y).forEach {
            guard
                let active = board[$0.compareX, $0.compareY],
                active.player != turn,
                $0.defeat(active.bead)
            else { return }
            self[turn].score += 1
            self[turn.next].score -= 1
            board[$0.compareX, $0.compareY]!.player = turn
        }
        turn = turn.next
    }
}
