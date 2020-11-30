import Foundation

extension Match {
    public enum State: Decodable {
        case
        new,
        matching,
        cancel,
        play(Turn),
        timeout(Turn),
        win(Turn),
        end(Bead)
        
        public init(from decoder: Decoder) throws {
            self = {
                (try? $0.decodeIfPresent(Key.self, forKey: .matching)).map { _ in
                    .matching
                } ?? (try? $0.decodeIfPresent(Key.self, forKey: .cancel)).map { _ in
                    .cancel
                } ?? (try? $0.decodeIfPresent(Turn.self, forKey: .play)).map {
                    .play($0)
//                } ?? (try? $0.decodeIfPresent(Turn.self, forKey: .timeout)).map {
//                    .timeout($0)
                } ?? (try? $0.decodeIfPresent(Turn.self, forKey: .win)).map {
                    .win($0)
                } ?? (try? $0.decodeIfPresent(Bead.self, forKey: .end)).map {
                    .end($0)
                }
            } (try decoder.container(keyedBy: Key.self)) ?? .new
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
