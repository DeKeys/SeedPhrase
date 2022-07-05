//
//  SeedPhraseProtocol.swift
//  
//
//  Created by Олег Рыбалко on 04.07.2022.
//

import Foundation

protocol SeedPhraseProtocol {
    static func derive(from data: Data?) throws -> Phrase
    static func rawRepresentation(from phrase: Phrase) throws -> Data?
}
