import XCTest
@testable import Magister

final class ScoreTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .init([])
        match.turn = .user
    }
    
    func testInitial() {
        XCTAssertEqual(0, match.score)
    }
    
    func testFirstTuen() {
        match.play(.init(), .init(0, 0))
        XCTAssertEqual(1, match.score)
    }
    
    func test1Second() {
        match.play(.init(), .init(0, 0))
        match.play(.init(), .init(2, 2))
        XCTAssertEqual(0.5, match.score)
    }
}
