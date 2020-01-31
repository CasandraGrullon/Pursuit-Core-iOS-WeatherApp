//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherSearchViewController: UIViewController {

    private var weatherSearchView = WeatherSearchView()
    
    //private var weather: Weather?
    
    private var weeklyWeather = [DailyForecast]() {
        didSet {
            DispatchQueue.main.async {
                self.weatherSearchView.collectionView.reloadData()
            }
        }

    }
    private var zipCode = String() {
        didSet {
            getCoordinates(zipcode: zipCode)
        }
    }
    
    override func loadView() {
        view = weatherSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherSearchView.collectionView.delegate = self
        weatherSearchView.collectionView.dataSource = self
        weatherSearchView.textField.delegate = self
        weatherSearchView.collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "WeatherCell")
    }
    public func getCoordinates(zipcode: String) {
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) { [weak self] (result) in
            switch result {
            case .failure(let zipcodeError):
                print("getCoordinates error: \(zipcodeError)")
            case .success(let coordinates):
                //self?.weather?.latitude = coordinates.lat
                //self?.weather?.longitude = coordinates.long
                self?.getWeather(lat: coordinates.lat, long: coordinates.long)
            }
        }
    }
    public func getWeather(lat: Double, long: Double) {
        WeatherAPIClient.getWeather(lat: lat, long: long) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("getWeather error: \(appError)")
            case .success(let dailyForecast):
                //self?.weather = dailyForecast
                self?.weeklyWeather = dailyForecast.daily.data
            }
        }
    }

}
extension WeatherSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zipCode = textField.text ?? ""
        textField.resignFirstResponder()
        return true
    }
}
extension WeatherSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGFloat = UIScreen.main.bounds.size.width
        let itemWidth: CGFloat = maxSize * 0.25
        return CGSize(width: itemWidth, height: itemWidth/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
extension WeatherSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weeklyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherSearchView.collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
            fatalError("could not cast as WeatherCell")
        }
        let forecast = weeklyWeather[indexPath.row]
        cell.configureCell(weather: forecast)
        return cell
 }
    
    
}
