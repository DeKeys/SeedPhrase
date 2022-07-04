//
//  SeedPhraseProtocol.swift
//  
//
//  Created by Олег Рыбалко on 04.07.2022.
//

import Foundation

typealias Phrase = [String]

protocol SeedPhraseProtocol {
    static func deriveFrom(_ data: Data?) -> Phrase
    static func phraseToData(_ phrase: Phrase) -> Data?
}
