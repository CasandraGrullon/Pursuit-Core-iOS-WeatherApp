//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by casandra grullon on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import XCTest

class WeatherAppTests: XCTestCase {
    
    func testZipCodeHelper() {
        // arrange
        let zipcode = "10023"
        
        let exp = XCTestExpectation(description: "zipcode parsed")
        
        // act
        
        
        wait(for: [exp], timeout: 3.0)
    }
    
    
}
