import XCTest
@testable import ITMulticastDelegate

final class ITMulticastDelegateTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ITMulticastDelegate().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
