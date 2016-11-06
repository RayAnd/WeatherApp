//
//  TableViewControllerCell.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 06/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation

protocol TableViewControllerCell {
    static var identifier: String { get }
    func configure(with object: Any)
}

protocol TableViewControllerCellModel {
}

protocol TableViewControllerCellForModel : TableViewControllerCell {
    associatedtype Model
    
    func configure(with object: Model)
}

extension TableViewControllerCellForModel {
    func configure(with object: Any) {
        if let model = object as? Model {
            configure(with: model)
        }
    }
}
