//
//  WeatherForecastRequest.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 07/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherSearchResponseSerializer: JSONResponseSerializer {
    typealias ResponseData = [CityWeather]
    
    func parse(json: JSON) throws -> [CityWeather] {
        guard let cityList = json["list"].array else {
            throw SerializerError.wrongDataFormat
        }
        
        return try cityList.map { try CityWeather.serialize($0) }
    }
}

struct WeatherSearchReqest: Request {
    typealias SerializerType = WeatherSearchResponseSerializer
    
    let path: String = "find"
    let type: RequestType = .get
    let params: [String: Any]?
    let serializer: WeatherSearchResponseSerializer = WeatherSearchResponseSerializer()
    
    init(city: String) {
        params = [
            "q": city,
            "type": "like"
        ]
    }
}
