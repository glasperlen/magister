import Foundation

public struct Points: Codable {
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
}
