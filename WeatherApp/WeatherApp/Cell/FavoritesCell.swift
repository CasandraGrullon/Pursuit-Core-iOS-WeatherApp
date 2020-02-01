//
//  FavoritesCell.swift
//  WeatherApp
//
//  Created by casandra grullon on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

class FavoritesCell: UITableViewCell {

    
    @IBOutlet weak var cellImageView: UIImageView!
    
    
    public func congigureCell(for fave: Picture) {
        cellImageView.getImage(with: fave.largeImageURL ) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.cellImageView.image = UIImage(systemName: "heart.circle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.cellImageView.image = image
                }
            }
        }
    }

}
