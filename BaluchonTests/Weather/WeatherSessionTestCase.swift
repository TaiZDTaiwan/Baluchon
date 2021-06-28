//
//  WeatherSessionTestCase.swift
//  BaluchonTests
//
//  Created by Raphaël Huang-Dubois on 22/06/2021.
//

import XCTest
@testable import Baluchon

class WeatherSessionTestCase: XCTestCase {
    
    private var firstCity = "New York"
    private var secondCity = "Paris"
    
    func testGetWeatherForecastShouldPostFailedCallbackIfError() {
        
        // Given
        let weatherSession = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherSession.getWeatherForecast(city: firstCity) { (success, weatherForecast) in

        // Then
        XCTAssertFalse(success)
        XCTAssertNil(weatherForecast)
        expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherForecastShouldPostFailedCallbackIfNoData() {
        
        // Given
        let weatherSession = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherSession.getWeatherForecast(city: secondCity) { (success, weatherForecast) in

        // Then
        XCTAssertFalse(success)
        XCTAssertNil(weatherForecast)
        expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherForecastShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherSession = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherSession.getWeatherForecast(city: firstCity) { (success, weatherForecast) in
            
        // Then
        XCTAssertFalse(success)
        XCTAssertNil(weatherForecast)
        expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherForecastShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherSession = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherSession.getWeatherForecast(city: firstCity) { (success, weatherForecast) in
            
        // Then
        XCTAssertFalse(success)
        XCTAssertNil(weatherForecast)
        expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherForecastShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherSession = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherSession.getWeatherForecast(city: firstCity) { (success, weatherForecast) in
            
        // Then
        let main = "Clear"
            
        XCTAssertTrue(success)
        XCTAssertNotNil(weatherForecast)
        XCTAssertEqual(main, weatherForecast!.weather[0].main)
        expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
