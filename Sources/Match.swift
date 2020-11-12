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
        Point.all
            .filter { point in !cells.contains { $0.point == point } }
            .flatMap { point in
                oponent.beads
                    .filter { bead in !cells.contains { $0.bead.id == bead.id } }
                    .map {
                        Cell(player: turn, bead: $0, point: point)
                    }
            }.max {
                $0.join {
                    self[$0]
                }.count < $1.join {
                    self[$0]
                }.count
            }.map {
                play($0.bead, $0.point)
            }
    }
    
    mutating public func play(_ bead: Bead, _ point: Point) {
        cells.insert({
            $0.join {
                self[$0]
            }.forEach {
                self[$0]!.player = turn
            }
            return $0
        } (Cell(player: turn, bead: bead, point: point)))
        
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
