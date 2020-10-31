import XCTest
@testable import Magister

final class PlayTests: XCTestCase {
    private var board: Board!
    
    override func setUp() {
        board = .init()
    }
    
    func testFirstMove() {
        board[0, 0] = .init(order: .first, bead: .init(.red, .init()))
        XCTAssertEqual(0, board[.first].score)
        XCTAssertEqual(0, board[.second].score)
        XCTAssertEqual(.first, board[0, 0]?.order)
    }
    
    func testSecondMove() {
        board[0, 0] = .init(order: .first, bead: .init(.red, .init()))
        board[1, 0] = .init(order: .second, bead: .init(.red, .init(left: 1)))
        XCTAssertEqual(-1, board[.first].score)
        XCTAssertEqual(1, board[.second].score)
        XCTAssertEqual(.first, board[0, 0]?.order)
        XCTAssertEqual(.second, board[1, 0]?.order)
    }
}
