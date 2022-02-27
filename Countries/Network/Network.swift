//
//  Network.swift
//  Countries
//
//  Created by Kerem on 26.02.2022.
//

import Foundation
import Combine
import SwiftUI

class Network :ObservableObject{
       
    func getDataAPI<T: Decodable>(request:URLRequest , completion: @escaping ((Result<T,CountryApiError>)-> Void)){
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async  {
                if let data = data {
                    
                    if let HTTPresponse = response as? HTTPURLResponse{
                        switch HTTPresponse.statusCode{
                        case 200:
                            do {
                                let result = try JSONDecoder().decode(T.self, from: data)
                                completion(.success(result))
                            } catch (let error) {
                                print(error)
                                completion(.failure(CountryApiError(statusMessage: "Error", statusCode: 200)))
                            }
                            
                        case 400,401:
                            do {
                                let error = try JSONDecoder().decode(CountryApiError.self, from: data)
                                completion(.failure(error))
                            } catch (let error) {
                                print(error)
                                completion(.failure(CountryApiError(statusMessage: "Something went Wrong!", statusCode: HTTPresponse.statusCode)))
                            }
                            
                            
                        default:
                            completion(.failure(CountryApiError(statusMessage: "Error response code", statusCode: HTTPresponse.statusCode)))
                        }
                        
                    }
                           }
            }
        }
        dataTask.resume()
        
    }
    
    func getCountries(completion: @escaping ((Result<Countries,CountryApiError>)-> Void)){
        let request = getCountriesURL()
        getDataAPI(request: request, completion: completion)
    }
    
    func getCountryDetail(code:String , completion: @escaping ((Result<CountryDetail,CountryApiError>)-> Void)){
        let request = getDetailURL(code)
        getDataAPI(request: request, completion: completion)
    }
    

    
}

extension Network {
    
    func getCountriesURL() -> URLRequest {
        let headers = [
            "x-rapidapi-host": "wft-geo-db.p.rapidapi.com",
            "x-rapidapi-key": "df5131b13bmsh6835314a70313a3p1fac1cjsn4005d1ab751d"
        ]
        let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    func getDetailURL(_ code: String) -> URLRequest {
        let headers = [
            "x-rapidapi-host": "wft-geo-db.p.rapidapi.com",
            "x-rapidapi-key": "df5131b13bmsh6835314a70313a3p1fac1cjsn4005d1ab751d"
        ]
        let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(code)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
}


