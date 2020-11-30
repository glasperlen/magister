import Foundation

public struct Match: Codable {
    public internal(set) var state = State.new
    public private(set) var players = [Turn : Player]()
    public private(set) var cells = Set<Cell>()
    
    public init() { }
    
    public subscript(_ point: Point) -> Bead {
        get {
            cells.first { $0.point == point }!.bead
        }
        set {
            guard case let State.play(turn) = state else { return }
            cells.insert({
                $0.join {
                    self[$0]
                }.forEach {
                    self[$0]!.player = turn
                }
                return $0
            } (Cell(player: turn, bead: newValue, point: point)))
            
            if cells.count == 9 {
                state = .win(self[.first] > self[.second] ? .first : .second)
            } else {
                state = .play(turn.negative)
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
    
    public subscript(_ bead: Bead) -> Bool {
        cells.contains { $0.bead == bead }
    }
    
    public subscript(_ id: UUID) -> Turn {
        players.first { $0.1.id == id }!.0
    }
    
    public subscript(_ player: Turn) -> Int {
        cells.filter { $0.player == player }.count
    }
    
    mutating public func join(_ player: Player) {
        players[players.isEmpty ? .first : .second] = player
        state = players.count == 2 ? .play(Turn.allCases.randomElement()!) : .matching
    }
    
    mutating public func timeout() {
        guard case let State.play(turn) = state else { return }
        state = .timeout(turn)
    }
    
    mutating public func quit(_ id: UUID) {
        state = .win(self[id].negative)
    }
}
