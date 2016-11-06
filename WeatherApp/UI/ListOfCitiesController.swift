//
//  ListOfCitiesController.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 02/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import UIKit
import CoreLocation

class ListOfCitiesController: UITableViewController {

    var cities: [Town] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cities = [
            Town(id: 1, city: "London", country: "UK", coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        ]
        
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableCellTableViewCell.identifier, for: indexPath) as! PlaceTableCellTableViewCell

        cell.configure(with: PlaceViewModel(cityName: cities[indexPath.row].city))
        
        return cell
    }
    
    @IBAction func showSearchController(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let searchResultsController = storyboard.instantiateViewController(withIdentifier: SearchViewController.storyboardIdentifier) as? SearchViewController else {
//            fatalError("Unable to instatiate a SearchViewController from the storyboard.")
//        }
//        
//        let searchController = UISearchController(searchResultsController: searchResultsController)
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.placeholder = NSLocalizedString("Enter keyword (e.g. iceland)", comment: "")
//        
//        let searchContainer = UISearchContainerViewController(searchController: searchController)
//        searchContainer.title = NSLocalizedString("Search", comment: "")
//        
//        let searchNavigationController = UINavigationController(rootViewController: searchContainer)
//        return searchNavigationController
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}

extension ListOfCitiesController: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case showCityForecast
        case showSearchController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = self.segueIdentifier(for: segue)
        switch identifier {
            case .showCityForecast: break
//            if let controller = segue.destination as? CityForecastController {
                //                    controller.model = ForecastControllerModel(
//            }
            case .showSearchController: break
        }
    }
}

