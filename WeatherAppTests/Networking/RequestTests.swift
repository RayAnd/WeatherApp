//
// Created by Andrey Kozlov on 01/11/2016.
// Copyright (c) 2016 ebay. All rights reserved.
//

import XCTest
@testable import WeatherApp

class RequestTests: XCTestCase {

    func testRequestURLGeneration() {
        // given
        let endpoint = "test.endpoint"
        let servicePath = "/somePath/"
        
        // when 
        let url = MockRequest().url(endpoint: endpoint, servicePath: servicePath)
        
        // then
        XCTAssertEqual(url?.absoluteString, "http://" + endpoint + servicePath + "test")
    }
    
    func testRequestURLGenerationWithServiceParams() {
        // given
        let endpoint = "test.endpoint"
        let servicePath = "/somePath/"
        
        // when
        let url = MockRequest().url(endpoint: endpoint, servicePath: servicePath, params: ["service": 2])
        
        // then
        XCTAssertEqual(url?.absoluteString, "http://" + endpoint + servicePath + "test?service=2")
    }
    
    func testRequestURLGenerationWithParameters() {
        // given
        let endpoint = "test.endpoint"
        let servicePath = "/somePath/"
        let params: [String: Any] = ["test": 1, "test2": "some"]
        
        // when
        let url = MockRequest().setParams(params: params).url(endpoint: endpoint, servicePath: servicePath)
        
        // then
        XCTAssertEqual(url?.absoluteString, "http://" + endpoint + servicePath + "test?test=1&test2=some")
    }
    
    func testRequestURLGenerationWithParametersAndServiceParams() {
        // given
        let endpoint = "test.endpoint"
        let servicePath = "/somePath/"
        let params: [String: Any] = ["test": 1, "test2": "some"]
        
        // when
        let url = MockRequest().setParams(params: params).url(endpoint: endpoint, servicePath: servicePath, params: ["service": 2])
        
        // then
        XCTAssertEqual(url?.absoluteString, "http://" + endpoint + servicePath + "test?test=1&test2=some&service=2")
    }
}
