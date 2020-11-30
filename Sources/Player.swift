import Foundation

public struct Player: Codable {
    public let id: UUID
    public let name: String
    public let beads: [Bead]
    
    public static func robot(_ user: Self) -> Self {
        .init(.init(), "Robot\(Int.random(in: 0 ..< 100))", Bead.make(tier: user.beads.map(\.tier).max() ?? 0))
    }
    
    private init(_ id: UUID, _ name: String, _ beads: [Bead]) {
        self.id = id
        self.name = name
        self.beads = beads
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
