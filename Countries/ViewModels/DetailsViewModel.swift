//
//  DetailsViewModel.swift
//  Countries
//
//  Created by Kerem on 27.02.2022.
//

import Foundation

class DetailViewModel : ObservableObject{
    
    @Published var detail : CountryDetail?
    
    func fetchDetails(code: String){
        DispatchQueue.main.async {
            Network().getCountryDetail(code: code) { (result) in
                switch result{
                case .success(let details):
                    self.detail = details
                case .failure(let error):
                    print("error",error)
                }
            }
        }
        
    }
    
    
    
}
