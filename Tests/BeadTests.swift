import XCTest
@testable import Magister

final class BeadTests: XCTestCase {
    func testTier() {
        XCTAssertEqual(14, Bead(.red, .init(top: 0, bottom: 2, left: 4, right: 8)).tier)
        XCTAssertEqual(1, Bead(.red, .init(top: 1)).tier)
    }
}
