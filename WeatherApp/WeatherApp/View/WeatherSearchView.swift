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
        label.textAlignment = .center
        return label
    }()
    public var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return cv
    }()
    public var textField: UITextField = {
       let textBox = UITextField()
        return textBox
    }()
    public var enterHereLabel: UILabel = {
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
        setupCityLabelConstraints()
        setupCollectionViewConstraints()
    }
    
    private func setupCityLabelConstraints() {
        addSubview(cityNameLabel)
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
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
            collectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    private func setupTextBoxConstraints() {
        
    }
    
}
