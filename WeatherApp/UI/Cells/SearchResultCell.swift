//
//  SearchResultCell.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 06/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import UIKit

struct SearchResultsModel {
    let cityName: String
    let temperature: String
    let condition: String
    
    init(data: CityWeather) {
        cityName = data.town.fullCityName
        temperature = data.temperature.temperatureValue
        condition = data.weather.first!.forecast
    }
}

class SearchResultCell: UITableViewCell, TableViewControllerCellForModel {
    typealias Model = SearchResultsModel
    
    static let identifier: String = "SearchResultCell"
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with object: SearchResultsModel?) {
        self.temperatureLabel.text = object?.temperature
        self.cityLabel.text = object?.cityName
        self.timeLabel.text = object?.condition
    }

}
