import XCTest
import CryptoKit
@testable import SeedPhrase

final class SeedPhraseTests: XCTestCase {
    func testDerivationThrows() {
        XCTAssertThrowsError(try SeedPhrase.derive(from: Data(repeating: 0, count: 10)))
        XCTAssertNoThrow(try SeedPhrase.derive(from: Data(repeating: 0, count: 32)))
        
    }
    
    func testRawRepresentation() {
        do {
            let privateKey = P256.Signing.PrivateKey()
            let mnemonic = try SeedPhrase.derive(from: privateKey.rawRepresentation)
            XCTAssertNoThrow(try SeedPhrase.rawRepresentation(from: mnemonic))
            let raw = try SeedPhrase.rawRepresentation(from: mnemonic)
            XCTAssertEqual(privateKey.rawRepresentation, raw)
        } catch {
            print(error)
        }
    }
}
