import Foundation
import Combine

public struct Match: Equatable {
    public static let off = Match()
    public internal(set) var turn: Player.Mode
    public internal(set) var board = Board()
    public let finish = PassthroughSubject<Result, Never>()
    var players: [Player.Mode : Player]
    
    private var winning: Player.Mode {
        self[.user].score > self[.oponent].score ? .user
            : self[.user].score < self[.oponent].score ? .oponent
            : .none
    }
    
    private let id = UUID()
    
    public static func robot(_ deck: [Bead]) -> Self {
        .init([.user : .user(deck), .oponent : Factory.robot(tier: deck.map(\.tier).max()!)])
    }
    
    private init() {
        turn = .none
        players = [.user : .none, .oponent : .none]
    }
    
    init(_ players: [Player.Mode : Player]) {
        self.players = players
        turn = .random
    }
    
    public subscript(_ player: Player.Mode) -> Player {
        players[player]!
    }
    
    mutating public func robot() {
        board[nil].flatMap { point in
            (0 ..< self[turn].deck.count).filter { self[turn][$0].state == .waiting }.map {
                Bead.Combo(success: point.attacks(self[turn][$0].bead).filter(score).count, index: $0, point: point)
            }
        }.max {
            $0.success < $1.success
        }.map {
            play($0.index, $0.point)
        }
    }
    
    mutating public func play(_ index: Int, _ point: Board.Point) {
        let bead = players[turn]!.play(index)
        board[point] = .init(player: turn, bead: bead)
        point.attacks(bead).filter(score).forEach {
            players[turn]!.score += 1
            players[turn.next]!.score -= 1
            board[$0.point]!.player = turn
        }
        
        if board[nil].isEmpty {
            finish.send({
                switch winning {
                case .none: return .draw
                case .user: return .win
                case .oponent: return .loose(.random(in: 0 ..< 5))
                }
            } ())
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
