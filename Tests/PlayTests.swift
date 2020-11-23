import XCTest
@testable import Magister

final class PlayTests: XCTestCase {
    private var match: Match!
    
    override func setUp() {
        match = .init()
        match.robot = .init([])
        match.state = .first
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
        XCTAssertEqual(.first, match[.init(0, 0)]?.state)
        XCTAssertEqual(.second, match.state)
    }
    
    func testSecondMove() {
        match[.init(0, 0)] = .init()
        match[.init(1, 0)] = .init(left: 1)
        XCTAssertEqual(.win(1), match[.second])
        XCTAssertEqual(.second, match[.init(0, 0)]?.state)
        XCTAssertEqual(.second, match[.init(1, 0)]?.state)
        XCTAssertEqual(.first, match.state)
    }
    
    func testFinish() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match[.init(x, y)] = .init(state: .first, bead: .init(), point: .init(x, y))
            }
        }
        match.state = .first
        match.robot?.play(match).map {
            match[$0.point] = $0.bead
        }
        XCTAssertEqual(.prize, match.state)
    }
    
    func testFinishWin() {
        (0 ..< 3).map { .init($0, 0) }.forEach {
            match[$0] = .init(state: .first, bead: .init(), point: $0)
        }
        (0 ..< 3).map { .init($0, 2) }.forEach {
            match[$0] = .init(state: .second, bead: .init(), point: $0)
        }
        match[.init(0, 1)] = .init(state: .second, bead: .init(), point: .init(0, 1))
        match[.init(1, 1)] = .init(state: .second, bead: .init(), point: .init(1, 1))
        match[.init(2, 1)] = .init()
        XCTAssertEqual(.win(0.5555556), match[.second])
        XCTAssertEqual(.prize, match.state)
    }
    
    func testFinishLoose() {
        (0 ..< 3).map { .init($0, 0) }.forEach {
            match[$0] = .init(state: .first, bead: .init(), point: $0)
        }
        (0 ..< 3).map { .init($0, 2) }.forEach {
            match[$0] = .init(state: .second, bead: .init(), point: $0)
        }
        match[.init(0, 1)] = .init(state: .second, bead: .init(), point: .init(0, 1))
        match[.init(1, 1)] = .init(state: .first, bead: .init(), point: .init(1, 1))
        match[.init(2, 1)] = .init()
        XCTAssertEqual(.loose(0.44444445), match[.second])
        XCTAssertEqual(.prize, match.state)
    }
}
