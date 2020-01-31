//
//  Weather.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct Weather : Codable {
    var latitude: Double
    var longitude: Double
    let timezone: String
    let daily: Daily
}
struct Daily: Codable {
    let summary: String
    let data: [DailyForecast]
}
struct DailyForecast: Codable {
    let summary: String?
    let time: Double
    let icon: String
    let sunriseTime: Double
    let sunsetTime: Double
    let precipProbability: Double
    let precipType: String?
    let temperatureHigh: Double
    let temperatureLow: Double
    let windSpeed: Double
}
