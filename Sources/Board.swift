import Foundation

public struct Board {
    private var cells = Set((0 ..< 3).flatMap { x in
        (0 ..< 3).map { y in
            Cell(point: .init(x: x, y: y))
        }
    })
    
    public init() { }
    
    var empty: Set<Point> {
        .init(cells.filter { $0.active == nil }.map(\.point))
    }
    
    public subscript(_ x: Int, _ y: Int) -> Cell.Active? {
        get { self[.init(x: x, y: y)] }
        set { self[.init(x: x, y: y)] = newValue }
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
    
    subscript(_ player: Player.Mode) -> Int {
        cells.filter { $0.active?.player == player }.count
    }
}
