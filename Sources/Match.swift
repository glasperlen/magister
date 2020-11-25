import Foundation

public struct Match: Codable {
    public internal(set) var state = State.new
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
    
    public subscript(_ point: Point) -> Bead {
        get {
            cells.first { $0.point == point }!.bead
        }
        set {
            cells.insert({
                $0.join {
                    self[$0]
                }.forEach {
                    self[$0]!.state = state
                }
                return $0
            } (Cell(state: state, bead: newValue, point: point)))
            
            if cells.count == 9 {
                state = {
                    switch $0 {
                    case ..<0.5: return robot == nil ? .prizeSecond : .prizeRobot
                    default: return robot == nil ? .prizeFirst : .remove
                    }
                } (self[.first])
            } else {
                state = state.next
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
    
    public subscript(_ state: State) -> Float {
        cells.isEmpty ? 0.5 : .init(cells.filter { $0.state == state }.count) / .init(cells.count)
    }
    
    public subscript(_ bead: Bead) -> Bool {
        cells.contains { $0.bead == bead }
    }
    
    mutating public func multiplayer() {
        state = .matching
    }
    
    mutating public func matched() {
        state = state.next
    }
    
    mutating public func removed() {
        state = .end
    }
    
    mutating public func quitFirst() {
        state = {
            switch state {
            case .new, .matching: return .end
            case .first, .second: return robot == nil ? .prizeSecond : .prizeRobot
            default: return state
            }
        } ()
    }
    
    mutating public func quitSecond() {
        state = {
            switch state {
            case .new, .matching: return .end
            case .first, .second: return robot == nil ? .prizeFirst : .remove
            default: return state
            }
        } ()
    }
}
