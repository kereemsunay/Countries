//
//  CountriesView.swift
//  Countries
//
//  Created by Kerem on 27.02.2022.
//

import SwiftUI

struct CountriesView: View {
    @StateObject var CountriesVM = CountriesViewModel()
    @EnvironmentObject var favorites : Favorites
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(CountriesVM.countries, id:\.code){ country in
                    HStack{
                        NavigationLink {
                            CountryDetailView(country: country)
                                .environmentObject(favorites)
                        } label: {
                            Text(country.name)
                        }
                        
                        Spacer()
                        
                        Button {
                            if self.favorites.contains(country) {
                                self.favorites.remove(country)
                                favorites.getTaskIds()
                            } else {
                                self.favorites.add(country)
                                favorites.getTaskIds()
                            }
                        } label: {
                            if self.favorites.contains(country) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.yellow)
                            }else{
                                Image(systemName: "star")
                                    .font(.system(size: 30))
                                    .foregroundColor(.yellow)
                            }
                        }
                        
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .padding(.horizontal)
                    
                }
            }
            
        }
        .onAppear {
            CountriesVM.fetchCountries()
            favorites.getTaskIds()
        }        
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}
