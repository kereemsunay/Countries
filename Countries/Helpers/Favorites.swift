//
//  Favorites.swift
//  Countries
//
//  Created by Kerem on 27.02.2022.
//

import SwiftUI


class Favorites: ObservableObject {
    private var tasks: Set<String>
    let defaults = UserDefaults.standard
    
    init() {
        let decoder = JSONDecoder()
        if let data = defaults.value(forKey: "Favorites") as? Data {
            let taskData = try? decoder.decode(Set<String>.self, from: data)
            self.tasks = taskData ?? []
        } else {
            self.tasks = []
            
        }
        
    }
    
    
    func getTaskIds() {
        objectWillChange.send()
    }
    
    func isEmpty() -> Bool {
        tasks.count < 1
    }
    
    func contains(_ task: CountriesData) -> Bool {
        return tasks.contains(task.code)
    }
    
    func add(_ task: CountriesData) {
        objectWillChange.send()
        tasks.insert(task.code)
        save()
    }
    
    func remove(_ task: CountriesData) {
        objectWillChange.send()
        tasks.remove(task.code)
        save()
        
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tasks) {
            defaults.set(encoded, forKey: "Favorites")
        }
    }
}

