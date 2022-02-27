//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Михаил Иванов on 19.02.2022.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var forecastDay: UILabel!
    @IBOutlet var forecastComment: UILabel!
    @IBOutlet var forecastMinTemp: UILabel!
    @IBOutlet var forecastMaxTemp: UILabel!
    @IBOutlet var forecastIcon: UIImageView!
    
    func showForecast(forecast: NextDays,
                      temperatureMeasurement: String,
                      windSpeedMeasurement: String) {
        forecastDay.text = forecast.day
        forecastComment.text = forecast.comment
        forecastMinTemp.text = "Min T: \(forecast.minTemp?[temperatureMeasurement] ?? 0)°C"
        forecastMaxTemp.text = "Max T: \(forecast.maxTemp?[temperatureMeasurement] ?? 0)°C"
        
        IconManager.shared.fetchWeatherIconData(from: forecast.iconURL) { data in
            self.forecastIcon.image = UIImage(data: data)
        }
    }
}



