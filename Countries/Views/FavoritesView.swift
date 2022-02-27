//
//  FavoritesView.swift
//  Countries
//
//  Created by Kerem on 27.02.2022.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var CountriesVM = CountriesViewModel()
    @EnvironmentObject var favorites : Favorites
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(CountriesVM.countries, id:\.code){ country in
                    if self.favorites.contains(country) {
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
                                
                            } else {
                                self.favorites.add(country)
                                
                            }
                        } label: {
                            
                                Image(systemName: "star.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.yellow)
                          
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
            
        }
        .onAppear {
            CountriesVM.fetchCountries()
            favorites.getTaskIds()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
