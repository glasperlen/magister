import Foundation

public final class Board {
    private var cells = Array(repeating: Cell(), count: 9)
    
    subscript(_ x: Int, _ y: Int) -> Bead? {
        get {
            cells[x * 3 + y].bead
        }
        set {
            cells[x * 3 + y].bead = newValue
        }
    }
}
