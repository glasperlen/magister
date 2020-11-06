import Foundation
import Combine

public struct Match: Equatable {
    public static let off = Match(turn: .none, players: [.user : .none, .oponent : .none])
    public internal(set) var board = Board()
    public internal(set) var turn = Player.Mode.random
    public let finish = PassthroughSubject<Player.Mode, Never>()
    private var players: [Player.Mode : Player]
    
    private var winning: Player.Mode {
        self[.user].score > self[.oponent].score ? .user
            : self[.user].score < self[.oponent].score ? .oponent
            : .none
    }
    
    private let id = UUID()
    
    public static func robot(_ deck: [Bead]) -> Self {
        .init(players: [.user : .user(deck: deck), .oponent : Factory.robot(tier: deck.map(\.tier).max()!)])
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
        
        if board[nil].isEmpty {
            finish.send(winning)
        } else {
            turn = turn.next
        }
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
        lhs.id == rhs.id && lhs.turn == rhs.turn && lhs.board == rhs.board && lhs.players == rhs.players
    }
}
