import XCTest
@testable import Magister

final class PlayTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .init([])
        match.turn = .oponent
    }
    
    func testFirstMove() {
        let bead = Bead()
        XCTAssertFalse(match.played(bead))
        match.play(bead, .init(0, 0))
        XCTAssertTrue(match.played(bead))
        XCTAssertEqual(0, match.score)
        XCTAssertEqual(.oponent, match[.init(0, 0)]?.player)
        XCTAssertEqual(.user, match.turn)
        XCTAssertNil(match.result)
    }
    
    func testSecondMove() {
        match.play(.init(), .init(0, 0))
        match.play(.init(left: 1), .init(1, 0))
        XCTAssertEqual(1, match.score)
        XCTAssertEqual(.user, match[.init(0, 0)]?.player)
        XCTAssertEqual(.user, match[.init(1, 0)]?.player)
        XCTAssertNil(match.result)
    }
    
    func testFinish() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match[.init(x, y)] = .init(player: .oponent, bead: .init(), point: .init(x, y))
            }
        }
        match.turn = .oponent
        match.robot()
        XCTAssertEqual(.oponent, match.turn)
        XCTAssertNotNil(match.result)
    }
    
    func testFinishWin() {
        (0 ..< 3).map { .init($0, 0) }.forEach {
            match[$0] = .init(player: .oponent, bead: .init(), point: $0)
        }
        (0 ..< 3).map { .init($0, 2) }.forEach {
            match[$0] = .init(player: .user, bead: .init(), point: $0)
        }
        match[.init(0, 1)] = .init(player: .user, bead: .init(), point: .init(0, 1))
        match[.init(1, 1)] = .init(player: .user, bead: .init(), point: .init(1, 1))
        match.play(.init(), .init(2, 1))
        XCTAssertEqual(.win, match.result)
        XCTAssertEqual(0.5555556, match.score)
        XCTAssertEqual(.oponent, match.turn)
    }
    
    func testFinishLoose() {
        (0 ..< 3).map { .init($0, 0) }.forEach {
            match[$0] = .init(player: .oponent, bead: .init(), point: $0)
        }
        (0 ..< 3).map { .init($0, 2) }.forEach {
            match[$0] = .init(player: .user, bead: .init(), point: $0)
        }
        match[.init(0, 1)] = .init(player: .user, bead: .init(), point: .init(0, 1))
        match[.init(1, 1)] = .init(player: .oponent, bead: .init(), point: .init(1, 1))
        match.play(.init(), .init(2, 1))
        XCTAssertEqual(.loose, match.result)
        XCTAssertEqual(0.44444445, match.score)
        XCTAssertEqual(.oponent, match.turn)
    }
}
