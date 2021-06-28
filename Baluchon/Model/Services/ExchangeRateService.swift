//
//  ExchangeRate.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 05/06/2021.
//

import Foundation

class ExchangeRateService {
    
    // MARK: - Variables and constants
    
    // Singleton used to create a single instance and call the API once at a time.
    static var shared = ExchangeRateService()
    private init() {}
    
    // API Url.
    private static let rateUrl = URL(string: "http://data.fixer.io/api/latest?access_key=9c2c9a048b5705b791513b88ee370145")!
    
    // To parameter API calling.
    private var task: URLSessionDataTask?
    
    // To parameter API calling.
    private var rateSession = URLSession(configuration: .default)
    
    // To avoid var rateSession remains public, use of an initializer.
    init(rateSession: URLSession) {
        self.rateSession = rateSession
    }
    
    // MARK: - Functions
    
    // To get data from API in an asynchrone thread.
    func getRate(callback: @escaping (Bool, ExchangeRate?) -> Void) {
        
        let request = URLRequest(url: ExchangeRateService.rateUrl)
        
        task?.cancel()
        
        task = rateSession.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        callback(false, nil)
                        return
                    }

                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                    }

                    guard let responseJSON = try? JSONDecoder().decode(ExchangeRate.self, from: data) else {
                            callback(false, nil)
                            return
                    }
                    callback(true, responseJSON)
                    }
                }
            task?.resume()
        }
}
