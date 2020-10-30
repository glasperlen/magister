import Foundation

public struct Factory {
    public static func make(_ count: Int) -> Set<Bead> {
        .init((0 ..< count).map { _ in
            points
        }.map {
            (0 ..< 4).reduce(into: ([], $0)) {
                $0.0.append(.random(in: 0 ... $0.1))
                $0.1 -= $0.0[$1]
            }.0
        }.shuffled().map(Points.init).map {
            .init(Bead.Color.allCases[.random(in: 0 ..< Bead.Color.allCases.count)], $0)
        })
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
