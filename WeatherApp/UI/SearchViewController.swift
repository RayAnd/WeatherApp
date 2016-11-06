//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 02/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import UIKit

struct SearchData {
    let searchResults: [Town]
}

class SearchViewController: UITableViewController {

    static let storyboardIdentifier: String = "SearchViewController"
    
    var searchResults: SearchData = SearchData(searchResults: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()                
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell

        let town: Town = self.searchResults.searchResults[indexPath.row]
        
        cell.configure(with: SearchResultsModel(cityName: town.city))

        return cell
    }
}

extension SearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            do {
                try WeatherService().exequte(request: WeatherSearchReqest(city: searchText), completion: { [weak self] response in
                    if case .success(let weather) = response {
                        let cities: [Town] = weather.map { $0.town }
                        self?.searchResults = SearchData(searchResults: cities)
                        self?.tableView.reloadData()
                    } else {
                        print(response)
                    }
                })
            } catch let error {
                print(error)
            }
        }
    }
}
