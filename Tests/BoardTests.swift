import XCTest
@testable import Magister

final class BoardTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .robot([.init()])
    }
    
    func testEmptyAll() {
        XCTAssertEqual(9, match.board.empty.count)
    }
    
    func testEmptySome() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                match.board[x, y] = .init(player: .user, bead: .init())
            }
        }
        match.board[0, 0] = nil
        match.board[0, 2] = nil
        match.board[1, 1] = nil
        match.board[2, 2] = nil
        XCTAssertTrue(match.board.empty.contains(.init(x: 0, y: 0)))
        XCTAssertTrue(match.board.empty.contains(.init(x: 0, y: 2)))
        XCTAssertTrue(match.board.empty.contains(.init(x: 1, y: 1)))
        XCTAssertTrue(match.board.empty.contains(.init(x: 2, y: 2)))
    }
}
