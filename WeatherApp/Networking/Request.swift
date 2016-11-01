//
//  Request.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 31/10/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation

enum RequestType {
    case get
    case post
}

struct Request<ResponseData, SerialiserType: Serialiser> where SerialiserType.ResponseData == ResponseData {
    let path: String
    let type: RequestType
    let params: [String: Any]
    let serialiser: SerialiserType
}

extension Request {
    func url(endpoint: String, servicePath: String, params additionalParams: [String: Any]? = nil) -> URL? {
        var components: URLComponents = URLComponents()
        components.scheme = "http"
        components.host = endpoint
        components.path = servicePath + path
        
        if self.type == .get {
            components.queryItems = self.params.map({ (key, value) -> URLQueryItem in
                return URLQueryItem(name: key, value: String(describing: value))
            })
        }
        
        if let serviceParams = additionalParams {
            let moreParams: [URLQueryItem] = serviceParams.map({ (key, value) -> URLQueryItem in
                return URLQueryItem(name: key, value: String(describing: value))
            })
        
            if components.queryItems != nil {
                components.queryItems?.append(contentsOf: moreParams)
            } else {
                components.queryItems = moreParams
            }
        }
        
        return components.url
    }    
}

extension Request {
    
    static func weather(for city: String) -> Request<CityWeather, CityWeatherSerialiser> {
        return Request<CityWeather, CityWeatherSerialiser>(path: "weather", type: .get, params: ["q": city], serialiser: CityWeatherSerialiser())
    }
}
