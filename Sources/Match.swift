import Foundation
import CoreGraphics

public struct Match {
    public var drop: Point?
    public var positions = [Point : CGRect]()
    public internal(set) var turn = Player.allCases.randomElement()!
    public internal(set) var oponent: Oponent
    public private(set) var result: Result?
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
    
    public func played(_ bead: Bead) -> Bool {
        cells.contains { $0.bead == bead }
    }
    
    mutating public func robot() {
        Point.all
            .filter { point in !cells.contains { $0.point == point } }
            .flatMap { point in
                oponent.beads
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
