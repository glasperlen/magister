import XCTest
@testable import Magister

final class FactoryTests: XCTestCase {
    func testBeads() {
        XCTAssertEqual(5, Factory.beads().count)
        XCTAssertGreaterThan(Factory.beads(tier: 10).map(\.tier).max()!, 5)
        XCTAssertGreaterThan(Factory.beads(tier: 100).map(\.tier).max()!, 100)
    }
    
    func testRobot() {
        XCTAssertEqual(5, Factory.robot(tier: 1).deck.count)
        XCTAssertFalse(Factory.robot(tier: 1).name.isEmpty)
        XCTAssertGreaterThan(Factory.robot(tier: 50).deck.map(\.tier).max()!, 40)
    }
}
