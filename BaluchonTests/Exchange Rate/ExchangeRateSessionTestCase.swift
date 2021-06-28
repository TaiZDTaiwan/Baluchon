//
//  ExchangeRateSessionTestCase.swift
//  BaluchonTests
//
//  Created by Raphaël Huang-Dubois on 21/06/2021.
//

import XCTest
@testable import Baluchon

class ExchangeRateSessionTestCase: XCTestCase {
  
    func testGetExchangeRateShouldPostFailedCallbackIfError() {
        
        // Given
        let exchangeRateSession = ExchangeRateService(rateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateSession.getRate { (success, exchangeRate) in

        // Then
        XCTAssertFalse(success)
        XCTAssertNil(exchangeRate)
        expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeRateShouldPostFailedCallbackIfNoData() {
        
        // Given
        let exchangeRateSession = ExchangeRateService(rateSession: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateSession.getRate { (success, exchangeRate) in

        // Then
        XCTAssertFalse(success)
        XCTAssertNil(exchangeRate)
        expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeRateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let exchangeRateSession = ExchangeRateService(rateSession: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseKO, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateSession.getRate { (success, exchangeRate) in
        
        // Then
            XCTAssertFalse(success)
            XCTAssertNil(exchangeRate)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeRateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let exchangeRateSession = ExchangeRateService(rateSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateSession.getRate { (success, exchangeRate) in
            
        // Then
        XCTAssertFalse(success)
        XCTAssertNil(exchangeRate)
        expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeRateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let exchangeRateSession = ExchangeRateService(rateSession: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateSession.getRate { (success, exchangeRate) in
            
        // Then
        let rate = 4.367992
            
        XCTAssertTrue(success)
        XCTAssertNotNil(exchangeRate)
        XCTAssertEqual(rate, exchangeRate!.rates["AED"])
        expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
