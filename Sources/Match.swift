import Foundation

public struct Match {
    public internal(set) var turn = Player.allCases.randomElement()
    public private(set) var result: Result?
    public let oponent: Oponent
    
    public var score: Float {
        cells.isEmpty ? 0 : .init(cells.filter { $0.player == .user }.count) / .init(cells.count)
    }
    
    private var cells = Set<Cell>()
    
    public init(_ user: [Bead]) {
        oponent = Factory.oponent(user: user)
    }
    
    public subscript(_ point: Point) -> Cell? {
        get {
            cells.first { $0.point == point }
        }
        set {
            newValue.map {
                cells.remove($0)
                cells.insert($0)
            }
        }
    }
    
    mutating public func robot() {
//        cells.filter { $0.active == nil }.map(\.point).flatMap { point in
//            oponent.beads.filter { bead in !cells.contains { $0.active.bead == bead } }.map {
//                Combo(success: point.attacks($0).filter(success).count, point: point)
//            }
//        }.max {
//            $0.success < $1.success
//        }.map {
//            play($0.bead, $0.point)
//        }
    }
    
    mutating public func play(_ bead: Bead, _ point: Point) {
//        board[point] = .init(player: turn, bead: bead)
//        point.attacks(bead).filter(success).forEach {
//            players[turn]!.score += 1
//            players[turn.next]!.score -= 1
//            board[$0.point]!.player = turn
//        }
//
//        if board[nil].isEmpty {
//            finish.send({
//                switch self[.user].score {
//                case self[.oponent].score ...: return .win
//                case ..< self[.oponent].score: return .loose(.random(in: 0 ..< 5))
//                default: return .draw
//                }
//            } ())
//        } else {
//            turn = turn.next
//        }
    }
    
    private func success(_ attack: Attack) -> Bool {
        guard
            let active = self[attack.point],
            active.player != turn,
            attack.defense(active.bead)
        else { return false }
        return true
    }
}
