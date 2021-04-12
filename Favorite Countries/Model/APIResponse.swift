//
//  Countries.swift
//  Favorite Countries
//
//  Created by AJ Batja on 4/5/21.
//

import Foundation


public struct Country: Codable {
    var id: String
    var name: String
    var capitalCity: String
    var favoriteDetails: String?
}

public struct MetaData: Codable {
    var page: Int
    var pages: Int
    var perPage: String
    var total: Int
}


public struct APIResponse: Codable {
    public var metaData: MetaData?
    public var countries: [Country]

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        metaData = try container.decode(MetaData.self)
        countries = try container.decode([Country].self)
    }
}

