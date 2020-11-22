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
        match[.init(0, 0)] = .init()
        XCTAssertEqual(.win(1), match[.second])
        XCTAssertEqual(.loose(0), match[.first])
    }
    
    func test1Second() {
        match[.init(0, 0)] = .init()
        match[.init(2, 2)] = .init()
        XCTAssertEqual(.draw, match[.first])
        XCTAssertEqual(.draw, match[.second])
    }
}
