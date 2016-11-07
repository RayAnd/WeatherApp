//
//  TownTests.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 07/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import XCTest
@testable import WeatherApp

class TownTests: XCTestCase {
    
    func testExample() {
        // given
        let town = Town(id: 1, city: "London", country: "GB")
        
        //then
        XCTAssertEqual(town.fullCityName, "London, GB")
    }
}
