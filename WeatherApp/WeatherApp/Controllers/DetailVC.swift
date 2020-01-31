//
//  DetailVC.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    public var dayForecast: DailyForecast?
    private var detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        updateUI()
    }
    
    private func loadPhotoData(photo: String) {
        PhotoAPIClient.getPhotoJournals(for: photo) { [weak self] (result) in
            switch result {
            case .failure:
                
            }
        }
    }
    
    private func updateUI() {
        detailView.dayLabel.text = dayForecast?.time.convertTime()
        detailView.summaryLabel.text = dayForecast?.summary
        detailView.lowTempLabel.text = "Low: \(dayForecast?.temperatureLow ?? 0)°F"
        detailView.highTempLabel.text = "High: \(dayForecast?.temperatureHigh ?? 0)°F"
        detailView.sunriseLabel.text = "Sunrise: \(dayForecast?.sunriseTime.convertTime() ?? "")"
        detailView.sunsetLabel.text = "Sunset: \(dayForecast?.sunsetTime.convertTime() ?? "")"
        detailView.precipLabel.text = "\(dayForecast?.precipProbability ?? 0)% chance of \(dayForecast?.precipType ?? "")"
        detailView.windspeedLabel.text = "Windspeed: \(dayForecast?.windSpeed ?? 0)"
    }

}
