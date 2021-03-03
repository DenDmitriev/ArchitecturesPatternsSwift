//
//  SubscrubeFacade.swift
//  VK
//
//  Created by Denis Dmitriev on 28.01.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit
import RealmSwift

class SubscrubeFacade {
    
//    func realmFriends(_ tableView: FriendsTableViewController, items: Results<UserRealm>) {
//        tableView.notificationToken = items.observe { changes in
//            switch changes {
//            case .initial(let items):
//                tableView.friends = Array(items)
//                tableView.tableView.reloadData()
//            case .update(let items, _, _, _):
//                if tableView.isFiltering.0 {
//                    tableView.filterFriends = Array(items).filter({ (user) -> Bool in
//                        (user.name + " " + user.lastname).lowercased().contains(tableView.isFiltering.1)
//                    })
//                } else {
//                    tableView.friends = Array(items)
//                }
//                tableView.tableView.reloadData()
//            case let .error(error):
//                print(error)
//            }
//        }
//    }
    
//    func realmGroups(_ tableView: GroupsTableViewController, items: Results<Group>) {
//        tableView.notificationToken = items.observe { (changes) in
//            switch changes {
//            case .initial(let items):
//                tableView.groups = Array(items)
//                tableView.tableView.reloadData()
//            case let .update(items, deletions, insertions, modifications):
//                if tableView.isFiltering.0 {
//                    tableView.filteredGroups = Array(items).filter { $0.title.lowercased().contains(tableView.isFiltering.1) }
//                } else {
//                    tableView.groups = Array(items)
//                }
//                print(deletions, insertions, modifications)
//                tableView.tableView.beginUpdates()
//                tableView.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
//                tableView.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
//                tableView.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
//                tableView.tableView.endUpdates()
//            case let .error(error):
//                print(error)
//            }
//        }
//    }
}
