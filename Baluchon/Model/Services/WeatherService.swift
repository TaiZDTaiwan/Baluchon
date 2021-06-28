//
//  WeatherSession.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 16/06/2021.
//

import Foundation

class WeatherService {
    
    // MARK: - Variables and constants

    // Singleton used to create a single instance and call the API once at a time.
    static var shared = WeatherService()
    private init() {}
    
    // API Url.
    private var weatherUrl: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=2c6ac7cd137e36f68695815c7f96611c")!
    }
    
    // To parameter API calling.
    private var task: URLSessionDataTask?
    
    // To parameter API calling.
    private var weatherSession = URLSession(configuration: .default)
    
    // To avoid var weatherSession remains public, use of an initializer.
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }
    
    // Chosen city name.
    private var chosenCity = ""
    
    // To recognize which city ID to insert in API Url as body parameter.
    private var cityId: String {
        if chosenCity == "New York" {
            return "5128581"
        }
            return "2988507"
    }
    
    // MARK: - Functions
    
    // To get data from API in an asynchrone thread, taking into account the chosen user city.
    func getWeatherForecast(city: String, callback: @escaping (Bool, WeatherForecast?) -> Void) {
        
        chosenCity = city
        
        let request = URLRequest(url: weatherUrl)
        
        task = weatherSession.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        callback(false, nil)
                        return
                    }

                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                    }

                    guard let responseJSON = try? JSONDecoder().decode(WeatherForecast.self, from: data) else {
                            callback(false, nil)
                            return
                    }
                    callback(true, responseJSON)
                    }
                }
            task?.resume()
        }
}
