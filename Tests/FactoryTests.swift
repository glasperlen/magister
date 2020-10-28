import XCTest
import Magister

final class FactoryTests: XCTestCase {
    func testAmount() {
        XCTAssertEqual(10, Factory.make(10).count)
        XCTAssertEqual(5, Factory.make(5).count)
    }
}
