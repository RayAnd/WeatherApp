//
//  Models.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 31/10/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation
import CoreLocation

struct Town {
    let id: Int32
    let city: String
    let country: String
    let coordinates: CLLocationCoordinate2D
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
