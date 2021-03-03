//
//  GroupsTableViewController.swift
//  1l_ДмитриевДенис
//
//  Created by Denis Dmitriev on 21.06.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {
    
    let groupAdapter = GroupAdapter()
    lazy var photoService = PhotoService(container: tableView)
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPullRefresh()
        load()
    }
    
    
    //MARK: - Data loading
    
    fileprivate func loadPullRefresh() {
        tableView.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        refreshControl?.beginRefreshing()
    }
    
    @objc func load() {
        print(#function)
        groupAdapter.getGroups() { [weak self] (groups) in
            self?.groups = groups
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        }
    }
    //MARK: - FilterGroups
    
    var groups: [Group] = []
    var filteredGroups: [Group] = []
    
    var isFiltering: (Bool, String) = (false, "") {
        didSet {
            filteredGroups = isFiltering.0 ? groups.filter({ (group) -> Bool in
                group.title.lowercased().contains(isFiltering.1.lowercased())
                }) : []
        }
    }
     

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering.0 ? filteredGroups.count : groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroupTableViewCell
        let group = isFiltering.0 ? filteredGroups[indexPath.row] : groups[indexPath.row]
        cell.set(group: group, photoService: photoService, indexPath: indexPath)
        return cell
    }
    
    
    @IBAction func unwindToGroups(segue: UIStoryboardSegue) {
        let globalGroups = segue.source as! GlobalGroupsTableViewController
        guard let indexPath = globalGroups.tableView.indexPathForSelectedRow else { return }
        let group = globalGroups.groups[indexPath.row]
        let groupRealm = groupAdapter.getGroupRealm(from: group)
        //To Realm
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(groupRealm, update: .modified)
                }
            } catch {
                print(error)
            }
        }
    }
}

extension GroupsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            isFiltering = (true, searchText)
        } else {
            isFiltering.0 = false
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering.0 = false
        self.view.endEditing(true)
        tableView.reloadData()
    }
}
