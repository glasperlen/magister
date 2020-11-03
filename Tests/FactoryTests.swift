import XCTest
@testable import Magister

final class FactoryTests: XCTestCase {
    func testBeads() {
        XCTAssertEqual(10, Factory.beads(10).count)
        XCTAssertEqual(5, Factory.beads(5).count)
    }
    
    func testRobot() {
        XCTAssertEqual(5, Factory.robot(1).deck.count)
        XCTAssertFalse(Factory.robot(1).name.isEmpty)
    }
}
