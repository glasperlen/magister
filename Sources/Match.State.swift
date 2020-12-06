import Foundation

extension Match {
    public enum State: Codable, Equatable {
        case
        new,
        matching,
        cancel,
        play(Wait),
        timeout(Wait),
        win(Wait),
        end(Result)
        
        public init(from: Decoder) throws {
            self = try {
                if try $0.decodeIfPresent(Key.self, forKey: .matching) != nil {
                    return .matching
                }
                if try $0.decodeIfPresent(Key.self, forKey: .cancel) != nil {
                    return .cancel
                }
                if let wait = try $0.decodeIfPresent(Wait.self, forKey: .play) {
                    return .play(wait)
                }
                if let wait = try $0.decodeIfPresent(Wait.self, forKey: .timeout) {
                    return .timeout(wait)
                }
                if let wait = try $0.decodeIfPresent(Wait.self, forKey: .win) {
                    return .win(wait)
                }
                if let result = try $0.decodeIfPresent(Result.self, forKey: .end) {
                    return .end(result)
                }
                return .new
            } (from.container(keyedBy: Key.self))
        }
        
        public func encode(to: Encoder) throws {
            var container = to.container(keyedBy: Key.self)
            switch self {
            case .new: try container.encode(Key.new, forKey: .new)
            case .matching: try container.encode(Key.matching, forKey: .matching)
            case .cancel: try container.encode(Key.cancel, forKey: .cancel)
            case let .play(wait): try container.encode(wait, forKey: .play)
            case let .timeout(wait): try container.encode(wait, forKey: .timeout)
            case let .win(wait): try container.encode(wait, forKey: .win)
            case let .end(result): try container.encode(result, forKey: .end)
            }
        }
        
        private enum Key: Int, Codable, CodingKey {
            case
            new,
            matching,
            cancel,
            play,
            timeout,
            win,
            end
        }
    }
}
