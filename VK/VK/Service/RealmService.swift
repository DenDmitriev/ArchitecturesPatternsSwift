//
//  RealmService.swift
//  VK
//
//  Created by Denis Dmitriev on 02.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    static let shared = RealmService()
    let realm = try? Realm()
    
    func saveData<T: Object>(_ array: [T]) {
        DispatchQueue.main.async {
            do {
                guard let realm = self.realm else { return }
                try realm.write {
                    realm.add(array, update: .modified)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getObject<T: Object>(with type: T.Type, for primaryKey: Int) -> T? {
        guard let realm = self.realm else { return nil }
        let object = realm.object(ofType: T.self, forPrimaryKey: primaryKey)
        return object
    }
    
    func addObject<T: Object>(_ object: T) {
        DispatchQueue.main.async {
            do {
                guard let realm = self.realm else { return }
                try realm.write {
                    realm.add(object, update: .modified)
                }
            } catch {
                print(error)
            }
        }
    }
}
