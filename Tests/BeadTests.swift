import XCTest
@testable import Magister

final class BeadTests: XCTestCase {
    func testTier() {
        XCTAssertEqual(14, Bead(top: 0, bottom: 2, left: 4, right: 8).tier)
        XCTAssertEqual(1, Bead(top: 1).tier)
    }
    
    func testMake() {
        XCTAssertEqual(5, Bead.make().count)
        XCTAssertGreaterThan(Bead.make(tier: 10).map(\.tier).max()!, 4)
        XCTAssertGreaterThan(Bead.make(tier: 100).map(\.tier).max()!, 20)
    }
}
