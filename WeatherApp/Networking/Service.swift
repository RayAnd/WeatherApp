//
//  Service.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 31/10/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation
import SwiftyJSON

enum RequestError: Error {
    case invalidURL
}

protocol Service {
    var endpoint: String { get }
    
    func exequte<ResponseData, SerialiserType>(request: Request<ResponseData, SerialiserType>, completion: @escaping (_ response: Response<ResponseData>) -> ()) throws
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
    
    func request<ResponseData, SerialiserType>(from request: Request<ResponseData, SerialiserType>) throws -> URLRequest {
        guard let url = request.url(endpoint: endpoint, servicePath: path, params: ["apikey": serviceKey, "units": "metric"]) else {
            throw RequestError.invalidURL
        }
        
        let urlRequest: URLRequest = URLRequest(url: url)
        
        return urlRequest
    }
    
    func exequte<ResponseData, SerialiserType>(request: Request<ResponseData, SerialiserType>, completion: @escaping (_ response: Response<ResponseData>) -> ()) throws {
        session.dataTask(with: try self.request(from: request), completionHandler: { data, urlResponse, error in
            do {
                let responseData: ResponseData = try request.serialiser.parse(data!)
            
                completion(.success(responseData))
            } catch let error {
                completion(.failed(error))
            }
        }).resume()
    }
}

extension WeatherService: WeatherServiceProtocol {
    
    func requestWeather(for city: String, completion: @escaping (_ response: Response<CityWeather>) -> ()) throws {
        let request: Request<CityWeather, CityWeatherSerialiser> = Request<CityWeather, CityWeatherSerialiser>.weather(for: city)
        try self.exequte(request: request, completion: completion)
    }
}
