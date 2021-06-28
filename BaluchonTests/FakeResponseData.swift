//
//  ExchangeRateFakeResponseData.swift
//  BaluchonTests
//
//  Created by Raphaël Huang-Dubois on 21/06/2021.
//

import Foundation

class FakeResponseData {
    
    // MARK: - Data
    static var exchangeRateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "ExchangeRate", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translater", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static let incorrectData = "erreur".data(using: .utf8)
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Error
    class SessionError: Error {}
    static let error = SessionError()
}
