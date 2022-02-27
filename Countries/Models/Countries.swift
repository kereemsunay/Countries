//
//  Countries.swift
//  Countries
//
//  Created by Kerem on 26.02.2022.
//

import Foundation

struct CountriesData:Codable {
    let code: String
    let name: String
    let wikiDataId : String
    let currencyCodes : [String]

}
struct Countries: Codable {
    var data : [CountriesData]?
    var links : [Links]
    var metadata : MetaData
}

struct Links:Codable{
    var rel: String
    var href : String
}
struct MetaData:Codable{
    var currentOffset : Int
    var totalCount : Int
}
