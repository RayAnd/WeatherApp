//
//  Serializer.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 01/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

enum SerializerError: Error {
    case wrongDataFormat
}

protocol ResponseSerializer {
    associatedtype ResponseData
    
    func parse(_ data: Data) throws -> ResponseData
}

protocol JSONResponseSerializer: ResponseSerializer {
    func parse(json: JSON) throws -> ResponseData
}

extension JSONResponseSerializer {
    func parse(_ data: Data) throws -> ResponseData {
        let json = JSON(data: data)
        
        return try parse(json: json)
    }
}
