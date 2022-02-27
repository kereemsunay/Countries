//
//  CountryDetailView.swift
//  Countries
//
//  Created by Kerem on 27.02.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct CountryDetailView: View {
    @StateObject var detailVM = DetailViewModel()
    var country : CountriesData
    @EnvironmentObject var favorites : Favorites
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .leading) {
                    
                    FlagImage(urlString: detailVM.detail?.data.flagImageUri ?? "")
                    
                    HStack{
                        Text("Country Name :")
                            .fontWeight(.semibold)
                        Text("\(detailVM.detail?.data.name ?? "")")
                    }
                    
                    HStack{
                        Text("Country Code :")
                            .fontWeight(.semibold)
                        Text("\(detailVM.detail?.data.code ?? "")")
                    }
                    
                        HStack{
                            Text("Currency Code(s) : ")
                                .fontWeight(.semibold)
                        ForEach(country.currencyCodes, id:\.self) { currency in
                            
                                if country.currencyCodes.last == currency{
                                    Text(currency)
                                }else{
                                    Text(currency)
                                    Text("-")
                                }
                            }
                        }
                 
                    Button {
                        guard let url = URL(string: "https://www.wikidata.org/wiki/\(detailVM.detail?.data.wikiDataId ?? "")") else { return }
                        UIApplication.shared.open(url)
                    } label: {
                        HStack{
                            Text("For More Information")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.forward")
                                .font(.system(size: 30))
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            })
            .onAppear {
                detailVM.fetchDetails(code: country.code)
            }
            .navigationTitle(detailVM.detail?.data.name ?? "")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if self.favorites.contains(self.country) {
                            self.favorites.remove(self.country)
                        } else {
                            self.favorites.add(self.country)
                        }
                        print(favorites.contains(country))
                    }) {
                        Image(systemName: favorites.contains(country) ? "star.fill" : "star")
                            .foregroundColor(favorites.contains(country) ? Color.yellow : Color.gray)
                    }
                }
            }
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView( country: CountriesData(code: "", name: "", wikiDataId: "", currencyCodes: [""]))
    }
}

struct FlagImage : View{
    var urlString : String
    var body: some View{
        WebImage(url: URL(string: urlString),
                 context: [.imageThumbnailPixelSize : CGSize.zero])
            .resizable()
            .aspectRatio( contentMode: .fit)
            .border(Color.white, width: 1)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}
