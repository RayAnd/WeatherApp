//
//  CityForecastController.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 02/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import UIKit

struct ForecastControllerModel {
    let temperature: String
    let condition: String
    let cityName: String
    
    init(model: CityWeather) {
        temperature = String(format: "%.0fº", model.temperature.temperature)      
        condition = model.weather.first!.forecast
        cityName = model.town.fullCityName
    }
}

class CityForecastController: UIViewController {
    var model: ForecastControllerModel?
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = model?.cityName
        self.temperatureLabel.text = model?.temperature
        self.conditionLabel.text = model?.condition
        
    }
}
