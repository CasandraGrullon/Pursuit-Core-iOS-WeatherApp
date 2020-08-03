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
    override func layoutSubviews() {
        self.layer.cornerRadius = 13
    }
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    private lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    private lazy var highTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
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
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    private func setupImageConstraints() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    private func setupLowTempConstraints() {
        addSubview(lowTempLabel)
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowTempLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
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
        dateLabel.text = weather.time.convertDate()
        lowTempLabel.text = "low: \(weather.temperatureLow)°F"
        highTempLabel.text = "high: \(weather.temperatureHigh )°F"
        imageView.image = UIImage(named: "\(weather.icon)")
    }
}

extension Double {
    func convertDate() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "MM/dd/yy"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    func convertTime() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
