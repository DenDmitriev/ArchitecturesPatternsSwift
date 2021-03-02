//
//  Caretaker.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import Foundation

class CareTaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "result"
    
    func saveResults(results: [Result]) {
        do {
            let data = try encoder.encode(results)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func loadResults() -> [Result] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try decoder.decode([Result].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
