import XCTest
@testable import Magister

final class ArithmeticTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .init()
        match.join(.user(.init(), "", []))
        match.join(.user(.init(), "", []))
    }
    
    func testDistance() {
        match[.init(0, 0)] = .init()
        match[.init(2, 0)] = .init(left: 1)
        XCTAssertEqual(match[.first], match[.second])
    }

    func testGreater() {
        if case let .play(turn) = match.state {
            match[.init(0, 0)] = .init()
            match[.init(1, 0)] = .init(left: 1)
            XCTAssertGreaterThan(match[turn.negative], match[turn])
        } else {
            XCTFail()
        }
    }

    func testLess() {
        match[.init(0, 0)] = .init(right: 1)
        match[.init(1, 0)] = .init()
        XCTAssertEqual(match[.first], match[.second])
    }

    func testEqual() {
        match[.init(0, 0)] = .init(right: 1)
        match[.init(1, 0)] = .init(left: 1)
        XCTAssertEqual(match[.first], match[.second])
    }

    func testGreaterSamePlayer() {
        match[.init(0, 0)] = .init()
        match[.init(2, 2)] = .init()
        match[.init(1, 0)] = .init(left: 1)
        match[.init(0, 2)] = .init()
        XCTAssertEqual(match[.first], match[.second])
    }
}
