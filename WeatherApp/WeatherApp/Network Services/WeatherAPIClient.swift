//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct WeatherAPIClient {
    static func getWeather(lat: Double, long: Double, completion: @escaping (Result<Weather, AppError>) -> () ) {
        let endpointUrl = "https://api.darksky.net/forecast/\(Secrets.darkSkyKey)/\(lat),\(long)"
        guard let url = URL(string: endpointUrl) else {
            completion(.failure(.badURL(endpointUrl)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(Weather.self, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
