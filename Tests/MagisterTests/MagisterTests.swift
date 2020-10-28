import XCTest
@testable import Magister

final class MagisterTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Magister().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
