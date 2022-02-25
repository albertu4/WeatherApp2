//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Михаил Иванов on 18.02.2022.

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchWeather(link: Link.RawValue, completion: @escaping (Result<Weather, Error>) -> ()) {
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(weather))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
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
