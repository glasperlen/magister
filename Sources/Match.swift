import Foundation
import CoreGraphics

public struct Match {
    public internal(set) var state = State.matching
    public private(set) var cells = Set<Cell>()
    
    public var robot: Robot? {
        didSet {
            state = state.next
        }
    }
    
    public var prize: Bead? {
        didSet {
            state = .end
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
                        self[$0]!.state = state
                    }
                    return $0
                } (Cell(state: state, bead: $0, point: point)))
                
                if cells.count == 9 {
                    state = .prize
                } else {
                    state = state.next
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
    
    public subscript(_ state: State) -> Result {
        {
            switch $0 {
            case 0.5: return .draw
            case ..<0.5: return .loose($0)
            default: return .win($0)
            }
        } (cells.isEmpty ? Float(0.5) : .init(cells.filter { $0.state == state }.count) / .init(cells.count))
    }
    
    public subscript(_ bead: Bead) -> Bool {
        cells.contains { $0.bead == bead }
    }
    
    mutating public func matched() {
        state = state.next
    }
    
    mutating public func quit() {
        
    }
}
