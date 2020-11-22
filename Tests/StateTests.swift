import XCTest
@testable import Magister

final class StateTests: XCTestCase {
    private var match: Match!

    override func setUp() {
        match = .init()
    }
    
    func testMatching() {
        XCTAssertEqual(.matching, match.state)
    }
    
    func testRobot() {
        match.robot = .init([])
        XCTAssertEqual(.playing, match.state)
    }
    
    func testMatched() {
        match.matched()
        XCTAssertEqual(.playing, match.state)
    }
    
    func testPrize() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                match[.init(x, y)] = .init()
            }
        }
        XCTAssertEqual(.prize, match.state)
    }
    
    func testFinished() {
        match.prize = .init()
        XCTAssertEqual(.finished, match.state)
    }
}
