import XCTest
@testable import Magister

final class CartesianTests: XCTestCase {
    func testAll() {
        (0 ..< 3).forEach { y1 in
            (0 ..< 3).forEach { x1 in
                (y1 - 1 ... y1 + 1).forEach { y2 in
                    (x1 - 1 ... x1 + 1).forEach { x2 in
                        if x2 >= 0
                            && y2 >= 0
                            && x2 < 3
                            && y2 < 3
                            && ((x1 == x2 && y1 != y2) || (y1 == y2 && x1 != x2)) {
                            var match = Match()
                            match[x2, y2] = .init()
                            match[x1, y1] = .init(points: .init(top: 1, bottom: 1, left: 1, right: 1))
                            XCTAssertTrue(match[match.turn.next] == 1 && match[match.turn] == -1, "\(x1),\(y1) vs \(x2),\(y2)")
                        }
                    }
                }
            }
        }
    }
}
