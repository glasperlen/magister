import XCTest
@testable import Magister

final class QuitTests: XCTestCase {
    private var match: Match!

    override func setUp() {
        match = .init()
    }
    
    func testNewFirst() {
        match.quitFirst()
        XCTAssertEqual(.end, match.state)
    }
    
    func testNewSecond() {
        match.quitSecond()
        XCTAssertEqual(.end, match.state)
    }
    
    func testMatchingFirst() {
        match.multiplayer()
        match.quitFirst()
        XCTAssertEqual(.end, match.state)
    }
    
    func testMatchingSecond() {
        match.multiplayer()
        match.quitSecond()
        XCTAssertEqual(.end, match.state)
    }
    
    func testRobot() {
        match.robot = .init([])
        match.state = .second
        match.quitSecond()
        XCTAssertEqual(.remove, match.state)
    }
    
    func testFirst() {
        match.state = .second
        match.quitFirst()
        XCTAssertEqual(.prizeSecond, match.state)
    }
    
    func testSecond() {
        match.state = .first
        match.quitSecond()
        XCTAssertEqual(.prizeFirst, match.state)
    }
}
