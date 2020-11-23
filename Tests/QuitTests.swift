import XCTest
@testable import Magister

final class QuitTests: XCTestCase {
    private var match: Match!

    override func setUp() {
        match = .init()
    }
    
    func testMatching() {
        match.quit()
        XCTAssertEqual(.end, match.state)
    }
    
    func testRobot() {
        match.robot = .init([])
        match.quit()
        XCTAssertEqual(.prize, match.state)
    }
}
