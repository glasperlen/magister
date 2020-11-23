import XCTest
@testable import Magister

final class RobotTests: XCTestCase {
    private var match: Match!

    override func setUp() {
        match = .init()
        match.robot = .init([])
        match.state = .first
    }
    
    func testFirst() {
        match.robot?.play(match).map {
            match[$0.point] = $0.bead
        }
        XCTAssertEqual(.loose(0), match[.second])
        XCTAssertEqual(.second, match.state)
    }
    
    func testOnlyEmpty() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match[.init(x, y)] = .init(state: .second, bead: .init(), point: .init(x, y))
            }
        }
        match.robot?.play(match).map {
            match[$0.point] = $0.bead
        }
        XCTAssertEqual(.first, match[.init(0, 0)]?.state)
    }
    
    func testFirstAttack() {
        match[.init(1, 1)] = .init(state: .second, bead: .init(top: 2, bottom: 2, left: 2, right: 1), point: .init(1, 1))
        match.robot = .init([])
        match.robot?.beads = [.init(left: 2)]
        match.robot?.play(match).map {
            match[$0.point] = $0.bead
        }
        XCTAssertEqual(.first, match[.init(2, 1)]?.state)
    }
}
