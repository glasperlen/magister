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
            if x > 0 {
//                self[.first].score -= 1
//                self[.second].score += 1
            }
        }
    }
}
