//
//  TableViewControllerModel.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 07/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewControllerModel {
    func numberOfRows(in section: Int) -> Int
    func object(at indexPath: IndexPath) -> Any?
    func dequeReusableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell
}
