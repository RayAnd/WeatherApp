//
//  WeatherSearchRequestTests.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 07/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherSearchRequestTests: XCTestCase {
    
    func testRequestPath() {
        // given
        let request = WeatherSearchReqest(city: "TestCity")
        
        // then
        XCTAssertEqual(request.path, "find")
    }
    
    func testRequestShouldHaveCityNameInParams() {
        // given
        let request = WeatherSearchReqest(city: "TestCity")
        
        // then
        XCTAssertEqual(request.params?["q"] as? String, "TestCity")
    }
    
    func testRequestShouldHaveTypeNameInParams() {
        // given
        let request = WeatherSearchReqest(city: "TestCity")
        
        // then
        XCTAssertEqual(request.params?["type"] as? String, "like")
    }
}
