//
//  DataStore.swift
//  Favorite Countries
//
//  Created by AJ Batja on 4/8/21.
//

import Foundation

/*
    For storing and caching the data
 */

class DataStore {
    
    // Shared resource instance to DataStore (singleton)
    public static let shared = DataStore()
    
    // Array to store the countried return from the API call
    var countries = [Country]() {
        didSet {
            // Sort the array by alphabetical order
            countries.sort {
                $0.name < $1.name
            }
        }
    }
    
    // Array to user's favorite countries
    var savedCountries = [Country]()
    
    // Creating an instance of the API
    let api: APIService = WorldBankAPI.shared
    
    // Fetch all the countries
    func fetchAllCountries() {
        api.fetchCountries(params: nil) { [self] (response) in
            guard let totalPages = response.metaData?.total else {
                return
            }
            // Looping through and fetching all the pages to get all the countries
            for page in 0..<totalPages {
                self.api.fetchCountries(params: ["page": String(page)]) { (response) in
                    for country in response.countries {
                        // Only store countries with valid capital city
                        if country.capitalCity != "" {
                            self.countries.append(country)
                        }
                    }
                } errorHandler: { (error) in
                    print("\(error)")
                }

            }
        } errorHandler: { (error) in
            print("\(error)")
        }
    }
    
    // Function to allow user to add country to the favorite country storage
    func addCountry(_ country: Country) {
        savedCountries.append(country)
    }
    
}
