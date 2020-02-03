//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    public var favoritesView = FavoritesView()
    
    //private var detailVC = DetailVC()
    public var persistenceHelper: PersistenceHelper!
    
    public var favePics = [Picture]() {
        didSet {
            DispatchQueue.main.async {
                self.favoritesView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //detailVC.delegate = self
        favoritesView.collectionView.delegate = self
        favoritesView.collectionView.dataSource = self
        loadFavorites()
        favoritesView.collectionView.register(UINib(nibName: "FavoritesCell", bundle: nil), forCellWithReuseIdentifier: "favoritesCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadFavorites()
    }
    
    private func loadFavorites() {
        do {
            favePics = try persistenceHelper.loadPhotos()
        } catch {
            print("could not load faves")
        }
    }
    
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favePics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoritesView.collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath) as? FavoritesCell else {
            fatalError("could not cast to favorites cell")
        }
        let fave = favePics[indexPath.row]
        cell.congigureCell(for: fave)
        return cell
    }
    
    
}
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.95 // 95%
        return CGSize(width: itemWidth, height: itemWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
}

extension FavoritesViewController: FavoritesDelegate {
    func didAddToFaves(pic: Picture) {
        favePics.append(pic)

    }
    
    
}
