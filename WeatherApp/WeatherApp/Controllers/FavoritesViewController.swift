//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    private var favoritesView = FavoritesView()
    
    override func loadView() {
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
