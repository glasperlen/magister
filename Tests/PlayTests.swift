import XCTest
import Combine
@testable import Magister

final class PlayTests: XCTestCase {
    private var match: Match!
    private var subs = Set<AnyCancellable>()
    
    override func setUp() {
        match = .robot([.init()])
    }
    
    func testFirstMove() {
        match.finish.sink { _ in
            XCTFail()
        }.store(in: &subs)
        
        let first = match.turn
        match[first].deck = [.init()]
        match.play(0, .init(0, 0))
        XCTAssertEqual(0, match[.user].score)
        XCTAssertEqual(0, match[.oponent].score)
        XCTAssertTrue(match[first].deck.isEmpty)
        XCTAssertEqual(first, match.board[.init(0, 0)]?.player)
        XCTAssertNotEqual(first, match.turn)
    }
    
    func testSecondMove() {
        match.finish.sink { _ in
            XCTFail()
        }.store(in: &subs)
        
        match[match.turn].deck = [.init()]
        match.play(0, .init(0, 0))
        match[match.turn].deck = [.init(left: 1)]
        match.play(0, .init(1, 0))
        XCTAssertEqual(-1, match[match.turn].score)
        XCTAssertEqual(1, match[match.turn.next].score)
        XCTAssertEqual(match.turn.next, match.board[.init(0, 0)]?.player)
        XCTAssertEqual(match.turn.next, match.board[.init(1, 0)]?.player)
    }
    
    func testFinish() {
        let expect = expectation(description: "")
        match.finish.sink { _ in
            expect.fulfill()
        }.store(in: &subs)
        
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match.board[.init(x, y)] = .init(player: .oponent, bead: .init())
            }
        }
        match.turn = .oponent
        match.robot()
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(.oponent, self.match.turn)
        }
    }
    
    func testFinishDraw() {
        let expect = expectation(description: "")
        match.finish.sink {
            XCTAssertEqual(.none, $0)
            expect.fulfill()
        }.store(in: &subs)
        
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match.board[.init(x, y)] = .init(player: .oponent, bead: .init())
            }
        }
        match.turn = .oponent
        match.robot()
        
        waitForExpectations(timeout: 1)
    }
    
    func testFinishUser() {
        let expect = expectation(description: "")
        match.finish.sink {
            XCTAssertEqual(.user, $0)
            expect.fulfill()
        }.store(in: &subs)
        
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match.board[.init(x, y)] = .init(player: .oponent, bead: .init())
            }
        }
        match[.user].score = 1
        match.turn = .oponent
        match.robot()
        
        waitForExpectations(timeout: 1)
    }
}
