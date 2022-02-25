//
//  CurrentCollectionViewCell.swift
//  WeatherApp
//
//  Created by Михаил Иванов on 19.02.2022.
//

import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var weatherTime: UILabel!
    @IBOutlet var currentTemperature: UILabel!
    @IBOutlet var weatherIcon: UIImageView?
    @IBOutlet var weatherComment: UILabel!
    @IBOutlet var precipitation: UILabel!
    @IBOutlet var wind: UILabel!
    @IBOutlet var humidity: UILabel!
    
    func showCurrentWeatherData(currentWeather: CurrentConditions,
                                temperatureMeasurement: String,
                                windSpeedMeasurement: String) {
        weatherTime.text = currentWeather.dayhour
        currentTemperature.text = "\(currentWeather.temp?[temperatureMeasurement] ?? 0)°C"
        weatherComment.text = currentWeather.comment
        precipitation.text = "Precipitation \n\(currentWeather.precip ?? "")"
        humidity.text = "Humidity \n\(currentWeather.humidity ?? "")"
        wind.text = "Wind \n\(currentWeather.wind?[windSpeedMeasurement] ?? 0) km/h"
    
        IconManager.shared.fetchWeatherIconData(from: currentWeather.iconURL) { data in
            self.weatherIcon?.image = UIImage(data: data)
        }
    }
}

