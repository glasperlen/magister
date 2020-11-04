import Foundation

public struct Factory {
    public static func beads(_ count: Int) -> Set<Bead> {
        .init((0 ..< count).map { _ in
            points
        }.map {
            (0 ..< 4).reduce(into: ([], $0)) {
                $0.0.append(.random(in: 0 ... $0.1))
                $0.1 -= $0.0[$1]
            }.0
        }.shuffled().map(Bead.Points.init).map {
            .init(points: $0)
        })
    }
    
    static func robot(_ tier: Int) -> Player {
        .init(deck: .init(beads((tier * 2) + 5).sorted { $0.tier > $1.tier }.prefix(5)), mode: .oponent, name: "Robot\(Int.random(in: 0 ..< 100_000))")
    }
    
    private static var points: Int {
        .random(in: 1 ..< 16) + extra()
    }
    
    private static func extra() -> Int {
        {
            $0 == 2 ? $0 + extra() : $0
        } (.random(in: 0 ..< 3))
    }
}
