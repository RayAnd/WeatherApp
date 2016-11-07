//
//  WeatherServiceTests.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 07/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherServiceTests: XCTestCase {
    
    func testRequestShouldHaveAppKeyInParams() {
        // given 
        let weatherService = WeatherService()
        let request = MockRequest()
        
        do {
            // when
            let urlRequest = try weatherService.request(from: request)
            
            // then
            XCTAssertEqual(urlRequest.url?.absoluteString, "http://\(weatherService.endpoint)\(weatherService.path)test?apikey=\(weatherService.serviceKey)&units=metric")
        } catch {
            XCTFail("Should not fail here")
        }
    }
}
