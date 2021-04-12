//
//  WorldBankAPI.swift
//  Favorite Countries
//
//  Created by AJ Batja on 4/5/21.
//

import Foundation

struct WorldBankAPI: APIService {
    
    // Shared resource instance to World Bank API (singleton)
    public static let shared = WorldBankAPI()
    
    private init() {}
    
    // Base URL for the REST API
    private let baseAPIURL = "https://api.worldbank.org/v2"
    
    // Instance of URL session
    private let urlSession = URLSession.shared
 
    // Define JSON decoder
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    // Function to fetch countries from the REST API
    public func fetchCountries(params: [String: String]? = nil, successHandler: @escaping (_ response: APIResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void){
        
        // Make sure it is valid URL
        guard var urlComponents = URLComponents(string: "\(baseAPIURL)/countries") else {
            errorHandler(APIError.invalidEndpoint)
            return
        }
        
        // Set JSON formate
        var queryItems = [
            URLQueryItem(name: "format", value: "json")
        ]
        
        // Add additional params
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        urlComponents.queryItems = queryItems
    
        // Make sure it is valid URL
        guard let url = urlComponents.url else {
             errorHandler(APIError.invalidEndpoint)
             return
        }
        
        // URL session data request to the REST API
        urlSession.dataTask(with: url) {(data, response, error) in
            
            // Make sure no error comes back from the API
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: APIError.apiError)
                return
            }
            
            // Make sure it is valid HTTP repsponse
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: APIError.invalidResponse)
                return
            }
            
            // Make sure the data is valid
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: APIError.noData)
                return
            }
            
            // Decode the data using the JSON decoder and APIResponse model
            do {
                let apiResponse = try self.jsonDecoder.decode(APIResponse.self, from: data)
                // Let the application know that the API reponse is done by using completion handler
                DispatchQueue.main.async {
                    successHandler(apiResponse)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: APIError.serializationError)
            }
        }.resume()
    }
    
    // Function to handle the errors
    private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            errorHandler(error)
        }
    }
    
}
