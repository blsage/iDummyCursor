import XCTest
@testable import DummyCursor

final class DummyCursorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(DummyCursor().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
