import Foundation

public struct Player: Hashable {
    public var score = 0
    let order: Order
    
    public func hash(into: inout Hasher) {
        into.combine(order)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.order == rhs.order
    }
}
