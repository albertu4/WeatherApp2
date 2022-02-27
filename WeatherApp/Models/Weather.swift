//
//  Weather.swift
//  WeatherApp
//
//  Created by Михаил Иванов on 18.02.2022.

import UIKit
import Alamofire

struct Weather: Decodable {
    let region: String?
    let currentConditions: CurrentConditions?
    let nextDays: [NextDays]?
    
//    init(weatherData: [String: Any]) {
//        region = weatherData["region"] as? String
//        currentConditions = weatherData["currentConditions"] as? CurrentConditions
//        nextDays = weatherData["next_days"] as? [NextDays]
//    }
//
//    static func getWeather(from value: Any) -> Weather {
//        guard let weathersData = value as? [[String: Any]]  else {
//            return Weather(weatherData: ["": 1])
//        }
//
//
//        let weather = Weather(weatherData: weathersData)
//        return weather
//    }
}

struct CurrentConditions: Decodable {
    let dayhour: String?
    let temp: [String: Int]?
    let precip: String?
    let humidity: String?
    let wind: [String: Int]?
    let iconURL: String?
    let comment: String?
    
//    init(currentConditions: [String: Any]) {
//        dayhour = currentConditions["dayhour"] as? String
//        temp = currentConditions["temp"] as? [String: Int]
//        precip = currentConditions["precip"] as? String
//        humidity = currentConditions["humidity"] as? String
//        wind = currentConditions["wind"] as? [String: Int]
//        iconURL = currentConditions["iconURL"] as? String
//        comment = currentConditions["comment"] as? String
//    }
//
//    static func getCurrentWeather(from value: Any) -> CurrentConditions {
//        guard let currentConditions = value as? [String: Any] else {
//            return CurrentConditions.init(currentConditions: ["dayhour" : 0])
//        }
//        let currentCondition = CurrentConditions(currentConditions: currentConditions)
//        print(currentCondition)
//        return currentCondition
//    }
}

struct NextDays: Decodable {
    let day : String?
    let comment: String?
    let maxTemp: [String: Int]?
    let minTemp: [String: Int]?
    let iconURL: String?
    
//    init(forecast: [String: Any]) {
//        day = forecast["day"] as? String
//        comment = forecast["comment"] as? String
//        maxTemp = forecast["max_temp"] as? [String: Int]
//        minTemp = forecast["min_temp"] as? [String: Int]
//        iconURL = forecast["iconURL"] as? String
//    }
//
//    static func getForecast(from value: Any) -> [NextDays] {
//        var weatherForecasts: [NextDays] = []
//        guard let forecasts = value as? [[String: Any]] else { return [] }
//        for forecast in forecasts {
//
//        let weatherForecast = NextDays(forecast: forecast)
//        weatherForecasts.append(weatherForecast)
//        }
//        print(weatherForecasts)
//        return weatherForecasts
//    }
}

//MARK: - Enums
enum Link: String {
    case londonWeather = "https://weatherdbi.herokuapp.com/data/weather/london"
    case moscowWeather = "https://weatherdbi.herokuapp.com/data/weather/moscow"
    case newYorkWeather = "https://weatherdbi.herokuapp.com/data/weather/newYork"
    case seoulWeather = "https://weatherdbi.herokuapp.com/data/weather/seoul"
}

enum UnitOfSpeedMeasurement: String {
    case kilometres = "km"
    case mile
}

enum UnitOfTemperatureMeasurement: String {
    case celsius = "c"
    case fahrenheit = "f"
}
