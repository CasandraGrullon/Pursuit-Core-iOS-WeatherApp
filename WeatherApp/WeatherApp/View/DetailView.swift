//
//  DetailView.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    public lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    public lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    public lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    public lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    public lazy var highTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    public lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    public lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    public lazy var precipLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    public lazy var windspeedLabel: UILabel = {
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
        dayLabelConstraints()
        imageViewConstraints()
        summaryLabelConstraints()
        lowTempConstraints()
        highTempConstraints()
        sunriseLabelConstraints()
        sunsetConstraints()
        precipLabelConstraints()
        windSpeedConstraints()
    }
    private func dayLabelConstraints() {
        addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    private func imageViewConstraints() {
       addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    private func summaryLabelConstraints() {
       addSubview(summaryLabel)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
        ])
    }
    private func lowTempConstraints() {
       addSubview(lowTempLabel)
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowTempLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10),
            lowTempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            lowTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
        ])
    }
    private func highTempConstraints() {
       addSubview(highTempLabel)
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highTempLabel.topAnchor.constraint(equalTo: lowTempLabel.bottomAnchor, constant: 10),
            highTempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            highTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
        ])
    }
    private func sunriseLabelConstraints() {
         addSubview(sunriseLabel)
          sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              sunriseLabel.topAnchor.constraint(equalTo: highTempLabel.bottomAnchor, constant: 10),
              sunriseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
              sunriseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
          ])
      }
    private func sunsetConstraints() {
         addSubview(sunsetLabel)
          sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 10),
              sunsetLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
              sunsetLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
          ])
      }
    private func precipLabelConstraints() {
         addSubview(precipLabel)
          precipLabel.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              precipLabel.topAnchor.constraint(equalTo: sunsetLabel.bottomAnchor, constant: 10),
              precipLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
              precipLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
          ])
      }
    private func windSpeedConstraints() {
         addSubview(windspeedLabel)
          windspeedLabel.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              windspeedLabel.topAnchor.constraint(equalTo: precipLabel.bottomAnchor, constant: 10),
              windspeedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
              windspeedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
          ])
      }

}
