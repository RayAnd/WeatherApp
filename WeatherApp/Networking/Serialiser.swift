//
//  Serialiser.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 01/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation
import SwiftyJSON

enum SerialiserError: Error {
    case wrongFileFormat
}

protocol Serialiser {
    associatedtype ResponseData
    
    func parse(_ data: Data) throws -> ResponseData
}

struct CityWeatherSerialiser: Serialiser {
    typealias ResponseData = CityWeather
    
    func parse(_ data: Data) throws -> CityWeather {
        let json = JSON(data: data)    
        
        guard let weather: JSON = json["weather"].array?.first,
            let main: [String: JSON] = json["main"].dictionary,
            let type = weather["main"].string,
            let desc = weather["description"].string,
            let temp = main["temp"]?.double,
            let humid = main["humidity"]?.double else {
                throw SerialiserError.wrongFileFormat
        }
        
        return CityWeather(mainType: type, description: desc, tempreture: temp, humidity: humid)
    }
}
