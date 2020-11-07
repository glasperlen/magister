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
        XCTAssertEqual(.user, match.turn)
    }
    
    func testOnlyEmpty() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match.board[.init(x, y)] = .init(player: .user, bead: .init())
            }
        }
        match.robot()
        XCTAssertEqual(.oponent, match.board[.init(0, 0)]?.player)
    }
    
    func testFirtAttack() {
        match.board[.init(1, 1)] = .init(player: .user, bead: .init(top: 2, bottom: 2, left: 2, right: 1))
        match.players[.oponent]!.deck = [.init(.init(left: 2))]
        match.robot()
        XCTAssertEqual(.oponent, match.board[.init(2, 1)]?.player)
    }
}
