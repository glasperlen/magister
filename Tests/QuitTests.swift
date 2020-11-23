import XCTest
@testable import Magister

final class QuitTests: XCTestCase {
    private var match: Match!

    override func setUp() {
        match = .init()
    }
    
    func testNew() {
        match.quit()
        XCTAssertEqual(.end, match.state)
    }
    
    func testMatching() {
        match.multiplayer()
        match.quit()
        XCTAssertEqual(.end, match.state)
    }
    
    func testRobot() {
        match.robot = .init([])
        match.state = .second
        match.quit()
        XCTAssertEqual(.remove, match.state)
    }
    
    func testFirst() {
        match.state = .first
        match.quit()
        XCTAssertEqual(.prizeSecond, match.state)
    }
    
    func testSecond() {
        match.state = .second
        match.quit()
        XCTAssertEqual(.prizeFirst, match.state)
    }
}
