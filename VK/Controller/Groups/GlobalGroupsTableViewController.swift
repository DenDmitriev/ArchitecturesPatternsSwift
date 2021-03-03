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
    var groups: [Group] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Data loading
    
    var filteredGroups: [GroupRealm] = []
    var isFiltering: Bool = false
    
    @objc func refresh(text: String) {
        print(#function)
        groupAdapter.getGlobalGroups(text: text) { [weak self] groups in
            self?.groups = groups
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroupTableViewCell
        let currentGroups = groups
        cell.set(group: currentGroups[indexPath.row], photoService: photoService, indexPath: indexPath)
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
