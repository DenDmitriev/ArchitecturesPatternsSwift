//
//  GroupsViewModelFactory.swift
//  VK
//
//  Created by Denis Dmitriev on 05.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

class GroupsViewModelFactory {
    
    func constractViewModel(with groups: [Group]) -> [GroupViewModel] {
        return groups.compactMap { self.getViewModel(for: $0) }
    }
    
    private func getViewModel(for group: Group) -> GroupViewModel {
        return GroupViewModel(id: group.id, title: group.title, avatar: group.avatar)
    }
    
    func getGroup(for viewModel: GroupViewModel) -> Group {
        return Group(id: viewModel.id, title: viewModel.title, avatar: viewModel.avatar)
    }
}
