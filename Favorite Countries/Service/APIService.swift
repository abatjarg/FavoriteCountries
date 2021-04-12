//
//  APIService.swift
//  Favorite Countries
//
//  Created by AJ Batja on 4/5/21.
//

import Foundation

// Protocol for the World Bank API on available function and expected errors

protocol APIService {
    // For fetching the countries from the API
    func fetchCountries(params: [String: String]?, successHandler: @escaping (_ response: APIResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}


// Expected errors while working with World Bank API
public enum APIError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
