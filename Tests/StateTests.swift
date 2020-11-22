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
    
    func testPlaying() {
        match.robot = .init([])
        XCTAssertEqual(.playing, match.state)
    }
    
    func testPrize() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                match.play(.init(), .init(x, y))
            }
        }
        XCTAssertEqual(.prize, match.state)
    }
    
    func testFinished() {
        match.prize = .init()
        XCTAssertEqual(.finished, match.state)
    }
}
