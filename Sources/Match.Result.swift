import Foundation

extension Match {
    public enum Result {
        case
        draw,
        win,
        loose(UUID)
    }
}
