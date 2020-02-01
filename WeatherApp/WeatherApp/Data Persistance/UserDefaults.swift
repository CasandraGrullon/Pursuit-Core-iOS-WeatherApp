//
//  UserDefaults.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct UserPreferenceKey {
    static let zipcode = "Zipcode"
}

class UserPreference {
    
    private init() {}
    
    static let shared = UserPreference()
    
    func updateZipcode(with zipcode: String) {
        UserDefaults.standard.set(zipcode, forKey: UserPreferenceKey.zipcode)
    }
    func getZipcode() -> String? {
        guard let zip = UserDefaults.standard.object(forKey: UserPreferenceKey.zipcode) as? String else {
            return nil
        }
        return zip
    }
}
