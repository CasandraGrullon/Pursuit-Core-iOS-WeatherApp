//
//  DetailVC.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import AVFoundation

protocol FavoritesDelegate: AnyObject {
    func didAddToFaves(pic: Picture)
}

class DetailVC: UIViewController {
    
    public var dayForecast: DailyForecast?
    public var picture: Picture?
    private var detailView = DetailView()
    private var addedToFaves = true
    public var persistenceHelper = PersistenceHelper(filename: "weatherAppFavorites.plist")
    
    weak var delegate: FavoritesDelegate?
    
    override func loadView() {
        view = detailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        updateUI()
        configureNavBar()
    }

    private func updateUI() {
        detailView.dayLabel.text = dayForecast?.time.convertDate()
        detailView.summaryLabel.text = dayForecast?.summary
        detailView.lowTempLabel.text = "Low: \(dayForecast?.temperatureLow ?? 0)°F"
        detailView.highTempLabel.text = "High: \(dayForecast?.temperatureHigh ?? 0)°F"
        detailView.sunriseLabel.text = "Sunrise: \(dayForecast?.sunriseTime.convertTime() ?? "")"
        detailView.sunsetLabel.text = "Sunset: \(dayForecast?.sunsetTime.convertTime() ?? "")"
        detailView.precipLabel.text = "\(dayForecast?.precipProbability ?? 0)% chance of \(dayForecast?.precipType ?? "")"
        detailView.windspeedLabel.text = "Windspeed: \(dayForecast?.windSpeed ?? 0)"
        detailView.imageView.getImage(with: picture?.largeImageURL ?? "") { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.detailView.imageView.image = UIImage(systemName: "sun.max")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailView.imageView.image = image
                }
            }
        }
    }
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonPressed(_:)))
    }
    
    @objc
    private func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        guard let favorited = picture else {
            return
        }
        let faved = Picture(largeImageURL: favorited.largeImageURL)
//        let filledHeart = UIImage(systemName: "heart.filled")
//        let emptyHeart = UIImage(systemName: "heart")
//
//        addedToFaves.toggle()
//
//        if addedToFaves == true {
//            sender.setBackgroundImage(filledHeart, for: .normal, barMetrics: .compactPrompt)
//        } else {
//            sender.setBackgroundImage(emptyHeart, for: .normal, barMetrics: .compactPrompt)
//        }
        do {
            try persistenceHelper.create(photo: faved)
            delegate?.didAddToFaves(pic: faved)
            let favoritesVC = FavoritesViewController()
            favoritesVC.favePics = [faved]
        } catch {
            print("cannot be saved \(error)")
        }
    }
    
}
extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
