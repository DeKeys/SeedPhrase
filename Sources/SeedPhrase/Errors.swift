//
//  Errors.swift
//  
//
//  Created by Олег Рыбалко on 04.07.2022.
//

import Foundation

enum SeedPhraseError: Error {
    case invalidLength
    case invalidWord
    case invalidChecksum
}

enum ByteArrayError: Error {
    case invalidLength
}
