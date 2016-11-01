//
//  Service.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 31/10/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case invalidURL
}

protocol Service {
    func exequte(request: Request, completion: () -> ()) throws
}

class HTTPService: Service {
    let endpoint: String = "http://api.openweathermap.org/data/2.5"
    let serviceKey: String = "95d190a434083879a6398aafd54d9e73"
    
    let session: URLSession
    
    init() {
        session = URLSession.shared
    }
    
    func request(from request: Request) throws -> URLRequest {
        guard let url = request.url(endpoint: endpoint, params: ["APIKEY": serviceKey]) else {
            throw RequestError.invalidURL
        }
        
        let urlRequest: URLRequest = URLRequest(url: url)
        
        return urlRequest
    }
    
    func exequte(request: Request, completion: () -> ()) throws {
        session.dataTask(with: try self.request(from: request), completionHandler: { data, urlResponse, error in
            
        })
    }
}
