import XCTest
@testable import Magister

final class BeadTests: XCTestCase {
    func testTier() {
        XCTAssertEqual(14, Bead(.blue, .init(top: 0, bottom: 2, left: 4, right: 8)).tier)
        XCTAssertEqual(1, Bead(.blue, .init(top: 1)).tier)
    }
}
