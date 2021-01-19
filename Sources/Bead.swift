import Foundation

public struct Bead: Codable, Identifiable, Hashable {
    public var tier: Int { self[.top] + self[.bottom] + self[.left] + self[.right] }
    public let id: UUID
    public let color: Color
    private let relations: [Relation : Int]
    
    public static func make(tier: Int = 0) -> [Self] {
        (0 ..< 5).map { _ in
            .random(in: 1 ..< max(tier, 10)) + extra()
        }.map {
            (0 ..< 4).reduce(into: ([], $0)) {
                $0.0.append($1 == 3 ? $0.1 : .random(in: 0 ... $0.1))
                $0.1 -= $0.0[$1]
            }.0
        }.shuffled().map {
            .init(top: $0[0], bottom: $0[1], left: $0[2], right: $0[3])
        }
    }
    
    private static func extra() -> Int {
        {
            $0 > 0 ? $0 + extra() : $0
        } (.random(in: 0 ... 1))
    }
    
    public init(color: Color = Color.allCases.randomElement()!, top: Int = 0, bottom: Int = 0, left: Int = 0, right: Int = 0) {
        self.color = color
        relations = [.top: top, .bottom: bottom, .left: left, .right: right]
        id = .init()
    }
    
    public subscript(_ relation: Relation) -> Int {
        relations[relation]!
    }
    
    public func hash(into: inout Hasher) {
        into.combine(id)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
