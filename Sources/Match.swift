import Foundation
import CoreGraphics

public struct Match {
    public var drop: Point?
    public var positions = [Point : CGRect]()
    public internal(set) var turn = Player.allCases.randomElement()!
    public internal(set) var opponent: Opponent
    public private(set) var cells = Set<Cell>()
    public private(set) var finished = false
    
    public init(_ user: [Bead]) {
        opponent = Factory.opponent(user: user)
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
    
    public subscript(_ player: Player) -> Result {
        {
            switch $0 {
            case 0.5: return .draw
            case ..<0.5: return .loose($0)
            default: return .win($0)
            }
        } (cells.isEmpty ? Float() : .init(cells.filter { $0.player == player }.count) / .init(cells.count))
    }
    
    public func played(_ bead: Bead) -> Bool {
        cells.contains { $0.bead == bead }
    }
    
    mutating public func robot() {
        Point.all
            .filter { point in !cells.contains { $0.point == point } }
            .flatMap { point in
                opponent.beads
                    .filter { !played($0) }
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
            finished = true
        } else {
            turn = turn.next
        }
    }
}
