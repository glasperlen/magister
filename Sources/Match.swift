import Foundation
import CoreGraphics

public struct Match {
    public var drop: Point?
    public var positions = [Point : CGRect]()
    public internal(set) var turn = Player.allCases.randomElement()!
    public private(set) var cells = Set<Cell>()
    public private(set) var state = State.matching
    
    public var robot: Robot? {
        didSet {
            state = .playing
        }
    }
    
    public var prize: Bead? {
        didSet {
            state = .finished
        }
    }
    
    public init() { }
    
    public subscript(_ point: Point) -> Bead? {
        get {
            cells.first { $0.point == point }?.bead
        }
        set {
            newValue.map {
                cells.insert({
                    $0.join {
                        self[$0]
                    }.forEach {
                        self[$0]!.player = turn
                    }
                    return $0
                } (Cell(player: turn, bead: $0, point: point)))
                
                if cells.count == 9 {
                    state = .prize
                } else {
                    turn = turn.next
                }
            }
        }
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
        } (cells.isEmpty ? Float(0.5) : .init(cells.filter { $0.player == player }.count) / .init(cells.count))
    }
    
    public subscript(_ bead: Bead) -> Bool {
        cells.contains { $0.bead == bead }
    }
    
    mutating public func matched() {
        state = .playing
    }
}
