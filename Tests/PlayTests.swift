import XCTest
import Combine
@testable import Magister

final class PlayTests: XCTestCase {
    private var match: Match!
    private var subs = Set<AnyCancellable>()
    
    override func setUp() {
        match = .robot(.init(Factory.beads()))
    }
    
    func testFirstMove() {
        match.finish.sink { _ in
            XCTFail()
        }.store(in: &subs)
        
        let first = match.turn
        match.players[first]!.deck = [.init(.init())]
        XCTAssertEqual(.waiting, match.players[first]!.deck.first!.state)
        match.play(0, .init(0, 0))
        XCTAssertEqual(.played, match.players[first]!.deck.first!.state)
        XCTAssertEqual(0, match[.user].score)
        XCTAssertEqual(0, match[.oponent].score)
        XCTAssertEqual(first, match.board[.init(0, 0)]?.player)
        XCTAssertNotEqual(first, match.turn)
    }
    
    func testSecondMove() {
        match.finish.sink { _ in
            XCTFail()
        }.store(in: &subs)
        
        match.players[match.turn]!.deck = [.init(.init())]
        match.play(0, .init(0, 0))
        match.players[match.turn]!.deck = [.init(.init(left: 1))]
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
            if case .draw = $0 {
                expect.fulfill()
            }
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
    
    func testFinishWin() {
        let expect = expectation(description: "")
        match.finish.sink {
            if case .win = $0 {
                expect.fulfill()
            }
        }.store(in: &subs)
        
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match.board[.init(x, y)] = .init(player: .oponent, bead: .init())
            }
        }
        match.players[.user]!.score = 1
        match.turn = .oponent
        match.robot()
        
        waitForExpectations(timeout: 1)
    }
    
    func testFinishLoose() {
        let expect = expectation(description: "")
        match.finish.sink {
            if case let .loose(index) = $0 {
                XCTAssertGreaterThanOrEqual(index, 0)
                XCTAssertLessThanOrEqual(index, 4)
                expect.fulfill()
            }
        }.store(in: &subs)
        
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match.board[.init(x, y)] = .init(player: .oponent, bead: .init())
            }
        }
        match.players[.oponent]!.score = 1
        match.turn = .oponent
        match.robot()
        
        waitForExpectations(timeout: 1)
    }
}
