//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    private var detailVC = DetailVC()
    public var favePics = [Picture]() {
        didSet {
            DispatchQueue.main.async {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailVC.delegate = self
        loadFavorites()
    }
    
    private func loadFavorites() {
        do {
            favePics = try detailVC.persistenceHelper.loadPhotos()
        } catch {
            print("could not load faves")
        }
    }

}



extension FavoritesViewController: FavoritesDelegate {
    func didAddToFaves(pic: Picture) {
        favePics.append(pic)
    }
}
