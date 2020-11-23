import XCTest
@testable import Magister

final class ScoreTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .init()
        match.state = .second
    }
    
    func testInitial() {
        XCTAssertEqual(0.5, match[.first])
        XCTAssertEqual(0.5, match[.second])
    }
    
    func testFirstTurn() {
        match[.init(0, 0)] = .init()
        XCTAssertEqual(1, match[.second])
        XCTAssertEqual(0, match[.first])
    }
    
    func test1Second() {
        match[.init(0, 0)] = .init()
        match[.init(2, 2)] = .init()
        XCTAssertEqual(0.5, match[.first])
        XCTAssertEqual(0.5, match[.second])
    }
}
