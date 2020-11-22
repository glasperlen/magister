import XCTest
@testable import Magister

final class ArithmeticTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .init()
        match.turn = .first
    }
    
    func testDistance() {
        match.play(.init(), .init(0, 0))
        match.play(.init(left: 1), .init(2, 0))
        XCTAssertEqual(.draw, match[.first])
    }

    func testGreater() {
        match.play(.init(), .init(0, 0))
        match.play(.init(left: 1), .init(1, 0))
        XCTAssertEqual(.win(1), match[.second])
    }

    func testLess() {
        match.play(.init(right: 1), .init(0, 0))
        match.play(.init(), .init(1, 0))
        XCTAssertEqual(.draw, match[.first])
    }

    func testEqual() {
        match.play(.init(right: 1), .init(0, 0))
        match.play(.init(left: 1), .init(1, 0))
        XCTAssertEqual(.draw, match[.first])
    }

    func testGreaterSamePlayer() {
        match.play(.init(), .init(0, 0))
        match.play(.init(), .init(2, 2))
        match.play(.init(left: 1), .init(1, 0))
        match.play(.init(), .init(0, 2))
        XCTAssertEqual(.draw, match[.first])
    }
}
