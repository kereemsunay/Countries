//
//  ContentView.swift
//  Countries
//
//  Created by Kerem on 26.02.2022.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var favorites = Favorites()
    var body: some View {
        NavigationView{
            TabView(content: {
                CountriesView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(0)
                   
                
                FavoritesView()
                    .tabItem {
                        Label("Saved", systemImage: "heart.fill")
                    }
                    .tag(1)
            })
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Countries")
                .environmentObject(favorites)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
