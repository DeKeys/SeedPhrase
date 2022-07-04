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
        XCTAssertEqual(bin2dec([.one]), 1)
        XCTAssertEqual(bin2dec([.one, .zero]), 2)
        XCTAssertEqual(bin2dec([]), 0)
        XCTAssertEqual(bin2dec([Bit](repeating: .one, count: 11)), 2047)
    }
}
