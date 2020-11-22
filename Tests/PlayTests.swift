import XCTest
@testable import Magister

final class PlayTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .init()
        match.robot = .init([])
        match.turn = .first
    }
    
    func testBeforeFirst() {
        XCTAssertEqual(.draw, match[.first])
        XCTAssertEqual(.draw, match[.second])
    }
    
    func testFirstMove() {
        let bead = Bead()
        XCTAssertFalse(match[bead])
        match[.init(0, 0)] = bead
        XCTAssertTrue(match[bead])
        XCTAssertEqual(.win(1), match[.first])
        XCTAssertEqual(.first, match[.init(0, 0)]?.player)
        XCTAssertEqual(.second, match.turn)
        XCTAssertEqual(.playing, match.state)
    }
    
    func testSecondMove() {
        match[.init(0, 0)] = .init()
        match[.init(1, 0)] = .init(left: 1)
        XCTAssertEqual(.win(1), match[.second])
        XCTAssertEqual(.second, match[.init(0, 0)]?.player)
        XCTAssertEqual(.second, match[.init(1, 0)]?.player)
        XCTAssertEqual(.playing, match.state)
    }
    
    func testFinish() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match[.init(x, y)] = .init(player: .first, bead: .init(), point: .init(x, y))
            }
        }
        match.turn = .first
        match.robot?.play(match).map {
            match[$0.point] = $0.bead
        }
        XCTAssertEqual(.first, match.turn)
        XCTAssertEqual(.prize, match.state)
    }
    
    func testFinishWin() {
        (0 ..< 3).map { .init($0, 0) }.forEach {
            match[$0] = .init(player: .first, bead: .init(), point: $0)
        }
        (0 ..< 3).map { .init($0, 2) }.forEach {
            match[$0] = .init(player: .second, bead: .init(), point: $0)
        }
        match[.init(0, 1)] = .init(player: .second, bead: .init(), point: .init(0, 1))
        match[.init(1, 1)] = .init(player: .second, bead: .init(), point: .init(1, 1))
        match[.init(2, 1)] = .init()
        XCTAssertEqual(.win(0.5555556), match[.second])
        XCTAssertEqual(.first, match.turn)
    }
    
    func testFinishLoose() {
        (0 ..< 3).map { .init($0, 0) }.forEach {
            match[$0] = .init(player: .first, bead: .init(), point: $0)
        }
        (0 ..< 3).map { .init($0, 2) }.forEach {
            match[$0] = .init(player: .second, bead: .init(), point: $0)
        }
        match[.init(0, 1)] = .init(player: .second, bead: .init(), point: .init(0, 1))
        match[.init(1, 1)] = .init(player: .first, bead: .init(), point: .init(1, 1))
        match[.init(2, 1)] = .init()
        XCTAssertEqual(.loose(0.44444445), match[.second])
        XCTAssertEqual(.first, match.turn)
    }
}
