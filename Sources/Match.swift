import Foundation

public struct Match {
    public internal(set) var turn = Player.allCases.randomElement()!
    public private(set) var result: Result?
    public let oponent: Oponent
    public var score: Float { cells.isEmpty ? 0 : .init(cells.filter { $0.player == .user }.count) / .init(cells.count) }
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
        let cell = Cell(player: turn, bead: bead, point: point)
        cell.join {
            self[$0]
        }.forEach {
            self[$0]!.player = turn
        }
        cells.insert(cell)
        
        if cells.count == 9 {
            switch score {
            case 0.5: result = .draw
            case ..<0.5: result = .loose
            default: result = .win
            }
        } else {
            turn = turn.next
        }
    }
}
