import XCTest
@testable import Magister

final class PlayTests: XCTestCase {
    private var match: Match!
    private var initial: Match.Turn!
    
    override func setUp() {
        match = .init()
        match.join(.robot(.user(.init(), "", [])))
        match.join(.robot(.user(.init(), "", [])))
        if case let .play(turn) = match.state {
            initial = turn
        } else {
            XCTFail()
        }
    }
    
    func testInitial() {
        XCTAssertEqual(.new, Match().state)
    }
    
    func testFirstMove() {
        let bead = Bead()
        XCTAssertFalse(match[bead])
        match[.init(0, 0)] = bead
        XCTAssertTrue(match[bead])
        XCTAssertEqual(1, match[initial])
        XCTAssertEqual(initial, match[.init(0, 0)]?.player)
        if case let .play(turn) = match.state {
            XCTAssertEqual(initial.negative, turn)
        } else {
            XCTFail()
        }
    }
    
    func testSecondMove() {
        match[.init(0, 0)] = .init()
        match[.init(1, 0)] = .init(left: 1)
        XCTAssertEqual(2, match[initial.negative])
        XCTAssertGreaterThan(match[initial.negative], match[initial])
        XCTAssertEqual(initial.negative, match[.init(0, 0)]?.player)
        XCTAssertEqual(initial.negative, match[.init(1, 0)]?.player)
        if case let .play(turn) = match.state {
            XCTAssertEqual(initial, turn)
        } else {
            XCTFail()
        }
    }
    
    func testFinish() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match[.init(x, y)] = .init(player: initial, bead: .init(), point: .init(x, y))
            }
        }
        match[initial].play(match).map {
            match[$0.point] = $0.bead
        }
        if case let .win(turn) = match.state {
            XCTAssertEqual(initial, turn)
        } else {
            XCTFail()
        }
    }
    
    func testFinishWin() {
        (0 ..< 3).map { .init($0, 0) }.forEach {
            match[$0] = .init(player: initial, bead: .init(), point: $0)
        }
        (0 ..< 3).map { .init($0, 2) }.forEach {
            match[$0] = .init(player: initial.negative, bead: .init(), point: $0)
        }
        match[.init(0, 1)] = .init(player: initial.negative, bead: .init(), point: .init(0, 1))
        match[.init(1, 1)] = .init(player: initial.negative, bead: .init(), point: .init(1, 1))
        match[.init(2, 1)] = .init()
        XCTAssertGreaterThan(match[initial.negative], match[initial])
        if case let .win(turn) = match.state {
            XCTAssertEqual(initial.negative, turn)
        } else {
            XCTFail()
        }
        let bead = Bead()
        match.prize(bead)
        if case let .end(prize) = match.state {
            XCTAssertEqual(prize, bead)
        } else {
            XCTFail()
        }
    }
}
