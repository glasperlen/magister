import Foundation

extension Match {
    public enum Result: Equatable {
        case
        win(Float),
        loose(Float),
        draw
    }
}
