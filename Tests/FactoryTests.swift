import XCTest
@testable import Magister

final class FactoryTests: XCTestCase {
    func testBeads() {
        XCTAssertEqual(5, Factory.beads().count)
        XCTAssertGreaterThan(Factory.beads(tier: 10).map(\.tier).max()!, 4)
        XCTAssertGreaterThan(Factory.beads(tier: 100).map(\.tier).max()!, 40)
    }
    
    func testRobot() {
        XCTAssertEqual(5, Factory.oponent(user: []).beads.count)
        XCTAssertFalse(Factory.oponent(user: []).name.isEmpty)
        XCTAssertGreaterThan(Factory.oponent(user: [.init(top: 50)]).beads.map(\.tier).max()!, 20)
    }
}
