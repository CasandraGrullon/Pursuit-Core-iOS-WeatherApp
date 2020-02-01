//
//  FavoritesView.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesView: UIView {
    
    public lazy var tableView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal
       let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
       cv.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
       return cv
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
        tableViewConstraints()
    }
    private func tableViewConstraints() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
