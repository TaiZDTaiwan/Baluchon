//
//  Weather.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 16/06/2021.
//

import Foundation

// MARK: - API's constants

struct WeatherForecast: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Decodable {
    let main: String
}

struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
