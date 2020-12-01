import Foundation

public struct Match: Codable {
    public private(set) var cells = Set<Cell>()
    public private(set) var state = State.new
    var players = [Turn : Player]()
    
    public init() { }
    
    public subscript(_ point: Point) -> Bead {
        get {
            cells.first { $0.point == point }!.bead
        }
        set {
            guard case let .play(turn) = state else { return }
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
    
    public subscript(_ id: String) -> Turn {
        players.first { $0.1.id == id }!.0
    }
    
    public subscript(_ player: Turn) -> Player {
        players[player]!
    }
    
    public subscript(_ player: Turn) -> Int {
        cells.filter { $0.player == player }.count
    }
    
    mutating public func timeout() {
        guard case let .play(turn) = state else { return }
        state = .timeout(turn)
    }
    
    mutating public func cancel() {
        state = .cancel
    }
    
    mutating public func join(_ player: Player) {
        players[players.isEmpty ? .first : .second] = player
        state = players.count == 2 ? .play(Turn.allCases.randomElement()!) : .matching
    }
    
    mutating public func quit(_ id: String) {
        state = .win(self[id].negative)
    }
    
    mutating public func prize(_ bead: Bead) {
        switch state {
        case let .win(winner): state = .end(.init(winner: winner, bead: bead))
        case let .timeout(looser): state = .end(.init(winner: looser.negative, bead: bead))
        default: break
        }
    }
}
