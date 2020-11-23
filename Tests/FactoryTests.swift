import XCTest
@testable import Magister

final class FactoryTests: XCTestCase {
    func testBeads() {
        XCTAssertEqual(5, Factory.beads().count)
        XCTAssertGreaterThan(Factory.beads(tier: 10).map(\.tier).max()!, 4)
        XCTAssertGreaterThan(Factory.beads(tier: 100).map(\.tier).max()!, 20)
    }
    
    func testRobot() {
        XCTAssertEqual(5, Robot([]).beads.count)
        XCTAssertFalse(Robot([]).name.isEmpty)
        XCTAssertGreaterThan(Robot([.init(top: 50)]).beads.map(\.tier).max()!, 10)
    }
}
