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
}

class CityForecastController: UIViewController {
    var model: ForecastControllerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = model?.cityName
    }
}
