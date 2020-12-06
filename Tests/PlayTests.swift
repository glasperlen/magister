import XCTest
@testable import Magister

final class PlayTests: XCTestCase {
    private var match: Match!
    private var initial: Match.Turn!
    
    override func setUp() {
        match = .init()
        match.join(.robot(.user(.init(), "", [])))
        match.join(.robot(.user(.init(), "", [])))
        if case let .play(wait) = match.state {
            initial = wait.player
        } else {
            XCTFail()
        }
    }
    
    func testInitial() {
        XCTAssertEqual(.new, Match().state)
    }
    
    func testCancel() {
        match = .init()
        match.join(.robot(.user(.init(), "", [])))
        match.cancel()
        XCTAssertEqual(.cancel, match.state)
    }
    
    func testFirstMove() {
        let bead = Bead()
        XCTAssertFalse(match[bead])
        match[.init(0, 0)] = bead
        XCTAssertTrue(match[bead])
        XCTAssertEqual(1, match[initial])
        XCTAssertEqual(initial, match[.init(0, 0)].item?.player)
        if case let .play(wait) = match.state {
            XCTAssertEqual(initial.negative, wait.player)
            XCTAssertGreaterThan(wait.timeout, .init())
        } else {
            XCTFail()
        }
    }
    
    func testSecondMove() {
        match[.init(0, 0)] = .init()
        match[.init(1, 0)] = .init(left: 1)
        XCTAssertEqual(2, match[initial.negative])
        XCTAssertGreaterThan(match[initial.negative], match[initial])
        XCTAssertEqual(initial.negative, match[.init(0, 0)].item?.player)
        XCTAssertEqual(initial.negative, match[.init(1, 0)].item?.player)
        if case let .play(wait) = match.state {
            XCTAssertEqual(initial, wait.player)
        } else {
            XCTFail()
        }
    }
    
    func testFinish() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                _ = match[.init(x, y)][.init(player: initial, bead: .init())]
            }
        }
        match[initial].play(match).map {
            match[$0.point] = $0.item?.bead
        }
        if case let .win(wait) = match.state {
            XCTAssertEqual(initial, wait.player)
            XCTAssertGreaterThan(wait.timeout, .init())
        } else {
            XCTFail()
        }
    }
    
    func testFinishWin() {
        (0 ..< 3).map { .init($0, 0) }.forEach {
            _ = match[$0][.init(player: initial, bead: .init())]
        }
        (0 ..< 3).map { .init($0, 2) }.forEach {
            _ = match[$0][.init(player: initial.negative, bead: .init())]
        }
        _ = match[.init(0, 1)][.init(player: initial.negative, bead: .init())]
        _ = match[.init(1, 1)][.init(player: initial.negative, bead: .init())]
        match[.init(2, 1)] = .init()
        XCTAssertGreaterThan(match[initial.negative], match[initial])
        if case let .win(wait) = match.state {
            XCTAssertEqual(initial.negative, wait.player)
        } else {
            XCTFail()
        }
        let bead = Bead()
        match.prize(bead)
        if case let .end(result) = match.state {
            XCTAssertEqual(bead, result.bead)
            XCTAssertEqual(initial.negative, result.winner)
        } else {
            XCTFail()
        }
    }
    
    func testFinishTimeout() {
        match.timeout()
        if case let .timeout(wait) = match.state {
            XCTAssertEqual(initial, wait.player)
            XCTAssertGreaterThan(wait.timeout, .init())
        } else {
            XCTFail()
        }
        let bead = Bead()
        match.prize(bead)
        if case let .end(result) = match.state {
            XCTAssertEqual(bead, result.bead)
            XCTAssertEqual(initial.negative, result.winner)
        } else {
            XCTFail()
        }
    }
    
    func testFinishWinTimeout() {
        (0 ..< 3).map { .init($0, 0) }.forEach {
            _ = match[$0][.init(player: initial, bead: .init())]
        }
        (0 ..< 3).map { .init($0, 2) }.forEach {
            _ = match[$0][.init(player: initial.negative, bead: .init())]
        }
        _ = match[.init(0, 1)][.init(player: initial.negative, bead: .init())]
        _ = match[.init(1, 1)][.init(player: initial.negative, bead: .init())]
        match[.init(2, 1)] = .init()
        XCTAssertGreaterThan(match[initial.negative], match[initial])
        if case let .win(wait) = match.state {
            XCTAssertEqual(initial.negative, wait.player)
        } else {
            XCTFail()
        }
        match.timeout()
        XCTAssertEqual(.cancel, match.state)
    }
    
    func testFinishTimeoutTimeout() {
        match.timeout()
        if case let .timeout(wait) = match.state {
            XCTAssertEqual(initial, wait.player)
            XCTAssertGreaterThan(wait.timeout, .init())
        } else {
            XCTFail()
        }
        match.timeout()
        XCTAssertEqual(.cancel, match.state)
    }
}
