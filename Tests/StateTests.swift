import XCTest
@testable import Magister

final class StateTests: XCTestCase {
    private var match: Match!

    override func setUp() {
        match = .init()
    }
    
    func testInitial() {
        XCTAssertEqual(.new, match.state)
    }
    
    func testMultiplayer() {
        match.multiplayer()
        XCTAssertEqual(.matching, match.state)
    }
    
    func testRobot() {
        match.robot = .init([])
        XCTAssertTrue(match.state == .first || match.state == .second)
    }
    
    func testMatched() {
        match.matched()
        XCTAssertTrue(match.state == .first || match.state == .second)
    }
    
    func testPrizeMultiplayer() {
        match.state = .first
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                match[.init(x, y)] = .init()
            }
        }
        XCTAssertEqual(.prizeFirst, match.state)
    }
    
    func testPrizeRobot() {
        match.state = .first
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                match[.init(x, y)] = .init()
            }
        }
        XCTAssertEqual(.prizeFirst, match.state)
    }
    
    func testRemove() {
        match.robot = .init([])
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match[.init(x, y)] = Cell(state: .first, bead: .init(), point: .init(x, y))
            }
        }
        match.state = .first
        match[.init(0, 0)] = .init()
        XCTAssertEqual(.remove, match.state)
    }
    
    func testFinished() {
        match.state = .prizeFirst
        match.prize = .init()
        XCTAssertEqual(.end, match.state)
    }
    
    func testRemoved() {
        match.state = .remove
        match.removed()
        XCTAssertEqual(.end, match.state)
    }
}
