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
        XCTAssertEqual(1, match.board[.oponent].count)
        XCTAssertEqual(4, match[.oponent].deck.count)
        XCTAssertEqual(.user, match.turn)
    }
    
    func testOnlyEmpty() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match.board[x, y] = .init(player: .user, bead: .init())
            }
        }
        match.robot()
        XCTAssertEqual(.oponent, match.board[0, 0]?.player)
    }
    
    func testFirtAttack() {
        match.board[1, 1] = .init(player: .user, bead: .init(top: 2, bottom: 2, left: 2, right: 1))
        match[.oponent].deck = [.init(left: 2)]
        match.robot()
        XCTAssertEqual(.oponent, match.board[2, 1]?.player)
    }
}
