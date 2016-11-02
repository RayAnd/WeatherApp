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

struct WeatherSearchResponseSerializer: JSONResponseSerializer {
    typealias ResponseData = [CityWeather]
    
    func parse(json: JSON) throws -> [CityWeather] {
        guard let cityList = json["list"].array else {
            throw SerializerError.wrongDataFormat
        }
        
        return try cityList.map { try CityWeather.serialize($0) }
    }
}

protocol JSONSerializable {
    static func serialize(_ json: JSON) throws -> Self
}

extension Town : JSONSerializable {
    static func serialize(_ json: JSON) throws -> Town {
        guard let id = json["id"].int32,
            let name = json["name"].string,
            let country = json["sys"].dictionary?["country"]?.string else {
            throw SerializerError.wrongDataFormat
        }
        
        return Town(id: id, city: name, country: country, coordinates: CLLocationCoordinate2D())
    }
}

extension WeatherForecast : JSONSerializable {
    static func serialize(_ json: JSON) throws -> WeatherForecast {
        guard let icon = json["icon"].string,
            let forecast = json["main"].string,
            let details = json["description"].string else {
                throw SerializerError.wrongDataFormat
        }
        
        return WeatherForecast(icon: icon, forecast: forecast, details: details)
    }
}

extension Temperature : JSONSerializable {
    static func serialize(_ json: JSON) throws -> Temperature {
        guard let main = json["main"].dictionary,
            let tempreture = main["temp"]?.double,
            let presure = main["pressure"]?.double,
            let humid = main["humidity"]?.double,
            let min = main["temp_min"]?.double,
            let max = main["temp_max"]?.double else {
                throw SerializerError.wrongDataFormat
        }
        
        return Temperature(temperature: tempreture, presure: presure, humidity: humid, max: max, min: min)
    }
}

extension CityWeather : JSONSerializable {
    static func serialize(_ json: JSON) throws -> CityWeather {
        guard let date = json["dt"].int64,
            let weatherArray = json["weather"].array else {
            throw SerializerError.wrongDataFormat
        }
        
        let town = try Town.serialize(json)
        let weather = try weatherArray.map { try WeatherForecast.serialize($0) }
        let temperature = try Temperature.serialize(json)
        
        return CityWeather(town: town, date: Date(timeIntervalSince1970: TimeInterval(date)), weather: weather, temperature: temperature)
    }
}

