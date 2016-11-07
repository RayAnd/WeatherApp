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
    case responseDataInvalid
}

protocol Service {
    var endpoint: String { get }
    
    func exequte<RequestType: Request>(request: RequestType, completion: @escaping (_ response: Response<RequestType.SerializerType.ResponseData>) -> ()) throws
}
