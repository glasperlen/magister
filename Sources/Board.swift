import Foundation

public struct Board: Equatable {
    private var cells = Set((0 ..< 3).flatMap { x in
        (0 ..< 3).map { y in
            Cell(point: .init(x, y))
        }
    })
    
    public init() { }
    
    public subscript(_ x: Int, _ y: Int) -> Cell.Active? {
        get { self[.init(x, y)] }
        set { self[.init(x, y)] = newValue }
    }
    
    subscript(_ point: Point) -> Cell.Active? {
        get {
            cells.first { $0.point == point }!.active
        }
        set {
            let cell = Cell(active: newValue, point: point)
            cells.remove(cell)
            cells.insert(cell)
        }
    }
    
    subscript(_ player: Player.Mode?) -> Set<Point> {
        .init(cells.filter { $0.active?.player == player }.map(\.point))
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.cells == rhs.cells
    }
}
