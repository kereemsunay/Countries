//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Kerem on 26.02.2022.
//

import Foundation


class CountriesViewModel : ObservableObject{
    
    @Published var countries : [CountriesData] = []
    
    func fetchCountries(){
        
        Network().getCountries { res in
            switch res{
            case .success(let result):
                if let result = result.data{
                    self.countries = result
                }
            case .failure(let err):
                print(err)
            }
        }
    }
}
