import Foundation

public struct Robot {
    public internal(set) var beads: [Bead]
    public let name: String
    public let player = Player.first
    
    public init(_ user: [Bead]) {
        beads = Factory.beads(tier: user.map(\.tier).max() ?? 0)
        name = "Robot\(Int.random(in: 0 ..< 100))"
    }
    
    func play(_ match: Match) -> Cell? {
        Point.all
            .filter { point in !match.cells.contains { $0.point == point } }
            .flatMap { point in
                beads
                    .filter { !match.played($0) }
                    .map {
                        Cell(player: player, bead: $0, point: point)
                    }
            }.max {
                $0.join {
                    match[$0]
                }.count < $1.join {
                    match[$0]
                }.count
            }
    }
}
