import Foundation

public struct Match: Codable {
    public private(set) var state = State.new
    var players = [Turn : Player]()
    private var cells = Set(Point.all.map { Cell($0) })
    
    public init() { }
    
    public subscript(_ point: Point) -> Bead? {
        get {
            self[point]?.bead
        }
        set {
            guard case let .play(wait) = state, let bead = newValue else { return }
            self[point] = .init(player: wait.player, bead: bead)
            self[point]
                .join {
                    self[$0]
                }.forEach {
                    self[$0] = self[$0][wait.player]
                }
            
            if cells.filter({ $0.item == nil }).isEmpty {
                state = .win(.init(self[.first] > self[.second] ? .first : .second))
            } else {
                state = .play(.init(wait.player.negative))
            }
        }
    }
    
    public subscript(_ point: Point) -> Cell.Item? {
        get {
            cells.first { $0.point == point }!.item
        }
        set {
            newValue.map {
                self[point] = self[point][$0]
            }
        }
    }
    
    public subscript(_ bead: Bead) -> Bool {
        cells.contains { $0.item?.bead == bead }
    }
    
    public subscript(_ id: String) -> Turn {
        players.first { $0.1.id == id }!.0
    }
    
    public subscript(_ player: Turn) -> Player {
        players[player]!
    }
    
    public subscript(_ player: Turn) -> Int {
        cells.filter { $0.item?.player == player }.count
    }
    
    mutating public func timeout() {
        switch state {
        case let .play(wait): state = .timeout(.init(wait.player))
        case .win, .timeout: state = .cancel
        default: break
        }
    }
    
    mutating public func cancel() {
        state = .cancel
    }
    
    mutating public func join(_ player: Player) {
        players[players.isEmpty ? .first : .second] = player
        state = players.count == 2 ? .play(.init(Turn.allCases.randomElement()!)) : .matching
    }
    
    mutating public func quit(_ id: String) {
        state = .win(.init(self[id].negative))
    }
    
    mutating public func prize(_ bead: Bead) {
        switch state {
        case let .win(winner): state = .end(.init(winner: winner.player, bead: bead))
        case let .timeout(looser): state = .end(.init(winner: looser.player.negative, bead: bead))
        default: break
        }
    }
    
    subscript(_ point: Point) -> Cell {
        get {
            cells.first { $0.point == point }!
        }
        set {
            cells.remove(newValue)
            cells.insert(newValue)
        }
    }
}
