import XCTest
@testable import Magister

final class PlayerTests: XCTestCase {
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
    
    func testFirst() {
        match.players[initial]!.play(match).map {
            match[$0.point] = $0.bead
        }
        XCTAssertGreaterThan(match[initial], match[initial.negative])
        if case let .play(turn) = match.state {
            XCTAssertEqual(initial.negative, turn)
        } else {
            XCTFail()
        }
    }
    
    func testOnlyEmpty() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match[.init(x, y)] = .init(player: initial.negative, bead: .init(), point: .init(x, y))
            }
        }
        match.players[initial]!.play(match).map {
            match[$0.point] = $0.bead
        }
        XCTAssertEqual(initial, match[.init(0, 0)]?.player)
    }
    
    func testFirstAttack() {
        match[.init(1, 1)] = .init(player: initial.negative, bead: .init(top: 2, bottom: 2, left: 2, right: 1), point: .init(1, 1))
        match.players[initial] = .init(id: .init(), name: "", beads: [.init(left: 2)])
        match.players[initial]!.play(match).map {
            match[$0.point] = $0.bead
        }
        XCTAssertEqual(initial, match[.init(2, 1)]?.player)
    }
    
    func testRobot() {
        XCTAssertEqual(5, Player.robot(.user(.init(), "", [])).beads.count)
        XCTAssertFalse(Player.robot(.user(.init(), "", [])).name.isEmpty)
        XCTAssertGreaterThan(Player.robot(.user(.init(), "", [.init(top: 50)])).beads.map(\.tier).max()!, 10)
    }
}
