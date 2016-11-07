//
//  StubbModels.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 07/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation
@testable import WeatherApp

struct MockResponseSerialiser: ResponseSerializer {
    typealias ResponseData = Any
    
    func parse(_ data: Data) throws -> Any {
        return data
    }
}

class MockRequest : Request {
    typealias SerializerType = MockResponseSerialiser
    
    var path: String = "test"
    var type: RequestType = .get
    var params: [String : Any]? = nil
    var serializer: MockResponseSerialiser = MockResponseSerialiser()
    
    func setPath(path: String) -> Self {
        self.path = path
        return self
    }
    
    func setParams(params: [String: Any]) -> Self {
        self.params = params
        return self
    }
}
