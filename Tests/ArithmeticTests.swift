import XCTest
@testable import Magister

final class ArithmeticTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .robot([.init()])
    }
    
    func testDistance() {
        match.players[match.turn]!.deck = [.init(.init())]
        match.play(0, .init(0, 0))
        
        match.players[match.turn]!.deck = [.init(.init(left: 1))]
        match.play(0, .init(2, 0))
        
        XCTAssertEqual(0, match[.user].score)
        XCTAssertEqual(0, match[.oponent].score)
    }
    
    func testGreater() {
        match.players[match.turn]!.deck = [.init(.init())]
        match.play(0, .init(0, 0))
        
        match.players[match.turn]!.deck = [.init(.init(left: 1))]
        match.play(0, .init(1, 0))
        
        XCTAssertEqual(-1, match[match.turn].score)
        XCTAssertEqual(1, match[match.turn.next].score)
        
        XCTAssertEqual(match.turn.next, match.board[.init(0, 0)]?.player)
        XCTAssertEqual(match.turn.next, match.board[.init(1, 0)]?.player)
    }
    
    func testLess() {
        match.players[match.turn]!.deck = [.init(.init(right: 1))]
        match.play(0, .init(0, 0))
        
        match.players[match.turn]!.deck = [.init(.init())]
        match.play(0, .init(1, 0))
        
        XCTAssertEqual(0, match[.user].score)
        XCTAssertEqual(0, match[.oponent].score)
    }
    
    func testEqual() {
        match.players[match.turn]!.deck = [.init(.init(right: 1))]
        match.play(0, .init(0, 0))
        
        match.players[match.turn]!.deck = [.init(.init(left: 1))]
        match.play(0, .init(1, 0))
        
        XCTAssertEqual(0, match[.user].score)
        XCTAssertEqual(0, match[.oponent].score)
    }
    
    func testGreaterSamePlayer() {
        match.players[match.turn]!.deck = [.init(.init()), .init(.init(left: 1))]
        match.play(0, .init(0, 0))
        
        match.players[match.turn]!.deck = [.init(.init())]
        match.play(0, .init(2, 2))
        
        match.play(0, .init(1, 0))
        
        XCTAssertEqual(0, match[match.turn].score)
        XCTAssertEqual(0, match[match.turn.next].score)
    }
}
