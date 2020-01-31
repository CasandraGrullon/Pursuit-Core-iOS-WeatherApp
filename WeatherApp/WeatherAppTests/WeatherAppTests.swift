//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by casandra grullon on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    func testZipCodeHelper() {
        // arrange
        let zipcode = "94133"
        
        let exp = XCTestExpectation(description: "zipcode parsed")
        
        // act
        ZipCodeHelper.getLatLong(fromZipCode: zipcode) { (result) in
            switch result {
            case .failure(let locationError):
                XCTFail("error: \(locationError)")
            case .success(let coordinates):
                XCTAssertEqual(coordinates.lat, 37.8031176)
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 3.0)
    }
    
    func testDailyForecastSummary() {
        let dailyWeatherData = """
        {
          "latitude": 40.7754123,
          "longitude": -73.9829633,
          "timezone": "America/New_York",
          "currently": {
            "time": 1580423859,
            "summary": "Partly Cloudy",
            "icon": "partly-cloudy-night",
            "nearestStormDistance": 160,
            "nearestStormBearing": 216,
            "precipIntensity": 0,
            "precipProbability": 0,
            "temperature": 34.06,
            "apparentTemperature": 34.06,
            "dewPoint": 20.62,
            "humidity": 0.57,
            "pressure": 1027.5,
            "windSpeed": 1.83,
            "windGust": 6.32,
            "windBearing": 147,
            "cloudCover": 0.37,
            "uvIndex": 0,
            "visibility": 4.934,
            "ozone": 362.2
          },
          "daily": {
            "summary": "Light rain on Saturday through next Thursday.",
            "icon": "rain",
            "data": [{
              "time": 1580360400,
              "summary": "Clear throughout the day.",
              "icon": "clear-day",
              "sunriseTime": 1580386140,
              "sunsetTime": 1580422260,
              "moonPhase": 0.19,
              "precipIntensity": 0.0006,
              "precipIntensityMax": 0.0019,
              "precipIntensityMaxTime": 1580428800,
              "precipProbability": 0.02,
              "precipType": "snow",
              "precipAccumulation": 0.11,
              "temperatureHigh": 37.32,
              "temperatureHighTime": 1580417880,
              "temperatureLow": 32.29,
              "temperatureLowTime": 1580445720,
              "apparentTemperatureHigh": 36.82,
              "apparentTemperatureHighTime": 1580417880,
              "apparentTemperatureLow": 30.66,
              "apparentTemperatureLowTime": 1580472420,
              "dewPoint": 17.58,
              "humidity": 0.59,
              "pressure": 1026.2,
              "windSpeed": 4.32,
              "windGust": 14.6,
              "windGustTime": 1580379660,
              "windBearing": 27,
              "cloudCover": 0.23,
              "uvIndex": 2,
              "uvIndexTime": 1580403960,
              "visibility": 9.65,
              "ozone": 356.8,
              "temperatureMin": 24.08,
              "temperatureMinTime": 1580385600,
              "temperatureMax": 37.32,
              "temperatureMaxTime": 1580417880,
              "apparentTemperatureMin": 16.97,
              "apparentTemperatureMinTime": 1580379480,
              "apparentTemperatureMax": 36.82,
              "apparentTemperatureMaxTime": 1580417880
            }]
          }
        }
        """.data(using: .utf8)!
        let exp = XCTestExpectation(description: "Light rain on Saturday through next Thursday.")
        do {
            let decoder = try JSONDecoder().decode(Weather.self, from: dailyWeatherData)
            XCTAssertEqual(decoder.daily.summary, exp.description)
        } catch {
            XCTFail("could not convert to data")
        }
    }
    
}
