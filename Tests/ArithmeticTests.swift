import XCTest
@testable import Magister

final class ArithmeticTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .init()
    }
    
    func testDistance() {
        match[0, 0] = .init()
        match[2, 0] = .init(points: .init(left: 1))
        XCTAssertEqual(0, match[.user])
        XCTAssertEqual(0, match[.oponent])
    }
    
    func testGreater() {
        match[0, 0] = .init()
        match[1, 0] = .init(points: .init(left: 1))
        XCTAssertEqual(-1, match[match.turn])
        XCTAssertEqual(1, match[match.turn.next])
        XCTAssertEqual(match.turn.next, match.board[0, 0]?.player)
        XCTAssertEqual(match.turn.next, match.board[1, 0]?.player)
    }
    
    func testLess() {
        match[0, 0] = .init(points: .init(right: 1))
        match[1, 0] = .init()
        XCTAssertEqual(0, match[.user])
        XCTAssertEqual(0, match[.oponent])
    }
    
    func testEqual() {
        match[0, 0] = .init(points: .init(right: 1))
        match[1, 0] = .init(points: .init(left: 1))
        XCTAssertEqual(0, match[.user])
        XCTAssertEqual(0, match[.oponent])
    }
    
    func testGreaterSamePlayer() {
        match[0, 0] = .init()
        match[2, 2] = .init()
        match[1, 0] = .init(points: .init(left: 1))
        XCTAssertEqual(0, match[match.turn])
        XCTAssertEqual(0, match[match.turn.next])
    }
}
