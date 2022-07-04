import XCTest
@testable import SeedPhrase

final class SeedPhraseTests: XCTestCase {
    func testDerivationThrows() {
        XCTAssertThrowsError(try SeedPhrase.derive(from: Data(repeating: 0, count: 10)))
        XCTAssertNoThrow(try SeedPhrase.derive(from: Data(repeating: 0, count: 32)))
    }
}
