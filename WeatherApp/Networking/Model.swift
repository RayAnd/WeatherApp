//
//  Model.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 07/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation

struct Town {
    let id: Int32
    let city: String
    let country: String
}

extension Town {
    var fullCityName: String {
        return city + ", \(country)"
    }
}

struct WeatherForecast {
    let icon: String
    let forecast: String
    let details: String
}

struct Temperature {
    let temperature: Double
    let presure: Double
    let humidity: Double
    let max: Double
    let min: Double
}

struct CityWeather {
    let town: Town
    let date: Date
    let weather: [WeatherForecast]
    let temperature: Temperature
}
