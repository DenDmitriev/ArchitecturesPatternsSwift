//
//  UserAdapter.swift
//  VK
//
//  Created by Denis Dmitriev on 02.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation
import RealmSwift

protocol UserAdapterProtocol {
    func getUsers(completion: @escaping (([User]) -> Void) )
}

class UserAdapter: UserAdapterProtocol {
    
    let service = VKService()
    var notificationToken: NotificationToken?
    
    func getUsers(completion: @escaping (([User]) -> Void)) {
        
        guard let realm = try? Realm() else { return }
        
        let usersRealm = realm.objects(UserRealm.self)
        
        notificationToken = usersRealm.observe { [weak self] (changes) in
            guard let self = self else { return }
            
            switch changes {
            case .update(let usersRealm, _, _, _):
                let users = usersRealm
                    .map { self.getUser(from: $0) }
                    .sorted { $0.name > $1.name }
                completion(users)
            case .initial(let usersRealm):
                let users = usersRealm
                    .map { self.getUser(from: $0) }
                    .sorted { $0.name > $1.name }
                completion(users)
            case .error(let error):
                print(error.localizedDescription)
            }
        }
        
        service.getFriends {
            print("load friends from network")
        }
    }
    
    private func getUser(from realmUser: UserRealm) -> User {
        return User(id: realmUser.id,
                    name: realmUser.name,
                    lastname: realmUser.lastname,
                    avatar: realmUser.avatar)
    }
    
    
}
