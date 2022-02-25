//
//  Weather.swift
//  WeatherApp
//
//  Created by Михаил Иванов on 18.02.2022.

struct Weather: Decodable {
    let region: String?
    let currentConditions: CurrentConditions?
    let next_days: [NextDays]?
}

struct CurrentConditions: Decodable {
    let dayhour: String?
    let temp: [String: Int]?
    let precip: String?
    let humidity: String?
    let wind: [String: Int]?
    let iconURL: String?
    let comment: String?
}

struct NextDays: Decodable {
    let day : String?
    let comment: String?
    let max_temp: [String: Int]?
    let min_temp: [String: Int]
    let iconURL: String?
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
