import XCTest
@testable import Magister

final class PlayTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .init()
    }
    
    func testFirstMove() {
        let first = match.turn
        match[0, 0] = .init()
        XCTAssertEqual(0, match[.user])
        XCTAssertEqual(0, match[.oponent])
        XCTAssertEqual(first, match.board[0, 0]?.player)
        XCTAssertNotEqual(first, match.turn)
    }
    
    func testSecondMove() {
        match[0, 0] = .init()
        match[1, 0] = .init(points: .init(left: 1))
        XCTAssertEqual(-1, match[match.turn])
        XCTAssertEqual(1, match[match.turn.next])
        XCTAssertEqual(match.turn.next, match.board[0, 0]?.player)
        XCTAssertEqual(match.turn.next, match.board[1, 0]?.player)
    }
}
