//
//  TranslaterSessionTestCase.swift
//  BaluchonTests
//
//  Created by Raphaël Huang-Dubois on 21/06/2021.
//

import XCTest
@testable import Baluchon

class TranslaterSessionTestCase: XCTestCase {
    
    private var userTagFirstOption = 0
    private var userTagSecondOption = 1
    private var text = "Bonjour"
    
    func testGetTranslationShouldPostFailedCallbackIfError() {
        
        // Given
        let translaterRateSession = TranslaterService(translaterSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translaterRateSession.getTranslation(userTag: userTagFirstOption, text: text) { (success, translation) in

        // Then
        XCTAssertFalse(success)
        XCTAssertNil(translation)
        expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        
        // Given
        let translaterRateSession = TranslaterService(translaterSession: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translaterRateSession.getTranslation(userTag: userTagSecondOption, text: text) { (success, translation) in

        // Then
        XCTAssertFalse(success)
        XCTAssertNil(translation)
        expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translaterRateSession = TranslaterService(translaterSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translaterRateSession.getTranslation(userTag: userTagFirstOption, text: text) { (success, translation) in
            
        // Then
        XCTAssertFalse(success)
        XCTAssertNil(translation)
        expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translaterRateSession = TranslaterService(translaterSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translaterRateSession.getTranslation(userTag: userTagFirstOption, text: text) { (success, translation) in
            
        // Then
        XCTAssertFalse(success)
        XCTAssertNil(translation)
        expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translaterRateSession = TranslaterService(translaterSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translaterRateSession.getTranslation(userTag: userTagFirstOption, text: text) { (success, translation) in
            
        // Then
        let translatedText = "Hello"
            
        XCTAssertTrue(success)
        XCTAssertNotNil(translation)
        XCTAssertEqual(translatedText, translation!.data.translations[0].translatedText)
        expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
