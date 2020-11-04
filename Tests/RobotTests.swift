import XCTest
@testable import Magister

final class RobotTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .robot([.init()])
        match.turn = .oponent
    }
    
    func testFirst() {
        match.robot()
        XCTAssertEqual(1, match.board[.oponent])
        XCTAssertEqual(4, match[.oponent].deck.count)
        XCTAssertEqual(.user, match.turn)
    }
}
