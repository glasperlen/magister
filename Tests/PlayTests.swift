import XCTest
@testable import Magister

final class PlayTests: XCTestCase {
    private var board: Board!
    
    override func setUp() {
        board = .init()
    }
    
    func testFirstMove() {
        board[0, 0] = .init(order: .first, bead: .init(.init()))
        XCTAssertEqual(0, board[.first].score)
        XCTAssertEqual(0, board[.second].score)
    }
}
