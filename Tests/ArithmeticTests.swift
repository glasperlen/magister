import XCTest
@testable import Magister

final class ArithmeticTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .robot([.init()])
    }
    
    func testDistance() {
        match[match.turn].deck = [.init()]
        match.play(index: 0, x: 0, y: 0)
        
        match[match.turn].deck = [.init(points: .init(left: 1))]
        match.play(index: 0, x: 2, y: 0)
        
        XCTAssertEqual(0, match[.user].score)
        XCTAssertEqual(0, match[.oponent].score)
    }
    
    func testGreater() {
        match[match.turn].deck = [.init()]
        match.play(index: 0, x: 0, y: 0)
        
        match[match.turn].deck = [.init(points: .init(left: 1))]
        match.play(index: 0, x: 1, y: 0)
        
        XCTAssertEqual(-1, match[match.turn].score)
        XCTAssertEqual(1, match[match.turn.next].score)
        
        XCTAssertEqual(match.turn.next, match.board[0, 0]?.player)
        XCTAssertEqual(match.turn.next, match.board[1, 0]?.player)
    }
    
    func testLess() {
        match[match.turn].deck = [.init(points: .init(right: 1))]
        match.play(index: 0, x: 0, y: 0)
        
        match[match.turn].deck = [.init()]
        match.play(index: 0, x: 1, y: 0)
        
        XCTAssertEqual(0, match[.user].score)
        XCTAssertEqual(0, match[.oponent].score)
    }
    
    func testEqual() {
        match[match.turn].deck = [.init(points: .init(right: 1))]
        match.play(index: 0, x: 0, y: 0)
        
        match[match.turn].deck = [.init(points: .init(left: 1))]
        match.play(index: 0, x: 1, y: 0)
        
        XCTAssertEqual(0, match[.user].score)
        XCTAssertEqual(0, match[.oponent].score)
    }
    
    func testGreaterSamePlayer() {
        match[match.turn].deck = [.init(), .init(points: .init(left: 1))]
        match.play(index: 0, x: 0, y: 0)
        
        match[match.turn].deck = [.init()]
        match.play(index: 0, x: 2, y: 2)
        
        match.play(index: 0, x: 1, y: 0)
        
        XCTAssertEqual(0, match[match.turn].score)
        XCTAssertEqual(0, match[match.turn.next].score)
    }
}
