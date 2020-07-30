//
//  TabBar.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherTabBarController: UITabBarController {
    
    public var persistenceHelper = PersistenceHelper(filename: "weatherAppFavorites.plist")
    
    private lazy var weatherSearchVC: WeatherSearchViewController = {
        let viewcontroller = WeatherSearchViewController()
        viewcontroller.view.backgroundColor = .white
        viewcontroller.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        viewcontroller.persistenceHelper = persistenceHelper
        return viewcontroller
    }()
    
    private lazy var favoritesVC: FavoritesViewController = {
        let vc = FavoritesViewController()
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        vc.persistenceHelper = persistenceHelper
        return vc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewControllers = [UINavigationController(rootViewController: weatherSearchVC),UINavigationController(rootViewController:favoritesVC)]

    }

    
}
