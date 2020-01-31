//
//  WeatherSearchView.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherSearchView: UIView {

    public var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Your city's Weekly Forecast"
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()
    public var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return cv
    }()
    public var textField: UITextField = {
       let textBox = UITextField()
        textBox.backgroundColor = #colorLiteral(red: 0.870795846, green: 0.8656198382, blue: 0.8747749329, alpha: 1)
        textBox.placeholder = "enter your zipcode here"
        textBox.textAlignment = .center
        textBox.keyboardType = .numbersAndPunctuation
        return textBox
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
        setupCityLabelConstraints()
        setupCollectionViewConstraints()
        setupTextBoxConstraints()
    }
    
    private func setupCityLabelConstraints() {
        addSubview(cityNameLabel)
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    private func setupTextBoxConstraints() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
