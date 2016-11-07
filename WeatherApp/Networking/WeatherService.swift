//
//  WeatherServie.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 07/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation

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
                if let responseData = data {
                    let responseObject = try request.serializer.parse(responseData)
                    
                    DispatchQueue.main.async {
                        completion(.success(responseObject))
                    }
                } else if let error = error {
                    DispatchQueue.main.async {
                        completion(.failed(error))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failed(RequestError.responseDataInvalid))
                    }
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failed(error))
                }
            }
        }).resume()
    }
}
