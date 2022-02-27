//
//  CountriesApp.swift
//  Countries
//
//  Created by Kerem on 26.02.2022.
//

import SwiftUI
import SDWebImage
import SDWebImageSVGCoder


@main
struct CountriesApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        setUpDependencies() // Initialize SVGCoder
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}



// Initialize SVGCoder
private extension CountriesApp {
    
    func setUpDependencies() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
}
