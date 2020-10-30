import XCTest
@testable import Magister

final class ArithmeticTests: XCTestCase {
    private var board: Board!
    
    override func setUp() {
        board = .init()
    }
    
    func testDistance() {
        board[0, 0] = .init(order: .first, bead: .init(.blue, .init()))
        board[2, 0] = .init(order: .second, bead: .init(.blue, .init(left: 1)))
        XCTAssertEqual(0, board[.first].score)
        XCTAssertEqual(0, board[.second].score)
    }
    
    func testGreater() {
        board[0, 0] = .init(order: .first, bead: .init(.blue, .init()))
        board[1, 0] = .init(order: .second, bead: .init(.blue, .init(left: 1)))
        XCTAssertEqual(-1, board[.first].score)
        XCTAssertEqual(1, board[.second].score)
    }
    
    func testLess() {
        board[0, 0] = .init(order: .first, bead: .init(.blue, .init(right: 1)))
        board[1, 0] = .init(order: .second, bead: .init(.blue, .init(left: 0)))
        XCTAssertEqual(0, board[.first].score)
        XCTAssertEqual(0, board[.second].score)
    }
    
    func testEqual() {
        board[0, 0] = .init(order: .first, bead: .init(.blue, .init()))
        board[1, 0] = .init(order: .second, bead: .init(.blue, .init()))
        XCTAssertEqual(0, board[.first].score)
        XCTAssertEqual(0, board[.second].score)
    }
}
