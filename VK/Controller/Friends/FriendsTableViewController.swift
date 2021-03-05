//
//  FriendsTableViewController.swift
//  1l_ДмитриевДенис
//
//  Created by Denis Dmitriev on 21.06.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var photoService: PhotoService!
    let userAdapter = UserAdapter()
    
    private let viewModelFactory = FriendsViewModelFactory()
    private var viewModels = [FriendsViewModel]() {
        willSet {
            filterUserAdapter.update(with: newValue)
        }
    }
    
    private var filterUserAdapter = FilterUserAdapter()
    weak var filterDelegate: FilterUserAdapterDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadPullRefresh()
        load()
    }
    
    //MARK: - Preapre
    
    private func configure() {
        photoService = PhotoService(container: tableView)
        self.filterDelegate = self.filterUserAdapter
    }

    
    //MARK: - Data loading
    
    fileprivate func loadPullRefresh() {
        tableView.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        refreshControl?.beginRefreshing()
    }
    
    
    @objc func load() {
        print(#function)
        userAdapter.getUsers { [weak self] (users, _, _, _) in
            guard let self = self else { return }
            self.viewModels = self.viewModelFactory.constractViewModel(from: users)
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - TableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filterUserAdapter.indexes().count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return filterUserAdapter.indexes().map { $0.uppercased() }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filterUserAdapter.indexes()[section].uppercased()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = filterUserAdapter.indexes()[section]
        return filterUserAdapter.users(for: index).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as! FriendTableViewCell
        let index = filterUserAdapter.indexes()[indexPath.section]
        let userModel = filterUserAdapter.users(for: index)[indexPath.row]
        let image = photoService.photo(atIndexpath: indexPath, byUrl: userModel.avatar)
        cell.configure(with: userModel, avatar: image)
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? FriendTableViewCell,
            let userId = cell.id,
            let userRealm = RealmService.shared.getObject(with: UserRealm.self, for: userId)
        else { return }
        
        let user = userAdapter.getUser(from: userRealm)
        let albumASCollectionNode = AsyncAlbumController()
        albumASCollectionNode.user = user
        
        navigationController?.pushViewController(albumASCollectionNode, animated: true)
    }
}


// MARK: - Filter

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterDelegate?.search(for: searchText)
        self.tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        self.view.endEditing(true)
        filterDelegate?.cancelSearch()
        tableView.reloadData()
    }

}
