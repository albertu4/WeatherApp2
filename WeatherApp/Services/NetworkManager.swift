//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Михаил Иванов on 18.02.2022.

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchWeather(link: Link.RawValue, completion: @escaping (Result<Weather, NetworkError>) -> ()) {
        guard let url = URL(string: link) else {
            completion(.failure(.invalidURL))
            return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weather = try decoder.decode(Weather.self, from: data)
                completion(.success(weather))
            } catch let error {
                completion(.failure(.decodingError))
                print(error)
            }
        }.resume()
    }
    
//    func fetchDataWithAlamofire(link: Link.RawValue) {
//        AF.request(link)
//            .validate()
//            .responseJSON { dataResponse in
//                print(dataResponse)
                    
//                            CurrentConditions(
//                                dayhour: weathersData["dayhour"] as? String,
//                                temp: weathersData["temp"] as? [String: Int],
//                                precip: weathersData["precip"] as? String,
//                                humidity: weathersData["humidity"] as? String,
//                                wind: weathersData["wind"] as? [String: Int],
//                                iconURL: weathersData["iconURL"] as? String,
//                                comment: weathersData["comment"] as? String
//                            )
                            
                            
//                                [NextDays(
//                                    day: weathersData["day"] as? String,
//                                    comment: weathersData["comment"] as? String,
//                                    maxTemp: weathersData["max_temp"] as? [String: Int],
//                                    minTemp: weathersData["min_temp"] as? [String: Int],
//                                    iconURL: weathersData["iconURL"] as? String)]
                        
//            }
//    }
}

class IconManager {
    
    static var shared = IconManager()
    private init() {}
    
    func fetchWeatherIconData(from link: String?, completion: @escaping(Data) -> Void) {
        guard let stringURL = link else { return }
        guard let url = URL(string: stringURL) else {
            print(NetworkError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(NetworkError.noData)
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
}
