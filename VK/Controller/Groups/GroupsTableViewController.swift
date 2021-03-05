//
//  GroupsTableViewController.swift
//  1l_ДмитриевДенис
//
//  Created by Denis Dmitriev on 21.06.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    let groupAdapter = GroupAdapter()
    lazy var photoService = PhotoService(container: tableView)
    
    private let viewModelFactory = GroupsViewModelFactory()
    private var viewModels = [GroupViewModel]() {
        willSet {
            filterGroupsAdapter.update(with: newValue)
        }
    }
    private var filterGroupsAdapter = FilterGroupsAdapter()
    weak var filterDelegate: FilterGroupsAdapterDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadPullRefresh()
        load()
    }
    
    //MARK: - Preapre
    
    private func configure() {
        self.filterDelegate = self.filterGroupsAdapter
    }
    
    
    //MARK: - Data loading
    
    fileprivate func loadPullRefresh() {
        tableView.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        refreshControl?.beginRefreshing()
    }
    
    @objc func load() {
        print(#function)
        groupAdapter.getGroups() { [weak self] (groups, _, _, _) in
            guard let self = self else { return }
            self.viewModels = self.viewModelFactory.constractViewModel(with: groups)
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
     

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterGroupsAdapter.viewModels().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.identifier, for: indexPath) as! GroupTableViewCell
        let group = filterGroupsAdapter.viewModels()[indexPath.row]
        let avatar = photoService.photo(atIndexpath: indexPath, byUrl: group.avatar)
        cell.configure(with: group, with: avatar)
        return cell
    }
    
    
    @IBAction func unwindToGroups(segue: UIStoryboardSegue) {
        let globalGroups = segue.source as! GlobalGroupsTableViewController
        guard let indexPath = globalGroups.tableView.indexPathForSelectedRow else { return }
        let viewModel = globalGroups.viewModels[indexPath.row]
        let group = viewModelFactory.getGroup(for: viewModel)
        let groupRealm = groupAdapter.getGroupRealm(from: group)
        RealmService.shared.addObject(groupRealm)
    }
}

extension GroupsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterDelegate?.search(for: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterDelegate?.cancelSearch()
        self.view.endEditing(true)
        tableView.reloadData()
    }
}
