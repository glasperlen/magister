import XCTest
@testable import Magister

final class ArithmeticTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .init()
        match.state = .first
    }
    
    func testDistance() {
        match[.init(0, 0)] = .init()
        match[.init(2, 0)] = .init(left: 1)
        XCTAssertEqual(0.5, match[.first])
    }

    func testGreater() {
        match[.init(0, 0)] = .init()
        match[.init(1, 0)] = .init(left: 1)
        XCTAssertEqual(1, match[.second])
    }

    func testLess() {
        match[.init(0, 0)] = .init(right: 1)
        match[.init(1, 0)] = .init()
        XCTAssertEqual(0.5, match[.first])
    }

    func testEqual() {
        match[.init(0, 0)] = .init(right: 1)
        match[.init(1, 0)] = .init(left: 1)
        XCTAssertEqual(0.5, match[.first])
    }

    func testGreaterSamePlayer() {
        match[.init(0, 0)] = .init()
        match[.init(2, 2)] = .init()
        match[.init(1, 0)] = .init(left: 1)
        match[.init(0, 2)] = .init()
        XCTAssertEqual(0.5, match[.first])
    }
}
