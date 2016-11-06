//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 02/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import UIKit

enum SearchState {
    case empty
    case loading
    case noResults
    case results(data: [Town])
}

extension SearchState: TableViewControllerModel {
    func numberOfRows(in section: Int) -> Int {
        switch self {
            case .empty: return 0
            case .noResults: return 1
            case .loading: return 1
            case .results(let data): return data.count
        }
    }
    
    func cellIdentifier(for rowIndex: Int) -> String {
        switch self {
            case .empty: return ""
            case .noResults: return NoResultsCell.identifier
            case .loading: return LoadingCell.identifier
            case .results(_): return SearchResultCell.identifier
        }
    }
    
    func object(at indexPath: IndexPath) -> Any? {
        switch self {
            case .empty: return nil
            case .noResults: return nil
            case .loading: return nil
            case .results(let data): return SearchResultsModel(town: data[indexPath.row])
        }
    }
    
    func dequeReusableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = self.cellIdentifier(for: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let cellForViewModel = cell as? TableViewControllerCell {
            cellForViewModel.configure(with: self.object(at: indexPath))
        }
        
        return cell
    }
}

class SearchViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResults: SearchState = .noResults
    
    override func viewDidLoad() {
        super.viewDidLoad()                
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.searchBar.becomeFirstResponder()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return searchResults.dequeReusableCell(tableView, for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            searchResults = .loading
            self.tableView.reloadData()
        
            do {
                try WeatherService().exequte(request: WeatherSearchReqest(city: searchText), completion: { [weak self] response in
                    if case .success(let weather) = response {
                        let cities: [Town] = weather.map { $0.town }
                        self?.searchResults = .results(data: cities)
                        self?.tableView.reloadData()
                    } else {
                        print(response)
                        
                        self?.searchResults = .noResults
                        self?.tableView.reloadData()
                    }
                })
            } catch let error {
                print(error)
                
                searchResults = .noResults
                self.tableView.reloadData()
            }
        }
    }
}
