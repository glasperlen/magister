import Foundation

public struct Points: Codable {
    var sum: Int { top + bottom + left + right }
    public let top: Int
    public let bottom: Int
    public let left: Int
    public let right: Int
    
    init(_ points: [Int]) {
        top = points[0]
        bottom = points[1]
        left = points[2]
        right = points[3]
    }
    
    init(top: Int = 0, bottom: Int = 0, left: Int = 0, right: Int = 0) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }
}
