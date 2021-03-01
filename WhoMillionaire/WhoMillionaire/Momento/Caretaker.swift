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
    
    enum Keys {
        static let result = "result"
        static let user = "user"
    }
    
    //MARK: - User results
    
    func saveResults(results: [Result]) {
        do {
            let data = try encoder.encode(results)
            UserDefaults.standard.setValue(data, forKey: Keys.result)
        } catch {
            print(error)
        }
    }
    
    func loadResults() -> [Result] {
        guard let data = UserDefaults.standard.data(forKey: Keys.result) else { return [] }
        do {
            return try decoder.decode([Result].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
    //MARK: - User settings
    
    func saveUser(user: User) {
        do {
            let data = try encoder.encode(user)
            UserDefaults.standard.setValue(data, forKey: Keys.user)
        } catch {
            print(error)
        }
    }
    
    func loadUser() -> User {
        guard let data = UserDefaults.standard.data(forKey: Keys.user) else { return User() }
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            print(error)
            return User()
        }
    }

}
