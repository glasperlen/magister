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
        play(.random(in: 0 ..< self[turn].deck.count), board.empty.randomElement()!)
    }
    
    mutating public func play(_ index: Int, _ point: Board.Point) {
        let bead = self[turn].deck.remove(at: index)
        board[point] = .init(player: turn, bead: bead)
        point.attacks(bead).forEach {
            guard
                let active = board[$0.point],
                active.player != turn,
                $0.defense(active.bead)
            else { return }
            self[turn].score += 1
            self[turn.next].score -= 1
            board[$0.point]!.player = turn
        }
        turn = turn.next
    }
}
