//
//  FilterGroupsAdapter.swift
//  VK
//
//  Created by Denis Dmitriev on 04.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

protocol FilterGroupsAdapterDelegate: AnyObject {
    func search(for text: String)
    func cancelSearch()
}

class FilterGroupsAdapter {
    
    private var groupsViewModels = Array<GroupViewModel>()
    
    private var filter: Bool = false
    private var searchText: String = ""
    
    init(for groupsViewModels: [GroupViewModel] = []) {
        update(with: groupsViewModels)
    }
    
    func update(with groupsViewModels: [GroupViewModel]) {
        self.groupsViewModels = groupsViewModels
    }
    
    func viewModels() -> [GroupViewModel] {
        let groupsViewModels =
            self.groupsViewModels.sorted {$0.title < $1.title}
        
        switch filter {
        case false:
            return groupsViewModels
        case true:
            return groupsViewModels.filter {
                $0.title.lowercased().contains(searchText)
            }
        }
    }
    
}

extension FilterGroupsAdapter: FilterGroupsAdapterDelegate  {
    
    func cancelSearch() {
        self.filter = false
        self.searchText.removeAll()
    }
    
    
    func search(for text: String) {
        self.searchText = text.lowercased()
        if text.isEmpty {
            self.filter = false
        } else {
            self.filter = true
        }
    }
}
