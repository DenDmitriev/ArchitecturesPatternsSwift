//
//  GlobalGroupsTableViewController.swift
//  1l_ДмитриевДенис
//
//  Created by Denis Dmitriev on 21.06.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit

class GlobalGroupsTableViewController: UITableViewController {
    
    lazy var photoService = PhotoService(container: tableView)
    let groupAdapter = GroupAdapter()
    
    private let viewModelFactory = GroupsViewModelFactory()
    var viewModels = [GroupViewModel]()
    
    var isFiltering: Bool = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Data loading
    
    @objc func refresh(text: String) {
        print(#function)
        groupAdapter.getGlobalGroups(text: text) { [weak self] groups in
            guard let self = self else { return }
            self.viewModels = self.viewModelFactory.constractViewModel(with: groups)
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.identifier, for: indexPath) as! GroupTableViewCell
        let group = viewModels[indexPath.row]
        let avatar = photoService.photo(atIndexpath: indexPath, byUrl: group.avatar)
        cell.configure(with: group, with: avatar)
        return cell
    }
  
}

extension GlobalGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isFiltering = true
        refresh(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
    }
}
