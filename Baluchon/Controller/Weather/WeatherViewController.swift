//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 04/06/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Outlets from view
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet var topLabelCollection: [UILabel]!
    @IBOutlet weak var topDescriptionLabel: UILabel!
    @IBOutlet weak var topTemperatureLabel: UILabel!
    @IBOutlet weak var topMaxMinTempLabel: UILabel!
    @IBOutlet weak var topCityLabel: UILabel!
    @IBOutlet weak var botView: UIView!
    @IBOutlet var botLabelCollection: [UILabel]!
    @IBOutlet weak var botDescriptionLabel: UILabel!
    @IBOutlet weak var botTemperatureLabel: UILabel!
    @IBOutlet weak var botMaxMinTempLabel: UILabel!
    @IBOutlet weak var botCityLabel: UILabel!
    @IBOutlet weak var topActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var botActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables and constants
    
    // To convert Kelvin to Degree Celsius.
    private static let kelvinToDegree = 273.15
    
    // MARK: - View lifecycle
    
    // To get the weather and appropriate background layout for Paris and New York before displaying the main view.
    override func viewDidLoad() {
        launchWeatherForecastProcess("Paris")
        launchWeatherForecastProcess("New York")
        super.viewDidLoad()
    }
    
    // MARK: - Functions and Actions dragged from view
    
    // To display or dismiss the activity indicator and central labels.
    private func toggleActivityIndicator(activityIndicator: UIActivityIndicatorView, collection: [UILabel], shown: Bool) {
        activityIndicator.isHidden = !shown
        for oneLabel in collection {
            oneLabel.isHidden = shown
        }
    }
    
    // To launch the API weather process from the weather session file and determine the next steps depending on the success of getting API's data.
    private func launchWeatherForecastProcess(_ city: String) {
        toggleActivityIndicator(activityIndicator: self.topActivityIndicator, collection: self.topLabelCollection, shown: true)
        toggleActivityIndicator(activityIndicator: self.botActivityIndicator, collection: self.botLabelCollection, shown: true)
        
        WeatherService.shared.getWeatherForecast(city: city) { [weak self] success, weatherForecast in
            if success, let weatherForecast = weatherForecast {
                if city == "New York" {
                    self?.toggleActivityIndicator(activityIndicator: (self?.topActivityIndicator)!, collection: (self?.topLabelCollection)!, shown: false)
                    self?.getWeatherForecastNewYork(weatherForecast)
                } else {
                    self?.toggleActivityIndicator(activityIndicator: (self?.botActivityIndicator)!, collection: (self?.botLabelCollection)!, shown: false)
                    self?.getWeatherForecastParis(weatherForecast)
                }
            } else {
                self?.presentAlert("Weather forecast download has failed.")
            }
        }
    }
    
    // Get and organize layout for weather forecast concerning the city of New York.
    private func getWeatherForecastNewYork(_ weatherForecast: WeatherForecast) {
        getWeatherForecast(cityLabel: topCityLabel, descriptionLabel: topDescriptionLabel, temperatureLabel: topTemperatureLabel, maxMinTempLabel: topMaxMinTempLabel, weatherForecast: weatherForecast)
        
        setWeatherBackground(view: topView, descriptionWeather: weatherForecast.weather[0].main, topDistance: .topPadding)
    }
    
    // Get and organize layout for weather forecast concerning the city of Paris.
    private func getWeatherForecastParis(_ weatherForecast: WeatherForecast) {
        getWeatherForecast(cityLabel: botCityLabel, descriptionLabel: botDescriptionLabel, temperatureLabel: botTemperatureLabel, maxMinTempLabel: botMaxMinTempLabel, weatherForecast: weatherForecast)
        
        setWeatherBackground(view: botView, descriptionWeather: weatherForecast.weather[0].main, topDistance: 10)
    }
    
    // Get various data from API and display its on view elements.
    private func getWeatherForecast(cityLabel: UILabel, descriptionLabel: UILabel, temperatureLabel: UILabel, maxMinTempLabel: UILabel, weatherForecast: WeatherForecast) {
        cityLabel.text = weatherForecast.name
        descriptionLabel.text = weatherForecast.weather[0].main
        
        let tempInDegree = lround(weatherForecast.main.temp - WeatherViewController.kelvinToDegree)
        temperatureLabel.text = String(tempInDegree)
        
        let tempMinInDegree = lround(weatherForecast.main.tempMin - WeatherViewController.kelvinToDegree)
        let tempMaxInDegree = lround(weatherForecast.main.tempMax - WeatherViewController.kelvinToDegree)
            
        maxMinTempLabel.text = "Max. \(String(tempMaxInDegree))° Min. \(String(tempMinInDegree))°"
    }
    
    // The different layouts background depending on the city current weather.
    private func setWeatherBackground(view: UIView, descriptionWeather: String, topDistance: CGFloat) {
        if descriptionWeather == "Clear" {
            view.clear(topDistance)
        } else if descriptionWeather == "Clouds" {
            view.clouds(topDistance)
        } else if descriptionWeather == "Dust" {
            view.dust(topDistance)
        } else if descriptionWeather == "Haze" {
                view.haze(topDistance)
        } else if descriptionWeather == "Mist" {
            view.mist(topDistance)
        } else if descriptionWeather == "Rain" {
                view.rain(topDistance)
        } else {
            view.thunderstorm(topDistance)
        }
    }
}
