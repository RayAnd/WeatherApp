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
    
    init(town: Town) {
        cityName = town.city + ", \(town.country)"
    }
}

class SearchResultCell: UITableViewCell, TableViewControllerCellForModel {
    typealias Model = SearchResultsModel
    
    static let identifier: String = "SearchResultCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with object: SearchResultsModel?) {
        self.textLabel?.text = object?.cityName
    }

}
