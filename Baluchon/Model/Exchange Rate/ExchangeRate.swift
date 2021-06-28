//
//  ExchangeRate.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 06/06/2021.
//

import Foundation

// MARK: - API's constants

struct ExchangeRate: Decodable {
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double]
}
