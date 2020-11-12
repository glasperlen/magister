import XCTest
@testable import Magister

final class RobotTests: XCTestCase {
    private var match: Match!

    override func setUp() {
        match = .init([])
        match.turn = .oponent
    }
    
    func testFirst() {
        match.robot()
        XCTAssertEqual(0, match.score)
        XCTAssertEqual(.user, match.turn)
    }
    
    func testOnlyEmpty() {
        (0 ..< 3).forEach { x in
            (0 ..< 3).forEach { y in
                guard x != 0 || y != 0 else { return }
                match[.init(x, y)] = .init(player: .user, bead: .init(), point: .init(x, y))
            }
        }
        match.robot()
        XCTAssertEqual(.oponent, match[.init(0, 0)]?.player)
    }
    
    func testFirtAttack() {
        match[.init(1, 1)] = .init(player: .user, bead: .init(top: 2, bottom: 2, left: 2, right: 1), point: .init(1, 1))
        match.oponent = .init(beads: [.init(left: 2)], name: "")
        match.robot()
        XCTAssertEqual(.oponent, match[.init(2, 1)]?.player)
    }
}
