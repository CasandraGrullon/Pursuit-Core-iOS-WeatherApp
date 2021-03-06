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
    private var keyboardIsVisible = false
    private var originalConstraint: NSLayoutConstraint!
    private var summaryLabelTopConstraint: NSLayoutConstraint!
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()
    private var weeklyWeather = [DailyForecast]() {
        didSet {
            DispatchQueue.main.async {
                self.weatherSearchView.collectionView.reloadData()
            }
        }
    }
    private var photo = [Picture]()
    public var persistenceHelper: PersistenceHelper!
    private var zipCode = String() {
        didSet {
            getCoordinates(zipcode: zipCode)
        }
    }
    override func loadView() {
        weatherSearchView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        view = weatherSearchView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherSearchView.addGestureRecognizer(tapGesture)
        weatherSearchView.collectionView.delegate = self
        weatherSearchView.collectionView.dataSource = self
        weatherSearchView.textField.delegate = self
        weatherSearchView.collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "WeatherCell")
        zipCode = UserPreference.shared.getZipcode() ?? ""
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        registerKeyboardNotifications()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        unregisterKeyboardNotifications()
    }
    //MARK:- Keyboard Handling
    @objc private func didTap(_ gesture: UITapGestureRecognizer ) {
        weatherSearchView.textField.resignFirstResponder()
    }
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
        }
        moveKeyboardUp(keyboardFrame.size.height)
    }
    private func moveKeyboardUp(_ height: CGFloat) {
        if keyboardIsVisible { return }
        
        UIView.animate(withDuration: 0.3) {
            
            self.weatherSearchView.summaryLabelTopAnchor?.isActive = false
            self.weatherSearchView.summaryLabelTopAnchor = self.weatherSearchView.summaryLabel.topAnchor.constraint(equalTo: self.weatherSearchView.safeAreaLayoutGuide.topAnchor, constant: -(height / 2))
            self.weatherSearchView.summaryLabelTopAnchor?.isActive = true
            self.weatherSearchView.layoutIfNeeded()
        }
        keyboardIsVisible = true
    }
    
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc
    private func keyboardWillHide(_ notification: NSNotification) {
        resetUI()
    }
    private func resetUI() {
        keyboardIsVisible = false
        
        UIView.animate(withDuration: 0.3) {
            self.weatherSearchView.summaryLabelTopAnchor?.isActive = false
            self.weatherSearchView.summaryLabelTopAnchor = self.weatherSearchView.summaryLabel.topAnchor.constraint(equalTo: self.weatherSearchView.safeAreaLayoutGuide.topAnchor, constant: 20)
            self.weatherSearchView.summaryLabelTopAnchor?.isActive = true
            self.weatherSearchView.layoutIfNeeded()
        }
    }
    //MARK:- Data functions
    public func getCoordinates(zipcode: String) {
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) { [weak self] (result) in
            switch result {
            case .failure(let zipcodeError):
                print("getCoordinates error: \(zipcodeError)")
            case .success(let coordinates):
                self?.getWeather(lat: coordinates.lat, long: coordinates.long)
                DispatchQueue.main.async {
                    self?.navigationItem.title = coordinates.placeName
                    self?.loadPhotoData(photo: coordinates.placeName)
                }
            }
        }
    }
    public func getWeather(lat: Double, long: Double) {
        WeatherAPIClient.getWeather(lat: lat, long: long) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("getWeather error: \(appError)")
            case .success(let dailyForecast):
                self?.weeklyWeather = dailyForecast.daily.data
                DispatchQueue.main.async {
                    self?.weatherSearchView.summaryLabel.text = dailyForecast.daily.summary
                }
            }
        }
    }
    public func loadPhotoData(photo: String) {
        PhotoAPIClient.getPhotoJournals(for: photo) { [weak self] (result) in
            switch result {
            case .failure(let photoError):
                print(photoError)
            case .success(let picture):
                self?.photo = picture
            }
        }
    }
}
extension WeatherSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zipCode = textField.text ?? ""
        UserPreference.shared.updateZipcode(with: zipCode)
        textField.resignFirstResponder()
        return true
    }
}
extension WeatherSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 0.2
        let maxWidth = UIScreen.main.bounds.size.width
        let numberOfItems: CGFloat = 1
        let totalSpace: CGFloat = numberOfItems * itemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpace) / numberOfItems
        return CGSize(width: itemWidth/3, height: itemWidth/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = weeklyWeather[indexPath.row]
        let detailVC = DetailVC()
        detailVC.dayForecast = day
        detailVC.picture = photo[indexPath.row]
        detailVC.persistenceHelper = persistenceHelper
        navigationController?.pushViewController(detailVC, animated: true)
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
        cell.backgroundColor = .white
        cell.configureCell(weather: forecast)
        return cell
    }
    
}
