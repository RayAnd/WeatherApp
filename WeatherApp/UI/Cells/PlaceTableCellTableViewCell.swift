//
//  PlaceTableCellTableViewCell.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 06/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import UIKit

struct PlaceViewModel {
    let cityName: String
}

class PlaceTableCellTableViewCell: UITableViewCell, TableViewControllerCellForModel {
    typealias Model = PlaceViewModel
    
    static let identifier: String = "PlaceTableCellTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with object: PlaceViewModel) {
        self.textLabel?.text = object.cityName
    }
}
