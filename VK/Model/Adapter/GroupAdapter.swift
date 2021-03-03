//
//  GroupAdapter.swift
//  VK
//
//  Created by Denis Dmitriev on 02.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation
import RealmSwift

protocol GroupAdapterProtocol {
    func getGroups(completion: @escaping (([Group]) -> Void) )
}

class GroupAdapter: GroupAdapterProtocol {
    
    let service = VKService()
    var notificationToken: NotificationToken?
    
    func getGroups(completion: @escaping (([Group]) -> Void)) {
        
        guard let realm = try? Realm() else { return }
        
        let groupsRealm = realm.objects(GroupRealm.self)
        
        notificationToken = groupsRealm.observe { [weak self] (changes) in
            guard let self = self else { return }
            
            switch changes {
            case .update(let groupsRealm, _, _, _):
                let groups = groupsRealm
                    .map { self.getGroup(from: $0) }
                    .sorted { $0.title > $1.title }
                completion(groups)
            case .initial(let groupsRealm):
                let groups = groupsRealm
                    .map { self.getGroup(from: $0) }
                    .sorted { $0.title > $1.title }
                completion(groups)
            case .error(let error):
                print(error.localizedDescription)
            }
        }
        
        service.getGroups {
            print("load groups from network")
        }
    }
    
    func getGlobalGroups(text: String, completion: @escaping ([Group]) -> Void) {
        service.getGroupsSearch(text: text) { [weak self] groupsRealm in
            let groups = groupsRealm
                .compactMap { self?.getGroup(from: $0) }
                .sorted { $0.title > $1.title }
            completion(groups)
        }
    }
    
    private func getGroup(from realmGroup: GroupRealm) -> Group {
        return Group(id: realmGroup.id, title: realmGroup.title, avatar: realmGroup.avatar)
    }
    
    func getGroupRealm(from group: Group) -> GroupRealm {
        let groupRealm = GroupRealm()
        groupRealm.id = group.id
        groupRealm.title = group.title
        groupRealm.avatar = group.avatar
        return groupRealm
    }
}
