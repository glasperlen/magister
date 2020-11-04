import Foundation

public struct Board {
    private var cells = Array(repeating: Cell(), count: 9)
    
    public init() { }
    
    public subscript(_ x: Int, _ y: Int) -> Cell.Active? {
        get {
            cells[x * 3 + y].active
        }
        set {
            cells[x * 3 + y].active = newValue
        }
    }
    
    subscript(_ player: Player.Mode) -> Int {
        cells.filter { $0.active?.player == player }.count
    }
}
