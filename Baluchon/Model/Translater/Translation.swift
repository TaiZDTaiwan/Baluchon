//
//  Translation.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 16/06/2021.
//

import Foundation

// MARK: - API's constants

struct Translation: Decodable {
    let data: Data
}

struct Data: Decodable {
    let translations: [Translations]
}

struct Translations: Decodable {
    let translatedText: String
}
