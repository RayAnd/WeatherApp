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
}

protocol Request {
    associatedtype SerializerType: ResponseSerializer
    
    var path: String { get }
    var type: RequestType { get }
    var params: [String: Any]? { get }
    var serializer: SerializerType { get }
}

extension Request {
    func url(endpoint: String, servicePath: String, params additionalParams: [String: Any]? = nil) -> URL? {
        var components: URLComponents = URLComponents()
        components.scheme = "http"
        components.host = endpoint
        components.path = servicePath + path
        
        if self.type == .get, let params = self.params {
            components.queryItems = params.map({ (key, value) -> URLQueryItem in
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
