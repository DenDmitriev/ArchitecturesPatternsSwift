//
//  FriendsTableViewController.swift
//  1l_ДмитриевДенис
//
//  Created by Denis Dmitriev on 21.06.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit
import RealmSwift
import PromiseKit

class FriendsTableViewController: UITableViewController {
    
    lazy var realm = try! Realm()
    var photoService: PhotoService!
    
    let userAdapter = UserAdapter()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoService = PhotoService(container: tableView)
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
        userAdapter.getUsers { [weak self] (users) in
            self?.friends = users
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        }
    }
    
    //MARK: - FilterUsers
    
    lazy var friends: [User] = [] {
        didSet {
            let titles = friends.map { (user) -> String in
                user.name.prefix(1).lowercased()
            }
            indexTitles = Array(Set(titles)).sorted(by: { $0 < $1 })
        }
    }
    lazy var indexTitles: [String] = []

    lazy var filterFriends: [User] = [] {
        didSet {
            let titles = filterFriends.map({ (user) -> String in
                user.name.prefix(1).lowercased()
            })
            filterIndexTitles = Array(Set(titles)).sorted(by: { $0 < $1 })
        }
    }
    lazy var filterIndexTitles: [String] = []

    //Filter Data
    lazy var isFiltering: (Bool, String) = (false, "")

    // MARK: - TableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering.0 ? filterIndexTitles.count : indexTitles.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let index = isFiltering.0 ? filterIndexTitles : indexTitles
        let upperIndex = index.map { $0.uppercased() }
        return upperIndex
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isFiltering.0 ? filterIndexTitles[section].uppercased() : indexTitles[section].uppercased()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendsOfSection = isFiltering.0
            ?
            filterFriends.filter { $0.name.prefix(1).lowercased() == self.filterIndexTitles[section] }
            :
            friends.filter { $0.name.prefix(1).lowercased() == self.indexTitles[section] }
        return friendsOfSection.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FriendTableViewCell
        let friendsOfSection = isFiltering.0
            ?
            filterFriends.filter { $0.name.prefix(1).lowercased() == self.filterIndexTitles[indexPath.section] }.sorted { $0.name < $1.name }
            :
            friends.filter { $0.name.prefix(1).lowercased() == self.indexTitles[indexPath.section] }.sorted { $0.name < $1.name }
        cell.set(user: friendsOfSection[indexPath.row])
        let url = friendsOfSection[indexPath.row].avatar
        cell.avatarImage.image = photoService.photo(atIndexpath: indexPath, byUrl: url)
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FriendTableViewCell
        let user = friends.first { $0.id == cell.id }
        //let storyboard = UIStoryboard(name: "Gallery", bundle: nil)
        
//        let albumCollectionViewController = storyboard.instantiateViewController(identifier: "AlbumController") as! AlbumsCollectionViewController
//        albumCollectionViewController.user = user
//        navigationController?.pushViewController(albumCollectionViewController, animated: true)
        
        let albumASCollectionNode = AsyncAlbumController()
        albumASCollectionNode.user = user
        navigationController?.pushViewController(albumASCollectionNode, animated: true)
    }
}


// MARK: - Filter

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            isFiltering = (true, searchText.lowercased())
            filterFriends = friends.filter({ (user) -> Bool in
                (user.name + " " + user.lastname).lowercased().contains(isFiltering.1)
            })
        } else {
            isFiltering.0 = false
        }
        self.tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        self.view.endEditing(true)
        isFiltering = (false, "")
        tableView.reloadData()
    }

}
