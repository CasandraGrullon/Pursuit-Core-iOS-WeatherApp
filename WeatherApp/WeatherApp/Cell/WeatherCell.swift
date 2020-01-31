//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

class WeatherCell: UICollectionViewCell {
 
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    private lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    private lazy var highTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        setupDateConstraints()
        setupImageConstraints()
        setupLowTempConstraints()
        setupHighTempConstraints()
    }
    
    private func setupDateConstraints() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    private func setupImageConstraints() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    private func setupLowTempConstraints() {
        addSubview(lowTempLabel)
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowTempLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            lowTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            lowTempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    private func setupHighTempConstraints() {
        addSubview(highTempLabel)
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highTempLabel.topAnchor.constraint(equalTo: lowTempLabel.bottomAnchor, constant: 8),
            highTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            highTempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    public func configureCell(weather: DailyForecast) {
        lowTempLabel.text = "low: \(weather.temperatureLow)°F"
//        highTempLabel.text = "high: \(weather.temperatureHigh )°F"
//        imageView.getImage(with: weather.icon ) { [weak self] (result) in
//            switch result {
//            case .failure:
//                DispatchQueue.main.async {
//                    self?.imageView.image = UIImage(systemName: "sun.max")
//                }
//            case .success(let image):
//                DispatchQueue.main.async {
//                    self?.imageView.image = image
//                }
//            }
//        }
        
    }
}
