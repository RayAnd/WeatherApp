//
//  Service.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 31/10/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation
import SwiftyJSON

let imageURLTemplate = "http://openweathermap.org/img/w/%@.png"

enum RequestError: Error {
    case invalidURL
}

protocol Service {
    var endpoint: String { get }
    
    func exequte<RequestType: Request>(request: RequestType, completion: @escaping (_ response: Response<RequestType.SerializerType.ResponseData>) -> ()) throws
}

protocol WeatherServiceProtocol: Service {
    func requestWeather(for city: String, completion: @escaping (_ response: Response<CityWeather>) -> ()) throws
}

class WeatherService: Service {
    let endpoint: String = "api.openweathermap.org"
    let path: String = "/data/2.5/"
    let serviceKey: String = "95d190a434083879a6398aafd54d9e73"
    
    let session: URLSession
    
    init() {
        session = URLSession.shared
    }
    
    func request<RequestType: Request>(from request: RequestType) throws -> URLRequest {
        guard let url = request.url(endpoint: endpoint, servicePath: path, params: ["apikey": serviceKey, "units": "metric"]) else {
            throw RequestError.invalidURL
        }
        
        let urlRequest: URLRequest = URLRequest(url: url)
        
        return urlRequest
    }
    
    func exequte<RequestType: Request>(request: RequestType, completion: @escaping (_ response: Response<RequestType.SerializerType.ResponseData>) -> ()) throws {
        session.dataTask(with: try self.request(from: request), completionHandler: { data, urlResponse, error in
            do {
                let responseData = try request.serializer.parse(data!)
            
                completion(.success(responseData))
            } catch let error {
                completion(.failed(error))
            }
        }).resume()
    }
}
