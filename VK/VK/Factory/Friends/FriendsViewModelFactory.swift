//
//  FriendsViewModelFactory.swift
//  VK
//
//  Created by Denis Dmitriev on 04.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

class FriendsViewModelFactory {
    
    func constractViewModel(from users: [User]) -> [FriendsViewModel] {
        return users.map { getViewModel(from: $0) }
    }
    
    private func getViewModel(from user: User) -> FriendsViewModel {
        let id = user.id
        let name = user.name + " " + user.lastname
        let avatar = user.avatar
        return FriendsViewModel(id: id, name: name, avatar: avatar)
    }
}
