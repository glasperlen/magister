import XCTest
@testable import Magister

final class ArithmeticTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .robot([.init()])
    }
    
    func testDistance() {
        match[match.turn].deck = [.init()]
        match.play(0, .init(0, 0))
        
        match[match.turn].deck = [.init(left: 1)]
        match.play(0, .init(2, 0))
        
        XCTAssertEqual(0, match[.user].score)
        XCTAssertEqual(0, match[.oponent].score)
    }
    
    func testGreater() {
        match[match.turn].deck = [.init()]
        match.play(0, .init(0, 0))
        
        match[match.turn].deck = [.init(left: 1)]
        match.play(0, .init(1, 0))
        
        XCTAssertEqual(-1, match[match.turn].score)
        XCTAssertEqual(1, match[match.turn.next].score)
        
        XCTAssertEqual(match.turn.next, match.board[0, 0]?.player)
        XCTAssertEqual(match.turn.next, match.board[1, 0]?.player)
    }
    
    func testLess() {
        match[match.turn].deck = [.init(right: 1)]
        match.play(0, .init(0, 0))
        
        match[match.turn].deck = [.init()]
        match.play(0, .init(1, 0))
        
        XCTAssertEqual(0, match[.user].score)
        XCTAssertEqual(0, match[.oponent].score)
    }
    
    func testEqual() {
        match[match.turn].deck = [.init(right: 1)]
        match.play(0, .init(0, 0))
        
        match[match.turn].deck = [.init(left: 1)]
        match.play(0, .init(1, 0))
        
        XCTAssertEqual(0, match[.user].score)
        XCTAssertEqual(0, match[.oponent].score)
    }
    
    func testGreaterSamePlayer() {
        match[match.turn].deck = [.init(), .init(left: 1)]
        match.play(0, .init(0, 0))
        
        match[match.turn].deck = [.init()]
        match.play(0, .init(2, 2))
        
        match.play(0, .init(1, 0))
        
        XCTAssertEqual(0, match[match.turn].score)
        XCTAssertEqual(0, match[match.turn.next].score)
    }
}
