import XCTest
@testable import Magister

final class PlayTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .robot([.init()])
    }
    
    func testFirstMove() {
        let first = match.turn
        match[first].deck = [.init()]
        match.play(index: 0, x: 0, y: 0)
        XCTAssertEqual(0, match[.user].score)
        XCTAssertEqual(0, match[.oponent].score)
        XCTAssertTrue(match[first].deck.isEmpty)
        XCTAssertEqual(first, match.board[0, 0]?.player)
        XCTAssertNotEqual(first, match.turn)
    }
    
    func testSecondMove() {
        match[match.turn].deck = [.init()]
        match.play(index: 0, x: 0, y: 0)
        match[match.turn].deck = [.init(points: .init(left: 1))]
        match.play(index: 0, x: 1, y: 0)
        XCTAssertEqual(-1, match[match.turn].score)
        XCTAssertEqual(1, match[match.turn.next].score)
        XCTAssertEqual(match.turn.next, match.board[0, 0]?.player)
        XCTAssertEqual(match.turn.next, match.board[1, 0]?.player)
    }
}
