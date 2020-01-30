//
//  Photo.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct PictureHits: Codable {
    let hits: [Picture]
}
struct Picture: Codable {
    let largeImageURL: String
}
