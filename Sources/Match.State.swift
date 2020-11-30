import Foundation

extension Match {
    public enum State: Codable, Equatable {
        case
        new,
        matching,
        cancel,
        play(Turn),
        timeout(Turn),
        win(Turn),
        end(Bead)
        
        public init(from: Decoder) throws {
            self = try {
                if try $0.decodeIfPresent(Key.self, forKey: .matching) != nil {
                    return .matching
                }
                if try $0.decodeIfPresent(Key.self, forKey: .cancel) != nil {
                    return .cancel
                }
                if let turn = try $0.decodeIfPresent(Turn.self, forKey: .play) {
                    return .play(turn)
                }
                if let turn = try $0.decodeIfPresent(Turn.self, forKey: .timeout) {
                    return .timeout(turn)
                }
                if let turn = try $0.decodeIfPresent(Turn.self, forKey: .win) {
                    return .win(turn)
                }
                if let bead = try $0.decodeIfPresent(Bead.self, forKey: .end) {
                    return .end(bead)
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
            case let .play(turn): try container.encode(turn, forKey: .play)
            case let .timeout(turn): try container.encode(turn, forKey: .timeout)
            case let .win(turn): try container.encode(turn, forKey: .win)
            case let .end(bead): try container.encode(bead, forKey: .end)
            }
        }
        
        private enum Key: String, Codable, CodingKey {
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
