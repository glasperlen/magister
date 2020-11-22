import XCTest
@testable import Magister

final class ScoreTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .init()
        match.turn = .second
    }
    
    func testInitial() {
        XCTAssertEqual(.draw, match[.first])
        XCTAssertEqual(.draw, match[.second])
    }
    
    func testFirstTurn() {
        match.play(.init(), .init(0, 0))
        XCTAssertEqual(.win(1), match[.second])
        XCTAssertEqual(.loose(0), match[.first])
    }
    
    func test1Second() {
        match.play(.init(), .init(0, 0))
        match.play(.init(), .init(2, 2))
        XCTAssertEqual(.draw, match[.first])
        XCTAssertEqual(.draw, match[.second])
    }
}
