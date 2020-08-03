//
//  WeatherSearchView.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherSearchView: UIView {
    
    public var summaryLabelTopAnchor: NSLayoutConstraint?
    
    override func layoutSubviews() {
        self.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        textField.layer.cornerRadius = 13
    }
    public var summaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        return label
    }()
    public var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear 
        return cv
    }()
    public var textField: UITextField = {
       let textBox = UITextField()
        textBox.backgroundColor = .white
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
        setupSummaryLabelConstraints()
        setupCollectionViewConstraints()
        setupTextBoxConstraints()
    }
    private func setupSummaryLabelConstraints() {
        addSubview(summaryLabel)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        summaryLabelTopAnchor = summaryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        summaryLabelTopAnchor?.isActive = true
    }
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10),
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
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
