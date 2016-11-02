//
//  SegueHandler.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 02/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import UIKit

public protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

public extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    public func performSegue(withIdentifier identifier: SegueIdentifier, sender: AnyObject?) {
        performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
    
    public func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        
        guard let identifier = segue.identifier else {
            fatalError("Invalid segue identifier \(segue.identifier).")
        }
        
        return self.segueIdentifier(for: identifier)
    }
    
    public func segueIdentifier(for identifier: String) -> SegueIdentifier {
        guard let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
            fatalError("Invalid segue identifier \(identifier).")
        }
        
        return segueIdentifier
    }
}
