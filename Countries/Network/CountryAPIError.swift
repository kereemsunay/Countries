//
//  CountryAPIError.swift
//  Countries
//
//  Created by Kerem on 26.02.2022.
//

import Foundation

struct CountryApiError: Codable, Error, LocalizedError {
    
    var statusMessage: String
    var statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_mesage"
        case statusCode = "status_code"
    }
    
    var localizedDescription: String {
        return statusMessage
    }
    
}
