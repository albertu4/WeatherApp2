//
//  WeatherCollectionViewController.swift
//  WeatherApp
//
//  Created by Михаил Иванов on 19.02.2022.
//

import UIKit
import Alamofire

class WeatherCollectionViewController: UICollectionViewController {
    
    //MARK: - Private properties
    private var weather: Weather?
    private let temperatureMeasurement = UnitOfTemperatureMeasurement.celsius.rawValue
    private let windSpeedMeasurement = UnitOfSpeedMeasurement.kilometres.rawValue
    private let actualWeather = Link.londonWeather.rawValue
    
    //MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        fetchWeather(url: actualWeather)
//        fetchDataWithAlamofire(url: actualWeather)
        fetchAlamofire(url: actualWeather)
        
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return weather?.nextDays?.count ?? 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // CurrentDay section
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "currentDay", for: indexPath
            ) as! CurrentWeatherCollectionViewCell
            
            guard let currentWeather = weather?.currentConditions
            else { return cell }
            
            cell.showCurrentWeatherData(
                currentWeather: currentWeather,
                temperatureMeasurement: temperatureMeasurement,
                windSpeedMeasurement: windSpeedMeasurement
            )
            return cell
            
            //Forecast section
        default:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "forecast", for: indexPath
            ) as! ForecastCollectionViewCell
            
            guard let forecastWeather = weather?.nextDays?[indexPath.row]
            else { return cell }
            
            cell.showForecast(
                forecast: forecastWeather,
                temperatureMeasurement: temperatureMeasurement,
                windSpeedMeasurement: windSpeedMeasurement
            )
            
            return cell
        }
    }
    
    //MARK: - Private methods
    private func fetchWeather(url: String) {
        NetworkManager.shared.fetchWeather(link: url) { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.weather = weather
                    self.title = weather.region
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    private func fetchDataWithAlamofire(url: String) {
//        NetworkManager.shared.fetchDataWithAlamofire(link: actualWeather) { result in
//            switch result {
//            case .success(let weather):
//                self.weather = weather
//                print(self.weather)
//                self.collectionView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
//    private func fetchDataWithAlamofire(url: String) {
//        NetworkManager.shared.fetchDataWithAlamofire(link: actualWeather) { result in
//            switch result {
//            case .success(let weather):
//                self.weather = weather
//                self.collectionView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    private func fetchAlamofire(url: String) {
        AF.request(url)
            .validate()
            .responseJSON { responseData in
                switch responseData.result {
                case .success(let value):
                    
                    guard let weathersData = value as? [String: Any] else { return }
                    
                    let currentCondition = CurrentConditions(
                                    dayhour: weathersData["dayhour"] as? String,
                                    temp: weathersData["temp"] as? [String: Int],
                                    precip: weathersData["precip"] as? String,
                                    humidity: weathersData["humidity"] as? String,
                                    wind: weathersData["wind"] as? [String: Int],
                                    iconURL: weathersData["iconURL"] as? String,
                                    comment: weathersData["comment"] as? String
                                )
                    
                    let forecast = NextDays(
                                    day: forecasts["day"] as? String,
                                    comment: weathersData["comment"] as? String,
                                    maxTemp: weathersData["max_temp"] as? [String: Int],
                                    minTemp: weathersData["min_temp"] as? [String: Int],
                                    iconURL: forecasts["iconURL"] as? String
                                )
                    
                    let fullWeather = Weather(
                        region: weathersData["region"] as? String,
                        currentConditions: weathersData["currentConditions"] as? currentCondition,
                        nextDays: weathersData["next_days"] as? [forecast]
                    )
                    
                    
                    
                    
                    
                    self.weather = fullWeather
                    print(fullWeather)
                    self.collectionView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
        
//        CurrentConditions(
//            dayhour: data["dayhour"] as? String,
//            temp: data["temp"] as? [String: Int],
//            precip: data["precip"] as? String,
//            humidity: data["humidity"] as? String,
//            wind: data["wind"] as? [String: Int],
//            iconURL: data["iconURL"] as? String,
//            comment: data["comment"] as? String
//        )
        
//        NextDays(
//            day: data["day"] as? String,
//            comment: data["comment"] as? String,
//            maxTemp: data["max_temp"] as? [String: Int],
//            minTemp: data["min_temp"] as? [String: Int],
//            iconURL: data["iconURL"] as? String
//        )
    }
    //                            CurrentConditions(
    //                                dayhour: weather["dayhour"] as? String,
    //                                temp: weather["temp"] as? [String: Int],
    //                                precip: weather["precip"] as? String,
    //                                humidity: weather["humidity"] as? String,
    //                                wind: weather["wind"] as? [String: Int],
    //                                iconURL: weather["iconURL"] as? String,
    //                                comment: weather["comment"] as? String
    //                            ),
}

//MARK: - Extensions
extension WeatherCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 440)
        default:
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}
