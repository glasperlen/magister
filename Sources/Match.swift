import Foundation

public struct Match: Equatable {
    public static let off = Match(players: [.user : .none, .oponent : .none])
    public internal(set) var board = Board()
    public internal(set) var turn = Player.Mode.random
    private var players: [Player.Mode : Player]
    private let id = UUID()
    
    public static func robot(_ deck: [Bead]) -> Self {
        .init(players: [.user : .user(deck: deck), .oponent : Factory.robot(deck.max { $0.tier < $1.tier }!.tier)])
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
        board[nil].flatMap { point in
            self[turn].deck.enumerated().map {
                Bead.Combo(success: point.attacks($0.1).filter(score).count, index: $0.0, point: point)
            }
        }.max {
            $0.success < $1.success
        }.map {
            play($0.index, $0.point)
        }
    }
    
    mutating public func play(_ index: Int, _ point: Board.Point) {
        let bead = self[turn].deck.remove(at: index)
        board[point] = .init(player: turn, bead: bead)
        point.attacks(bead).filter(score).forEach {
            self[turn].score += 1
            self[turn.next].score -= 1
            board[$0.point]!.player = turn
        }
        turn = turn.next
    }
    
    private func score(_ attack: Bead.Attack) -> Bool {
        guard
            let active = board[attack.point],
            active.player != turn,
            attack.defense(active.bead)
        else { return false }
        return true
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
