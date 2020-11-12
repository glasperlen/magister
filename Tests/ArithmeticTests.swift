import XCTest
@testable import Magister

final class ArithmeticTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .init([])
        match.turn = .oponent
    }
    
    func testDistance() {
        match.play(.init(), .init(0, 0))
        match.play(.init(left: 1), .init(2, 0))
        XCTAssertEqual(0.5, match.score)
    }

    func testGreater() {
        match.play(.init(), .init(0, 0))
        match.play(.init(left: 1), .init(1, 0))
        XCTAssertEqual(1, match.score)
    }

    func testLess() {
        match.play(.init(right: 1), .init(0, 0))
        match.play(.init(), .init(1, 0))
        XCTAssertEqual(0.5, match.score)
    }

    func testEqual() {
        match.play(.init(right: 1), .init(0, 0))
        match.play(.init(left: 1), .init(1, 0))
        XCTAssertEqual(0.5, match.score)
    }

    func testGreaterSamePlayer() {
        match.play(.init(), .init(0, 0))
        match.play(.init(), .init(2, 2))
        match.play(.init(left: 1), .init(1, 0))
        match.play(.init(), .init(0, 2))
        XCTAssertEqual(0.5, match.score)
    }
}
