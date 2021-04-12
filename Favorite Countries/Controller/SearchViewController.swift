//
//  SearchViewController.swift
//  Favorite Countries
//
//  Created by AJ Batja on 4/5/21.
//

import UIKit

class SearchViewController: UIViewController {

    // Share instance of API
    let api: APIService = WorldBankAPI.shared
    // Share instance of Data Store
    let data: DataStore = DataStore.shared
    
    @IBOutlet weak var allCountriesTableView: UITableView!
    
    // Instance of search controller
    let searchController = UISearchController(searchResultsController: nil)
    
    // To store countries
    var countries: [Country] = []
    var filteredCountry: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up the delegates and datasource for the countries table view
        allCountriesTableView.delegate = self
        allCountriesTableView.dataSource = self
        
        self.countries = data.countries
        
        // Function to setup the search controller
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      if let indexPath = allCountriesTableView.indexPathForSelectedRow {
        allCountriesTableView.deselectRow(at: indexPath, animated: true)
      }
        
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Segue to detail scene with selected country
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetailViewController", let indexPath = allCountriesTableView.indexPathForSelectedRow, let showDetailViewController = segue.destination as? ShowDetailViewController else {
            return
        }
      
        let country: Country
        if isFiltering {
            country = filteredCountry[indexPath.row]
        } else {
            country = countries[indexPath.row]
        }
        showDetailViewController.country = country
    }
    
    
    // Function to setup search controller and set it as search controller of navigation bar
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Countries"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    // Flag to check is search bar is empty
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    // Flag to check is the user is searching
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty 
    }
    
    // Function to filter the content
    func filterContentForSearchText(_ searchText: String) {
      filteredCountry = countries.filter { (country: Country) -> Bool in
        return country.name.lowercased().contains(searchText.lowercased())
      }
      
      allCountriesTableView.reloadData()
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCountry.count
        }
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allCountriesTableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as! SearchCountryTableViewCell
        let country: Country
        if isFiltering {
          country = filteredCountry[indexPath.row]
        } else {
          country = countries[indexPath.row]
        }
        cell.configureCell(country)
        return cell
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
      let searchBar = searchController.searchBar
      filterContentForSearchText(searchBar.text!)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }
}
