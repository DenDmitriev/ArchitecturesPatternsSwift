//
//  UsersAdapter.swift
//  VK
//
//  Created by Denis Dmitriev on 04.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

protocol FilterUserAdapterDelegate: AnyObject {
    func search(for text: String)
    func cancelSearch()
}

class FilterUserAdapter {
    
    private var keys = Array<String>()
    private var users = Array<FriendsViewModel>()
    
    private var filter: Bool = false
    private var text: String = ""
    
    init(for users: [FriendsViewModel] = []) {
        update(with: users)
    }
    
    func update(with users: [FriendsViewModel]) {
        self.users = users
        self.keys = Array(
            Set(users.compactMap { $0.name.prefix(1).lowercased() })
        )
        .sorted { $0 < $1 }
    }
    
    func indexes() -> [String] {
        switch filter {
        case false:
            return keys
        case true:
            return Array(
                Set(
                    users
                        .filter { $0.name.lowercased().contains(text) }
                        .compactMap { $0.name.prefix(1).lowercased() }
                )
            )
            .sorted { $0 < $1 }
        }
    }
    
    func users(for key: String) -> [FriendsViewModel] {
        let users =
            self.users.filter {
                $0
                    .name
                    .prefix(1)
                    .lowercased() == key
            }
            .sorted {$0.name < $1.name}
        
        switch filter {
        case false:
            return users
        case true:
            return users.filter {
                $0.name.lowercased().contains(text)
            }
        }
    }
    
}

extension FilterUserAdapter: FilterUserAdapterDelegate  {
    
    func cancelSearch() {
        self.filter = false
        self.text.removeAll()
    }
    
    
    func search(for text: String) {
        self.text = text.lowercased()
        if text.isEmpty {
            self.filter = false
        } else {
            self.filter = true
        }
    }
}
