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

protocol Request {
    var path: String { get }
    var type: RequestType { get }
    var params: [String: Any] { get }
}

extension Request {
    func url(endpoint: String, params additionalParams: [String: Any]? = nil) -> URL? {
        var components: URLComponents? = URLComponents(string: endpoint)
        components?.query = path
        
        if self.type == .get {
            components?.queryItems = self.params.map({ (key, value) -> URLQueryItem in
                return URLQueryItem(name: key, value: String(describing: value))
            })
        }
        
        return components?.url
    }
}

struct CityWeatherRequest {
    let path: String = "weather"
    let type: RequestType = .get
    let params: [String: Any]
    
    init(city: String) {
        params = ["q": city]
    }
}
