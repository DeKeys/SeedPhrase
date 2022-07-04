//
//  FunctionsTests.swift
//  
//
//  Created by Олег Рыбалко on 04.07.2022.
//

import Foundation
import XCTest
@testable import SeedPhrase

final class FunctionsTests: XCTestCase {
    func testConvertbin2dec() {
        let oneBits: [Bit] = [.zero, .zero, .one]
        let twoBits: [Bit] = [.one, .zero]
        let nullBits: [Bit] = []
        let maxBits = [Bit](repeating: .one, count: 11)
        XCTAssertEqual(bin2dec(oneBits), 1)
        XCTAssertEqual(bin2dec(twoBits), 2)
        XCTAssertEqual(bin2dec(nullBits), 0)
        XCTAssertEqual(bin2dec(maxBits), 2047)
    }
}
