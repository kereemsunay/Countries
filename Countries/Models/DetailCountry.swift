//
//  DetailCountry.swift
//  Countries
//
//  Created by Kerem on 26.02.2022.
//

import Foundation
import Combine

struct CountryDetail : Codable {
    let data: DetailData
}

struct DetailData : Codable{
    let code : String
    let callingCode : String
    let currencyCodes : [String]
    let flagImageUri : String
    let name : String
    let numRegions : Int
    let wikiDataId : String
}

