//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var detailVC = DetailVC()
    public var favePics = [Picture]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailVC.delegate = self
        loadFavorites()
        tableView.dataSource = self
    }
    
    private func loadFavorites() {
        do {
            favePics = try detailVC.persistenceHelper.loadPhotos()
        } catch {
            print("could not load faves")
        }
    }

}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favePics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesCell else {
            fatalError("could not cast to favorites cell")
        }
        let fave = favePics[indexPath.row]
        cell.congigureCell(for: fave)
        return cell
    }
    
}

extension FavoritesViewController: FavoritesDelegate {
    func didAddToFaves(pic: Picture) {
        favePics.append(pic)
    }
}
