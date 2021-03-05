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
    
    func saveData<T: Object>(_ array: [T]) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(array, update: .modified)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getObject<T: Object>(with type: T.Type, for primaryKey: Int) -> T? {
        do {
            let realm = try Realm()
            let object = realm.object(ofType: T.self, forPrimaryKey: primaryKey)
            return object
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func addObject<T: Object>(_ object: T) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(object, update: .modified)
                }
            } catch {
                print(error)
            }
        }
    }
}
