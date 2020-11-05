import XCTest
@testable import Magister

final class BoardTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .robot([.init()])
    }
    
    func testEmptyAll() {
        XCTAssertEqual(9, match.board[nil].count)
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
        XCTAssertTrue(match.board[nil].contains(.init(0, 0)))
        XCTAssertTrue(match.board[nil].contains(.init(0, 2)))
        XCTAssertTrue(match.board[nil].contains(.init(1, 1)))
        XCTAssertTrue(match.board[nil].contains(.init(2, 2)))
    }
}
