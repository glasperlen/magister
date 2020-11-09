import Foundation

public struct Factory {
    public static func beads(tier: Int = 0) -> Set<Bead> {
        .init((0 ..< 5).map { _ in
            .random(in: 1 ..< max(tier, 5) + (tier / 5)) + extra()
        }.map {
            (0 ..< 4).reduce(into: ([], $0)) {
                $0.0.append($1 == 3 ? $0.1 : .random(in: 0 ... $0.1))
                $0.1 -= $0.0[$1]
            }.0
        }.shuffled().map {
            .init(top: $0[0], bottom: $0[1], left: $0[2], right: $0[3])
        })
    }
    
    static func robot(tier: Int) -> Player {
        .robot(.init(beads(tier: tier)), "Robot\(Int.random(in: 0 ..< 1000))")
    }
    
    private static func extra() -> Int {
        {
            $0 > 0 ? $0 + extra() : $0
        } (.random(in: 0 ..< 4))
    }
}
