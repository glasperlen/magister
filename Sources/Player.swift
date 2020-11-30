import Foundation

public struct Player: Codable {
    public let id: String
    public let name: String
    public let beads: [Bead]
    
    public static func user(_ id: String, _ name: String, _ beads: [Bead]) -> Self {
        .init(id: id, name: name, beads: beads)
    }
    
    public static func robot(_ user: Self) -> Self {
        .init(id: "", name: "Robot\(Int.random(in: 0 ..< 100))", beads: Bead.make(tier: user.beads.map(\.tier).max() ?? 0))
    }
    
    public func play(_ match: Match) -> Cell? {
        Point.all
            .filter { point in !match.cells.contains { $0.point == point } }
            .flatMap { point in
                beads
                    .filter { !match[$0] }
                    .map {
                        .init(player: match[id], bead: $0, point: point)
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
